import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/bloc/login_bloc.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/bloc/login_state.dart';

class AppNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const AppNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        final role = state.maybeWhen(
          success: (user, _) => user.role,
          orElse: () => 'farmer',
        );

        List<NavigationItem> navigationItems = _getNavigationItems(role);

        return Container(
          height: 85.h,
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              navigationItems.length,
              (index) => _buildNavItem(
                index,
                navigationItems[index].icon,
                navigationItems[index].label,
              ),
            ),
          ),
        );
      },
    );
  }

  List<NavigationItem> _getNavigationItems(String role) {
    switch (role) {
      case 'farmer':
        return [
          NavigationItem(Icons.grid_view_rounded, 'DASHBOARD'),
          NavigationItem(Icons.eco, 'CROPS'),
          NavigationItem(Icons.request_page, 'REQUESTS'),
          NavigationItem(Icons.account_balance_wallet, 'FINANCES'),
        ];
      case 'middlemen':
      case 'trader':
      case 'middleman':
        return [
          NavigationItem(Icons.grid_view_rounded, 'DASHBOARD'),
          NavigationItem(Icons.storefront_rounded, 'MARKET'),
          NavigationItem(Icons.description_rounded, 'CONTRACTS'),
          NavigationItem(Icons.person_rounded, 'ACCOUNT'),
        ];
      case 'consumer':
        return [
          NavigationItem(Icons.grid_view_rounded, 'DASHBOARD'),
          NavigationItem(Icons.storefront_rounded, 'MARKET'),
          NavigationItem(Icons.description_rounded, 'CONTRACTS'),
          NavigationItem(Icons.person_rounded, 'ACCOUNT'),
        ];
      default:
        return [
          NavigationItem(Icons.grid_view_rounded, 'DASHBOARD'),
          NavigationItem(Icons.storefront_rounded, 'MARKET'),
          NavigationItem(Icons.description_rounded, 'CONTRACTS'),
          NavigationItem(Icons.person_rounded, 'ACCOUNT'),
        ];
    }
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = currentIndex == index;
    final themeColor = const Color(0xFF2D5A27);

    return GestureDetector(
      onTap: () => onTap(index),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: isSelected ? themeColor : Colors.transparent,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              icon,
              color: isSelected ? Colors.white : Colors.grey[600],
              size: 24.sp,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
              color: isSelected ? themeColor : Colors.grey[600],
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

class NavigationItem {
  final IconData icon;
  final String label;

  NavigationItem(this.icon, this.label);
}
