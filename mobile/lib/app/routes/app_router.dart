import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hamrokrishi_app/app/core/di/injection_container.dart';
import 'package:hamrokrishi_app/app/features/dashboard/presentation/pages/navigation_shell.dart';
import 'package:hamrokrishi_app/app/features/dashboard/presentation/pages/role_based_dashboard.dart';
import 'package:hamrokrishi_app/app/features/dashboard/presentation/pages/farmer_crops_screen.dart';
import 'package:hamrokrishi_app/app/features/dashboard/presentation/pages/farmer_requests_screen.dart';
import 'package:hamrokrishi_app/app/features/dashboard/presentation/pages/farmer_finances_screen.dart';
import 'package:hamrokrishi_app/app/features/product/presentation/pages/list_harvest_screen.dart';
import 'package:hamrokrishi_app/app/features/product/presentation/bloc/product_bloc.dart';

import 'package:hamrokrishi_app/app/features/market/presentation/pages/trader_market_screen.dart';
import 'package:hamrokrishi_app/app/features/market/presentation/bloc/trader_market_bloc.dart';
import 'package:hamrokrishi_app/app/features/market/presentation/bloc/trader_market_event.dart';
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
      path: AppRoutes.middlewareRegister,
      builder: (context, state) => const MiddlewareRegisterScreen(),
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
        // Branch 0: Shared Home (Dashboard)
        StatefulShellBranch(
          initialLocation: AppRoutes.farmerHome,
          routes: [
            GoRoute(
              path: AppRoutes.farmerHome,
              builder: (context, state) => const RoleBasedDashboard(),
            ),
            GoRoute(
              path: AppRoutes.traderHome,
              builder: (context, state) => const RoleBasedDashboard(),
            ),
            GoRoute(
              path: AppRoutes.consumerHome,
              builder: (context, state) => const RoleBasedDashboard(),
            ),
          ],
        ),
        // Branch 1: Market (Trader/Consumer)
        StatefulShellBranch(
          initialLocation: AppRoutes.market,
          routes: [
            GoRoute(
              path: AppRoutes.market,
              builder: (context, state) => BlocProvider(
                create: (context) => sl<TraderMarketBloc>()..add(const TraderMarketEvent.fetchData()),
                child: const TraderMarketScreen(),
              ),
            ),
          ],
        ),
        // Branch 2: Contracts (Trader/Consumer)
        StatefulShellBranch(
          initialLocation: AppRoutes.contracts,
          routes: [
            GoRoute(
              path: AppRoutes.contracts,
              builder: (context, state) => const ContractsScreen(),
            ),
          ],
        ),
        // Branch 3: Account (Trader/Consumer)
        StatefulShellBranch(
          initialLocation: AppRoutes.account,
          routes: [
            GoRoute(
              path: AppRoutes.account,
              builder: (context, state) => const AccountScreen(),
            ),
          ],
        ),
        // Branch 4: Farmer Crops
        StatefulShellBranch(
          initialLocation: AppRoutes.farmerCrops,
          routes: [
            GoRoute(
              path: AppRoutes.farmerCrops,
              builder: (context, state) => BlocProvider(
                create: (context) => sl<ProductBloc>(),
                child: const FarmerCropsScreen(),
              ),
              routes: [
                GoRoute(
                  path: 'list-harvest',
                  builder: (context, state) => BlocProvider(
                    create: (context) => sl<ProductBloc>(),
                    child: const ListHarvestScreen(),
                  ),
                ),
              ],
            ),
          ],
        ),
        // Branch 5: Farmer Requests
        StatefulShellBranch(
          initialLocation: AppRoutes.farmerRequests,
          routes: [
            GoRoute(
              path: AppRoutes.farmerRequests,
              builder: (context, state) => const FarmerRequestsScreen(),
            ),
          ],
        ),
        // Branch 6: Farmer Finances
        StatefulShellBranch(
          initialLocation: AppRoutes.farmerFinances,
          routes: [
            GoRoute(
              path: AppRoutes.farmerFinances,
              builder: (context, state) => const FarmerFinancesScreen(),
            ),
          ],
        ),

      ],
    ),
  ],
);
