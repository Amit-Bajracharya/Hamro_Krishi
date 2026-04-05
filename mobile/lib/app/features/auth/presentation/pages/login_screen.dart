import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/bloc/login_bloc.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/bloc/login_event.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/bloc/login_state.dart';
import 'package:hamrokrishi_app/app/routes/route_constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _identityController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _identityController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAF7),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(height: 40.h),
              _buildLogo(),
              SizedBox(height: 24.h),
              _buildHeader(),
              SizedBox(height: 48.h),
              _buildLoginForm(),
              SizedBox(height: 32.h),
              _buildFooter(),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return 
        Image.asset('assets/logo/app.png', width: 85,);
     
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Text(
          'Hamro Krishi',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w900,
            color: const Color(0xFF1B3A1A),
            letterSpacing: -0.5,
          ),
        ),
        Text(
          '"Hamro Krishi Ramro Krishi"',
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: Colors.grey[600],
           
          ),
        ),
        SizedBox(height: 20.h),
        Text(
          'Welcome Back',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1B3A1A),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Access your farm and market insights',
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildLoginForm() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInputLabel('Email'),
          SizedBox(height: 8.h),
          _buildTextField(
            controller: _identityController,
            hint: 'Phone or email address',
            icon: Icons.person_outline,
          ),
          SizedBox(height: 24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInputLabel('Password'),
          
            ],
          ),
          SizedBox(height: 8.h),
          BlocBuilder<LoginBloc, LoginState>(
            buildWhen: (previous, current) => previous.isPasswordHidden != current.isPasswordHidden,
            builder: (context, state) {
              return _buildTextField(
                controller: _passwordController,
                hint: '••••••••',
                icon: Icons.lock_outline,
                isPassword: true,
                obscureText: state.isPasswordHidden,
                onIconTap: () {
                  context.read<LoginBloc>().add(const LoginEvent.togglePasswordVisibility());
                },
              );
            },
          ),
          SizedBox(height: 24.h),
          _buildSubmitButton(),
          SizedBox(height: 24.h),
          _buildTrustIndicator(),
        ],
      ),
    );
  }

  Widget _buildInputLabel(String label) {
    return Text(
      label,
      style: TextStyle(
        fontSize: 11.sp,
        fontWeight: FontWeight.w800,
        color: Colors.grey[500],
        letterSpacing: 1.5,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? onIconTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F6F2),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 12.sp),
          prefixIcon: null,
          suffixIcon: GestureDetector(
            onTap: onIconTap,
            child: Icon(icon, color: Colors.grey[400], size: 18.sp),
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        state.maybeWhen(
          success: (user, _) {
            // Debug: Print user info
            print('Login successful - User: ${user.name}, Role: ${user.role}');
            
            // Route to appropriate dashboard based on user role
            switch (user.role) {
              case 'farmer':
                context.go(AppRoutes.farmerHome);
                break;
              case 'middleman':
                context.go(AppRoutes.traderHome);
                break;
              case 'customer':
                context.go(AppRoutes.consumerHome);
                break;
              default:
                // Default to farmer dashboard if role is unknown
                context.go(AppRoutes.farmerHome);
                break;
            }
          },
          failure: (error, _) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(error)),
          ),
          orElse: () {},
        );
      },
      builder: (context, state) {
        final isLoading = state is Loading;
        return SizedBox(
          width: double.infinity,
          height: 50.h,
          child: ElevatedButton(
            onPressed: isLoading
                ? null
                : () {
                    context.read<LoginBloc>().add(LoginEvent.loginSubmitted(
                          identity: _identityController.text,
                          password: _passwordController.text,
                        ));
                  },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2D5A27),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.r),
              ),
              elevation: 0,
            ),
            child: isLoading
                ? SizedBox(
                    height: 20.h,
                    width: 20.h,
                    child: const CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Enter Hamro Krishi',
                        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 8.w),
                      Icon(Icons.arrow_forward, size: 20.sp),
                    ],
                  ),
          ),
        );
      },
    );
  }

  Widget _buildTrustIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.verified, color: const Color(0xFF1B3A1A), size: 16.sp),
        SizedBox(width: 8.w),
        Text(
          'Trusted by 50,000+ Nepalese farmers',
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.grey[600],
            letterSpacing: 0.2,
          ),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'New to Hamro Krishi? ',
              style: TextStyle(fontSize: 13.sp, color: Colors.grey[600]),
            ),
            GestureDetector(
              onTap: () {
                context.push(AppRoutes.registerRole);
              },
              child: Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2D5A27),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 48.h),
       
      ],
    );
  }
}
