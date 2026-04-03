import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hamrokrishi_app/app/core/di/injection_container.dart';
import 'package:hamrokrishi_app/app/features/home/home.dart';
import 'package:hamrokrishi_app/app/features/introduction_screen/presentation/pages/introduction_screen.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/pages/login_screen.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/bloc/login_bloc.dart';
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
      path: AppRoutes.home,
      builder: (context, state) => const Home(),
    ),
  ],
);
