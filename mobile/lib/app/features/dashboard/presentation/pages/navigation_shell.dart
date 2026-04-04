import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/bloc/login_bloc.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/bloc/login_state.dart';
import 'package:hamrokrishi_app/app/features/dashboard/presentation/widgets/app_navigation_bar.dart';

class NavigationShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const NavigationShell({
    super.key,
    required this.navigationShell,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAF7),
      appBar: _buildAppBar(context),
      body: navigationShell,
      bottomNavigationBar: AppNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) => _onTap(context, index),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
      leading: Padding(
        padding: EdgeInsets.only(left: 16.w),
        child: Image.asset('assets/logo/app.png', width: 32.sp),
      ),
      leadingWidth: 48.w,
      title: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          final role = state.maybeWhen(
            success: (user, _) => user.role,
            orElse: () => 'farmer',
          );

          String title;
          switch (role) {
            case 'farmer':
              title = 'Farmer Dashboard';
              break;
            case 'trader':
              title = 'Trader Dashboard';
              break;
            case 'consumer':
              title = 'Consumer Dashboard';
              break;
            default:
              title = 'Dashboard';
          }

          return Text(
            title,
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1B3A1A),
            ),
          );
        },
      ),
      actions: [
        IconButton(
          onPressed: () {
            // Notifications coming soon
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Notifications coming soon!')),
            );
          },
          icon: Icon(
            Icons.notifications_none_rounded,
            color: const Color(0xFF1B3A1A),
            size: 26.sp,
          ),
        ),
        SizedBox(width: 8.w),
      ],
    );
  }

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }
}
