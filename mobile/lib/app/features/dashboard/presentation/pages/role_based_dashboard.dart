import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/bloc/login_bloc.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/bloc/login_state.dart';
import 'package:hamrokrishi_app/app/features/dashboard/presentation/pages/farmer_dashboard.dart';
import 'package:hamrokrishi_app/app/features/dashboard/presentation/pages/trader_dashboard.dart';
import 'package:hamrokrishi_app/app/features/dashboard/presentation/pages/consumer_dashboard.dart';

class RoleBasedDashboard extends StatelessWidget {
  const RoleBasedDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        final role = state.maybeWhen(
          success: (user, _) => user.role,
          orElse: () => 'farmer', // Default for now
        );

        // Debug: Print the current role to console
        print('Current role in RoleBasedDashboard: $role');

        switch (role) {
          case 'farmer':
            return const FarmerDashboard();
          case 'middlemen':
          case 'trader':
            return const TraderDashboard();
          case 'middleman':
            return const TraderDashboard();
          case 'consumer':
            return const ConsumerDashboard();
          default:
            print('Unknown role: $role, defaulting to FarmerDashboard');
            return const FarmerDashboard();
        }
      },
    );
  }
}
