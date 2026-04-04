import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/bloc/login_bloc.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/bloc/login_state.dart';
import 'package:hamrokrishi_app/app/features/dashboard/presentation/widgets/navigation/farmer_navigation_bar.dart';
import 'package:hamrokrishi_app/app/features/dashboard/presentation/widgets/navigation/trader_navigation_bar.dart';
import 'package:hamrokrishi_app/app/features/dashboard/presentation/widgets/navigation/consumer_navigation_bar.dart';


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
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        final role = state.maybeWhen(
          success: (user, _) => user.role,
          orElse: () => 'farmer',
        );

        // Calculate mapped index for highlighting
        int mappedIndex = 0;

        // Return the appropriate navigation bar based on role
        switch (role) {
          case 'farmer':
            if (navigationShell.currentIndex == 0) {
              mappedIndex = 0;
            } else if (navigationShell.currentIndex == 4) {
              mappedIndex = 1;
            } else if (navigationShell.currentIndex == 5) {
              mappedIndex = 2;
            } else if (navigationShell.currentIndex == 6) {
              mappedIndex = 3;
            }

            
            return FarmerNavigationBar(
              currentIndex: mappedIndex,
              onTap: (index) => _onTap(context, index),
            );
          case 'middlemen':
          case 'trader':
          case 'middleman':
            mappedIndex = navigationShell.currentIndex <= 3 ? navigationShell.currentIndex : 0;
            return TraderNavigationBar(
              currentIndex: mappedIndex,
              onTap: (index) => _onTap(context, index),
            );
          case 'consumer':
            mappedIndex = navigationShell.currentIndex <= 3 ? navigationShell.currentIndex : 0;
            return ConsumerNavigationBar(
              currentIndex: mappedIndex,
              onTap: (index) => _onTap(context, index),
            );
          default:
            return FarmerNavigationBar(
              currentIndex: navigationShell.currentIndex,
              onTap: (index) => _onTap(context, index),
            );
        }

      },
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
    final role = context.read<LoginBloc>().state.maybeWhen(
      success: (user, _) => user.role,
      orElse: () => 'farmer',
    );

    // Navigate based on role and index
    switch (role) {
      case 'farmer':
        _navigateFarmer(context, index);
        break;
      case 'middlemen':
      case 'trader':
      case 'middleman':
        _navigateTrader(context, index);
        break;
      case 'consumer':
        _navigateConsumer(context, index);
        break;
      default:
        _navigateFarmer(context, index);
    }
  }

  void _navigateFarmer(BuildContext context, int index) {
    switch (index) {
      case 0:
        navigationShell.goBranch(0);
        break;
      case 1:
        navigationShell.goBranch(4);
        break;
      case 2:
        navigationShell.goBranch(5);
        break;
      case 3:
        navigationShell.goBranch(6);
        break;
    }
  }

  void _navigateTrader(BuildContext context, int index) {
    switch (index) {
      case 0:
        navigationShell.goBranch(0);
        break;
      case 1:
        navigationShell.goBranch(1);
        break;
      case 2:
        navigationShell.goBranch(2);
        break;
      case 3:
        navigationShell.goBranch(3);
        break;
    }
  }

  void _navigateConsumer(BuildContext context, int index) {
    switch (index) {
      case 0:
        navigationShell.goBranch(0);
        break;
      case 1:
        navigationShell.goBranch(1);
        break;
      case 2:
        navigationShell.goBranch(2);
        break;
      case 3:
        navigationShell.goBranch(3);
        break;
    }
  }

}
