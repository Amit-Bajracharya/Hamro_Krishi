import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NavigationItem {
  final IconData icon;
  final String label;

  NavigationItem(this.icon, this.label);
}

class TraderNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

   TraderNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
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
          _navigationItems.length,
          (index) => _buildNavItem(
            index,
            _navigationItems[index].icon,
            _navigationItems[index].label,
          ),
        ),
      ),
    );
  }

  final List<NavigationItem> _navigationItems = [
    NavigationItem(Icons.grid_view_rounded, 'DASHBOARD'),
    NavigationItem(Icons.storefront_rounded, 'MARKET'),
    NavigationItem(Icons.description_rounded, 'CONTRACTS'),
    NavigationItem(Icons.person_rounded, 'ACCOUNT'),
  ];

  Widget _buildNavItem(int index, IconData icon, String label) {
    final isSelected = currentIndex == index;
    
    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 24.sp,
            color: isSelected ? const Color(0xFF2D5A27) : Colors.grey[400],
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              color: isSelected ? const Color(0xFF2D5A27) : Colors.grey[400],
            ),
          ),
        ],
      ),
    );
  }
}
