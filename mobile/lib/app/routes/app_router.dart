import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hamrokrishi_app/app/core/di/injection_container.dart';
import 'package:hamrokrishi_app/app/features/dashboard/presentation/pages/navigation_shell.dart';
import 'package:hamrokrishi_app/app/features/dashboard/presentation/pages/role_based_dashboard.dart';
import 'package:hamrokrishi_app/app/features/dashboard/presentation/pages/market_screen.dart';
import 'package:hamrokrishi_app/app/features/dashboard/presentation/pages/contracts_screen.dart';
import 'package:hamrokrishi_app/app/features/dashboard/presentation/pages/account_screen.dart';
import 'package:hamrokrishi_app/app/features/introduction_screen/presentation/pages/introduction_screen.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/pages/login_screen.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/pages/register_role_screen.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/pages/farmer_register_screen.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/pages/trader_register_screen.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/pages/consumer_register_screen.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/pages/middleware_register_screen.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/bloc/login_bloc.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/bloc/register_farmer_bloc.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/bloc/register_trader_bloc.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/bloc/register_consumer_bloc.dart';
import 'package:hamrokrishi_app/app/routes/route_constants.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: AppRoutes.introduction,
  routes: [
    // Auth Routes (Outside Shell)
    GoRoute(
      path: AppRoutes.introduction,
      builder: (context, state) => const IntroductionScreen(),
    ),
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => BlocProvider.value(
        value: sl<LoginBloc>(),
        child: const LoginScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.registerRole,
      builder: (context, state) => const RegisterRoleScreen(),
    ),
   
    GoRoute(
      path: AppRoutes.farmerRegister,
      builder: (context, state) => BlocProvider(
        create: (context) => sl<RegisterFarmerBloc>(),
        child: const FarmerRegisterScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.traderRegister,
      builder: (context, state) => BlocProvider(
        create: (context) => sl<RegisterTraderBloc>(),
        child: const TraderRegisterScreen(),
      ),
    ),
   
    GoRoute(
      path: AppRoutes.consumerRegister,
      builder: (context, state) => BlocProvider(
        create: (context) => sl<RegisterConsumerBloc>(),
        child: const ConsumerRegisterScreen(),
      ),
    ),
   

    // Dashboard Shell (Includes multiple tabs)
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return BlocProvider.value(
          value: sl<LoginBloc>(),
          child: NavigationShell(navigationShell: navigationShell),
        );
      },
      branches: [
        StatefulShellBranch(
          initialLocation: AppRoutes.farmerHome,
          routes: [
            GoRoute(
              path: AppRoutes.farmerHome, 
              builder: (context, state) => const RoleBasedDashboard(),
            ),
          ],
        ),
        StatefulShellBranch(
          initialLocation: '/market',
          routes: [
            GoRoute(
              path: '/market',
              builder: (context, state) => const MarketScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          initialLocation: '/contracts',
          routes: [
            GoRoute(
              path: '/contracts',
              builder: (context, state) => const ContractsScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          initialLocation: '/account',
          routes: [
            GoRoute(
              path: '/account',
              builder: (context, state) => const AccountScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);
