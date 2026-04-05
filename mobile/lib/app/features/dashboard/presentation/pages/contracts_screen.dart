import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamrokrishi_app/app/core/di/injection_container.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/bloc/login_bloc.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/bloc/login_state.dart';
import 'package:hamrokrishi_app/app/features/dashboard/domain/entities/contract_entity.dart';
import 'package:hamrokrishi_app/app/features/dashboard/presentation/bloc/contract_bloc.dart';
import 'package:hamrokrishi_app/app/features/dashboard/presentation/bloc/contract_event.dart';
import 'package:hamrokrishi_app/app/features/dashboard/presentation/bloc/contract_state.dart';
import 'package:intl/intl.dart';

class ContractsScreen extends StatelessWidget {
  const ContractsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final LoginState authState = context.read<LoginBloc>().state;
        final user = authState.maybeWhen(
          success: (user, _) => user,
          orElse: () => null,
        );
        
        final bloc = sl<ContractBloc>();
        if (user != null) {
          bloc.add(ContractEvent.fetchUserContracts(
            userId: user.id,
            role: user.role,
          ));
        }
        return bloc;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF9FAF7),
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24.h),
                Text(
                  'CONTRACTS',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w800,
                    color: Colors.grey[500],
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Management',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w900,
                    color: const Color(0xFF1B3A1A),
                    letterSpacing: -0.5,
                  ),
                ),
                SizedBox(height: 20.h),
                Expanded(
                  child: BlocListener<ContractBloc, ContractState>(
                    listener: (context, state) {
                      state.whenOrNull(
                        success: (contract) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Contract status updated!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                          // Refresh the list
                          final user = context.read<LoginBloc>().state.maybeWhen(
                                success: (user, _) => user,
                                orElse: () => null,
                              );
                          if (user != null) {
                            context.read<ContractBloc>().add(ContractEvent.fetchUserContracts(
                                  userId: user.id,
                                  role: user.role,
                                ));
                          }
                        },
                        failure: (message) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Error: $message'),
                              backgroundColor: Colors.red,
                            ),
                          );
                        },
                      );
                    },
                    child: BlocBuilder<ContractBloc, ContractState>(
                      builder: (context, state) {
                        return state.maybeWhen(
                          loading: () => const Center(
                            child: CircularProgressIndicator(color: Color(0xFF2D5A27)),
                          ),
                          contractsLoaded: (contracts) => contracts.isEmpty
                              ? _buildEmptyState()
                              : _buildContractList(contracts),
                          failure: (message) => Center(
                            child: Text(
                              'Error: $message',
                              style: const TextStyle(color: Colors.red),
                            ),
                          ),
                          orElse: () => const Center(
                            child: CircularProgressIndicator(color: Color(0xFF2D5A27)),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: const Color(0xFF2D5A27).withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.description_rounded,
              size: 48.sp,
              color: const Color(0xFF2D5A27),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'No Active Contracts',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1B3A1A),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'You don\'t have any digital contracts yet.\nTraders can initiate contracts from the Market.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContractList(List<ContractEntity> contracts) {
    return ListView.separated(
      itemCount: contracts.length,
      separatorBuilder: (context, index) => SizedBox(height: 16.h),
      padding: EdgeInsets.only(bottom: 24.h),
      itemBuilder: (context, index) {
        final contract = contracts[index];
        return _buildContractCard(context, contract);
      },
    );
  }

  Widget _buildContractCard(BuildContext context, ContractEntity contract) {
    final authState = context.read<LoginBloc>().state;
    final isFarmer = authState.maybeWhen(
      success: (user, _) => user.role == 'farmer',
      orElse: () => false,
    );
    final isPending = contract.status.toLowerCase() == 'pending';
    
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Agreement #${(contract.id ?? "").substring(0, 8).toUpperCase()}',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[400],
                ),
              ),
              _buildStatusBadge(contract.status),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF2D5A27).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.handshake_rounded,
                  color: const Color(0xFF2D5A27),
                  size: 24.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Quantity: ${contract.quantity} units',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1B3A1A),
                      ),
                    ),
                    Text(
                      'Target Market Price',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Rs. ${contract.traderSellingPrice}',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF2D5A27),
                    ),
                  ),
                  Text(
                    'per unit',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Divider(color: Colors.grey[100]),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInfoColumn('Farmer Price', 'Rs. ${contract.farmerSellingPrice}'),
              _buildInfoColumn('Start Date', DateFormat('MMM dd, yyyy').format(contract.startDate)),
              _buildInfoColumn('Expiry Date', contract.expiryDate != null ? DateFormat('MMM d, yyyy').format(contract.expiryDate!) : 'Not Set'),
            ],
          ),
          if (isFarmer && isPending) ...[
            SizedBox(height: 20.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      context.read<ContractBloc>().add(ContractEvent.updateContractStatus(
                            id: contract.id ?? '',
                            status: 'declined',
                          ));
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                    ),
                    child: const Text('Decline'),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<ContractBloc>().add(ContractEvent.updateContractStatus(
                            id: contract.id ?? '',
                            status: 'active',
                          ));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2D5A27),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                    ),
                    child: const Text('Accept'),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color color;
    switch (status.toLowerCase()) {
      case 'active':
        color = const Color(0xFF2D5A27);
        break;
      case 'pending':
        color = Colors.blue;
        break;
      case 'declined':
        color = Colors.red;
        break;
      case 'expired':
        color = Colors.orange;
        break;
      case 'terminated':
        color = Colors.red;
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(6.r),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w800,
          color: color,
        ),
      ),
    );
  }

  Widget _buildInfoColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.bold,
            color: Colors.grey[400],
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 13.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1B3A1A),
          ),
        ),
      ],
    );
  }
}
