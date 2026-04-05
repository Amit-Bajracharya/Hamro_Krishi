import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/bloc/login_bloc.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/bloc/login_state.dart';
import 'package:hamrokrishi_app/app/features/dashboard/presentation/bloc/prediction_bloc.dart';
import 'package:hamrokrishi_app/app/features/dashboard/presentation/pages/farmer_dashboard.dart';
import 'package:hamrokrishi_app/app/features/dashboard/presentation/pages/trader_dashboard.dart';
import 'package:hamrokrishi_app/app/features/dashboard/presentation/pages/consumer_dashboard.dart';
import 'package:hamrokrishi_app/app/core/di/injection_container.dart';
import 'package:hamrokrishi_app/app/features/dashboard/presentation/bloc/weather_bloc.dart';
import 'package:hamrokrishi_app/app/features/dashboard/presentation/bloc/trader_dashboard_bloc.dart';
import 'package:hamrokrishi_app/app/features/dashboard/presentation/bloc/trader_dashboard_event.dart';

class RoleBasedDashboard extends StatelessWidget {
  const RoleBasedDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        // Debug: Print the actual state type and content
        print('🔍 DEBUG: LoginBloc state type: ${state.runtimeType}');
        print('🔍 DEBUG: LoginBloc state toString: ${state.toString()}');
        
        final role = state.maybeWhen(
          success: (user, _) {
            print('🔍 DEBUG: Found user in success state - role: ${user.role}');
            return user.role;
          },
          orElse: () {
            print('🔍 DEBUG: LoginBloc not in success state, defaulting to farmer');
            return 'farmer';
          },
        );

        // Debug: Print the current role to console
        print('🎯 RoleBasedDashboard received role: $role');

        final child = () {
          switch (role) {
            case 'farmer':
              return const FarmerDashboard();
            case 'middleman':
              return BlocProvider(
                create: (context) => sl<TraderDashboardBloc>()..add(const TraderDashboardEvent.fetchData()),
                child: const TraderDashboard(),
              );
            case 'customer':
              return const ConsumerDashboard();
            default:
              print('Unknown role: $role, defaulting to FarmerDashboard');
              return const FarmerDashboard();
          }
        }();

        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => sl<WeatherBloc>()),
            BlocProvider(create: (context) => sl<PredictionBloc>()),
          ],
          child: child,
        );
      },
    );
  }
}
