import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hamrokrishi_app/app/core/di/injection_container.dart';
import 'package:hamrokrishi_app/app/features/home/home.dart';
import 'package:hamrokrishi_app/app/features/introduction_screen/presentation/pages/introduction_screen.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/pages/login_screen.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/pages/register_role_screen.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/pages/farmer_register_screen.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/pages/trader_register_screen.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/pages/consumer_register_screen.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/bloc/login_bloc.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/bloc/register_farmer_bloc.dart';
import 'package:hamrokrishi_app/app/routes/route_constants.dart';

final GoRouter router = GoRouter(
  initialLocation: AppRoutes.introduction,
  routes: [
    GoRoute(
      path: AppRoutes.introduction,
      builder: (context, state) => const IntroductionScreen(),
    ),
    GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => BlocProvider(
        create: (context) => sl<LoginBloc>(),
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
      builder: (context, state) => const TraderRegisterScreen(),
    ),
    GoRoute(
      path: AppRoutes.consumerRegister,
      builder: (context, state) => const ConsumerRegisterScreen(),
    ),
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const Home(),
    ),
  ],
);
