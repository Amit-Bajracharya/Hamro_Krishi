import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hamrokrishi_app/app/routes/route_constants.dart';

class ConsumerRegisterScreen extends StatefulWidget {
  const ConsumerRegisterScreen({super.key});

  @override
  State<ConsumerRegisterScreen> createState() => _ConsumerRegisterScreenState();
}

class _ConsumerRegisterScreenState extends State<ConsumerRegisterScreen> {
  final TextEditingController _identityController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordHidden = true;

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
          'Customer Register',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1B3A1A),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Join us to get fresh farm products',
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
            controller: TextEditingController(),
            hint: 'Your Name',
            icon: Icons.person_outline,
          ),
          SizedBox(height: 24.h),
          _buildInputLabel('Email or Phone'),
          SizedBox(height: 8.h),
          _buildTextField(
            controller: _identityController,
            hint: 'Phone or email address',
            icon: Icons.contact_mail_outlined,
          ),
          SizedBox(height: 24.h),
          _buildInputLabel('Password'),
          SizedBox(height: 8.h),
          _buildTextField(
            controller: _passwordController,
            hint: '••••••••',
            icon: Icons.lock_outline,
            isPassword: true,
            obscureText: _isPasswordHidden,
            onIconTap: () {
              setState(() {
                _isPasswordHidden = !_isPasswordHidden;
              });
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
    return SizedBox(
      width: double.infinity,
      height: 50.h,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2D5A27),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          elevation: 0,
        ),
        child: Row(
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
  }

  Widget _buildTrustIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.verified, color: const Color(0xFF1B3A1A), size: 16.sp),
        SizedBox(width: 8.w),
        Text(
          'Trusted by thousands of customers',
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
