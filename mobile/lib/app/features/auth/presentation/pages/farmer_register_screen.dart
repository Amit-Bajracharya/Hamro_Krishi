import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/bloc/register_farmer_bloc.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/bloc/register_farmer_event.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/bloc/register_farmer_state.dart';
import 'package:hamrokrishi_app/app/routes/route_constants.dart';

class FarmerRegisterScreen extends StatefulWidget {
  const FarmerRegisterScreen({super.key});

  @override
  State<FarmerRegisterScreen> createState() => _FarmerRegisterScreenState();
}

class _FarmerRegisterScreenState extends State<FarmerRegisterScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<RegisterFarmerBloc>().add(const RegisterFarmerEvent.fetchLocation());
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAF7),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(height: 10.h),
              _buildLogo(),
              SizedBox(height: 24.h),
              _buildHeader(),
              SizedBox(height: 48.h),
              _buildRegisterForm(),
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
    return Image.asset('assets/logo/app.png', width: 85);
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
          'Farmers Register',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1B3A1A),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Join us to connect with buyers directly',
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildRegisterForm() {
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
          _buildInputLabel('Full Name'),
          SizedBox(height: 8.h),
          _buildTextField(
            controller: _nameController,
            hint: 'Your Name',
            icon: Icons.person_outline,
          ),
          SizedBox(height: 16.h),
          _buildInputLabel('Email Address'),
          SizedBox(height: 8.h),
          _buildTextField(
            controller: _emailController,
            hint: 'your.email@example.com',
            icon: Icons.email_outlined,
          ),
          SizedBox(height: 16.h),
          _buildInputLabel('Phone Number'),
          SizedBox(height: 8.h),
          _buildTextField(
            controller: _phoneController,
            hint: 'e.g. +977 9800000000',
            icon: Icons.phone_outlined,
          ),
          SizedBox(height: 16.h),
          SizedBox(height: 16.h),
          _buildLocationStatus(),
          SizedBox(height: 16.h),
          _buildInputLabel('Password'),
          SizedBox(height: 8.h),
          BlocBuilder<RegisterFarmerBloc, RegisterFarmerState>(
            buildWhen: (previous, current) => previous.isPasswordHidden != current.isPasswordHidden,
            builder: (context, state) {
              return _buildTextField(
                controller: _passwordController,
                hint: '••••••••',
                icon: Icons.lock_outline,
                isPassword: true,
                obscureText: state.isPasswordHidden,
                onIconTap: () {
                  context.read<RegisterFarmerBloc>().add(const RegisterFarmerEvent.togglePasswordVisibility());
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
    return BlocConsumer<RegisterFarmerBloc, RegisterFarmerState>(
      listener: (context, state) {
        state.maybeWhen(
          success: (isHidden, lat, lng, isLocLoading) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Registered successfully! Please check your email for verification.')),
            );
            context.go(AppRoutes.login);
          },
          failure: (error, isHidden, lat, lng, isLocLoading) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(error), backgroundColor: Colors.red),
            );
          },
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
                    final currentState = context.read<RegisterFarmerBloc>().state;
                    
                    if (_nameController.text.isEmpty ||
                        _emailController.text.isEmpty ||
                        _passwordController.text.isEmpty ||
                        _phoneController.text.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please fill all fields')),
                      );
                      return;
                    }

                    if (currentState.latitude == null || currentState.longitude == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please wait for location to be captured')),
                      );
                      return;
                    }

                    context.read<RegisterFarmerBloc>().add(
                          RegisterFarmerEvent.registerSubmitted(
                            name: _nameController.text,
                            email: _emailController.text,
                            password: _passwordController.text,
                            phone: _phoneController.text,
                            latitude: currentState.latitude!,
                            longitude: currentState.longitude!,
                          ),
                        );
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
                        'Register',
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

  Widget _buildLocationStatus() {
    return BlocBuilder<RegisterFarmerBloc, RegisterFarmerState>(
      buildWhen: (previous, current) => 
          previous.isLocationLoading != current.isLocationLoading || 
          previous.latitude != current.latitude,
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: const Color(0xFFF5F6F2),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: state.latitude != null ? const Color(0xFF2D5A27).withValues(alpha: 0.2) : Colors.transparent,
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: state.latitude != null ? const Color(0xFF2D5A27) : Colors.grey[300],
                  shape: BoxShape.circle,
                ),
                child: state.isLocationLoading
                    ? SizedBox(
                        width: 16.sp,
                        height: 16.sp,
                        child: const CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : Icon(
                        state.latitude != null ? Icons.check : Icons.location_on_outlined,
                        size: 16.sp,
                        color: Colors.white,
                      ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.latitude != null ? 'Location Captured' : 'GPS Location',
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1B3A1A),
                      ),
                    ),
                    Text(
                      state.isLocationLoading 
                          ? 'Fetching coordinates...' 
                          : state.latitude != null 
                              ? 'Lat: ${state.latitude!.toStringAsFixed(4)}, Long: ${state.longitude!.toStringAsFixed(4)}'
                              : 'Tap to refresh location',
                      style: TextStyle(fontSize: 11.sp, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
              if (!state.isLocationLoading)
                IconButton(
                  onPressed: () {
                    context.read<RegisterFarmerBloc>().add(const RegisterFarmerEvent.fetchLocation());
                  },
                  icon: Icon(Icons.refresh, size: 18.sp, color: const Color(0xFF2D5A27)),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFooter() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Already have an account? ',
              style: TextStyle(fontSize: 13.sp, color: Colors.grey[600]),
            ),
            GestureDetector(
              onTap: () {
                context.push(AppRoutes.login);
              },
              child: Text(
                'Sign In',
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2D5A27),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
