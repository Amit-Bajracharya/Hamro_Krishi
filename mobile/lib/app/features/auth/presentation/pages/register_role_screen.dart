import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hamrokrishi_app/app/routes/route_constants.dart';

class RegisterRoleScreen extends StatefulWidget {
  const RegisterRoleScreen({super.key});

  @override
  State<RegisterRoleScreen> createState() => _RegisterRoleScreenState();
}

class _RegisterRoleScreenState extends State<RegisterRoleScreen> {
  int _selectedRoleIndex = 0;

  final List<Map<String, dynamic>> _roles = [
    {
      'title': 'Farmer (Kisan)',
      
      'icon': Icons.agriculture,
      'iconBg': const Color(0xFFC8E6C9),
      'iconColor': const Color(0xFF2E7D32),
      'barColor': const Color(0xFF2E7D32),
      
    },
    {
      'title': 'Trader (Vyapari)',
      
      'icon': Icons.handshake_outlined,
      'iconBg': const Color(0xFFFFE0B2),
      'iconColor': const Color(0xFFEF6C00),
      'barColor': const Color(0xFFEF6C00),
      'image': 'assets/images/role_trader.png',
    },
    {
      'title': 'Consumer (Grahak)',
      
      'icon': Icons.shopping_basket_outlined,
      'iconBg': const Color(0xFFF0F4C3),
      'iconColor': const Color(0xFF9E9D24),
      'barColor': const Color(0xFF33691E),
      'image': 'assets/images/role_consumer.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAF7),
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24.h),
                    _buildTitle(),
                   
                    SizedBox(height: 32.h),
                    ...List.generate(_roles.length, (index) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 16.h),
                        child: _RoleCard(
                          role: _roles[index],
                          isSelected: _selectedRoleIndex == index,
                          onTap: () => setState(() => _selectedRoleIndex = index),
                        ),
                      );
                    }),
                    SizedBox(height: 32.h),
                   
                    SizedBox(height: 32.h),
                    _buildActionButton(),
                    SizedBox(height: 24.h),
                    _buildFooter(context),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset('assets/logo/app.png',
              width: 50,),
              SizedBox(width: 25),

              Text(
                'Hamro Krishi',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF2D5A27),
                ),
              ),
            ],
          ),
         
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Connect to the',
          style: TextStyle(
            fontSize: 25.sp,
            fontWeight: FontWeight.w900,
            color: const Color(0xFF1B3A1A),
            height: 1.1,
          ),
        ),
        Text(
          'Roots',
          style: TextStyle(
            fontSize: 25.sp,
            fontWeight: FontWeight.w900,
            color: const Color(0xFF9E541A),
            height: 1.1,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton() {
    return SizedBox(
      width: double.infinity,
      height: 50.h,
      child: ElevatedButton(
        onPressed: () {
          if (_selectedRoleIndex == 0) {
            context.push(AppRoutes.farmerRegister);
          } else if (_selectedRoleIndex == 1) {
            context.push(AppRoutes.traderRegister);
          } else if (_selectedRoleIndex == 2) {
            context.push(AppRoutes.consumerRegister);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1B3A1A),
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32.r),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Register',
              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 8.w),
            Icon(Icons.arrow_forward, size: 22.sp),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'HAVE AN ACCOUNT? ',
          style: TextStyle(fontSize: 12.sp, color: Colors.grey[500], fontWeight: FontWeight.bold, letterSpacing: 1),
        ),
        GestureDetector(
          onTap: () => context.go(AppRoutes.login),
          child: Text(
            'SIGN IN',
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w900,
              color: Colors.black,
              letterSpacing: 1,
            ),
          ),
        ),
      ],
    );
  }
}

class _RoleCard extends StatelessWidget {
  final Map<String, dynamic> role;
  final bool isSelected;
  final VoidCallback onTap;

  const _RoleCard({
    required this.role,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        height: 95.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(
            color: isSelected ? role['iconColor'] : Colors.transparent,
            width: 2,
          ),
         
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22.r),
          child: Stack(
            children: [
            
              Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                      padding: EdgeInsets.all(10.w),
                      decoration: BoxDecoration(
                        color: role['iconBg'],
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(role['icon'], color: role['iconColor'], size: 24.sp),
                    ),
                     SizedBox(width: 14.w),
                            Text(
                              role['title'],
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF1B3A1A),
                              ),
                            ),
                          ],
                        ),
                       SizedBox(height: 2.w),
                        
                      ],
                    ),
                    Container(
                      width: 40.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: role['barColor'],
                        borderRadius: BorderRadius.circular(2.r),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
