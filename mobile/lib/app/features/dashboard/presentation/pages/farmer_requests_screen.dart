import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamrokrishi_app/app/core/di/injection_container.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/bloc/login_bloc.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/bloc/login_state.dart';
import 'package:hamrokrishi_app/app/features/dashboard/presentation/bloc/contract_bloc.dart';
import 'package:hamrokrishi_app/app/features/dashboard/presentation/bloc/contract_event.dart';
import 'package:hamrokrishi_app/app/features/dashboard/presentation/bloc/contract_state.dart';
import 'package:hamrokrishi_app/app/features/dashboard/domain/entities/contract_entity.dart';
import 'package:intl/intl.dart';

class FarmerRequestsScreen extends StatelessWidget {
  const FarmerRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loginState = context.read<LoginBloc>().state;
    final user = loginState.maybeWhen(
      success: (user, _) => user,
      orElse: () => null,
    );

    return BlocProvider(
      create: (context) {
        final bloc = sl<ContractBloc>();
        if (user != null) {
          bloc.add(ContractEvent.fetchUserContracts(
            userId: user.id,
            role: 'farmer',
          ));
        }
        return bloc;
      },
      child: BlocListener<ContractBloc, ContractState>(
        listener: (context, state) {
          state.whenOrNull(
            failure: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(message), backgroundColor: Colors.red),
              );
            },
            success: (_) {
               // Re-fetch after update
              if (user != null) {
                context.read<ContractBloc>().add(ContractEvent.fetchUserContracts(
                  userId: user.id,
                  role: 'farmer',
                ));
              }
            },
          );
        },
        child: Scaffold(
          backgroundColor: const Color(0xFFF9FAF7),
          body: SafeArea(
            child: BlocBuilder<ContractBloc, ContractState>(
              builder: (context, state) {
                return state.maybeWhen(
                  loading: () => const Center(child: CircularProgressIndicator()),
                  contractsLoaded: (contracts) => RefreshIndicator(
                    onRefresh: () async {
                      if (user != null) {
                        context.read<ContractBloc>().add(ContractEvent.fetchUserContracts(
                          userId: user.id,
                          role: 'farmer',
                        ));
                      }
                    },
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 24.h),
                          _buildHeader(),
                          SizedBox(height: 32.h),
                          _buildStatsCards(contracts),
                          SizedBox(height: 32.h),
                          _buildNewRequestsSection(context, contracts),
                          SizedBox(height: 32.h),
                          _buildActiveOrdersSection(contracts),
                          SizedBox(height: 100.h),
                        ],
                      ),
                    ),
                  ),
                  failure: (message) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Error: $message'),
                        ElevatedButton(
                          onPressed: () {
                            if (user != null) {
                              context.read<ContractBloc>().add(ContractEvent.fetchUserContracts(
                                userId: user.id,
                                role: 'farmer',
                              ));
                            }
                          },
                          child: const Text('Retry'),
                        ),
                      ],
                    ),
                  ),
                  orElse: () => const Center(child: CircularProgressIndicator()),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'REQUESTS',
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w800,
            color: Colors.grey[500],
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Buyer Requests',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w900,
            color: const Color(0xFF1B3A1A),
            letterSpacing: -0.5,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Manage incoming orders and negotiations',
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildStatsCards(List<ContractEntity> contracts) {
    final pendingCount = contracts.where((c) => c.status == 'pending').length;
    final activeCount = contracts.where((c) => c.status == 'active').length;
    // For demo, let's say completed are any other status or we just use a placeholder
    final completedCount = contracts.where((c) => c.status == 'completed').length;

    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            'New Requests',
            pendingCount.toString(),
            'Pending',
            const Color(0xFFFF6B6B),
            Icons.notifications_active,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _buildStatCard(
            'Active Orders',
            activeCount.toString(),
            'In progress',
            const Color(0xFF4CAF50),
            Icons.shopping_cart,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _buildStatCard(
            'Completed',
            completedCount.toString(),
            'Historical',
            const Color(0xFF2196F3),
            Icons.check_circle,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    String subtitle,
    Color color,
    IconData icon,
  ) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24.sp),
          SizedBox(height: 8.h),
          Text(
            title,
            style: TextStyle(
              fontSize: 12.sp,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1B3A1A),
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 10.sp,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewRequestsSection(BuildContext context, List<ContractEntity> contracts) {
    final pendingContracts = contracts.where((c) => c.status == 'pending').toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'New Requests',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1B3A1A),
          ),
        ),
        SizedBox(height: 16.h),
        if (pendingContracts.isEmpty)
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Text('No new requests', style: TextStyle(color: Colors.grey[500])),
            ),
          )
        else
          ...pendingContracts.map((contract) => Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: _buildRequestCard(
              context,
              contract,
            ),
          )),
      ],
    );
  }

  Widget _buildRequestCard(
    BuildContext context,
    ContractEntity contract,
  ) {
    const color = Color(0xFFFF6B6B);
    final timeAgo = contract.createdAt != null 
        ? '${DateTime.now().difference(contract.createdAt!).inHours}h ago'
        : 'Recently';

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      contract.traderName ?? 'Unknown Trader',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1B3A1A),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '${contract.quantity}kg ${contract.productName ?? 'Product'}',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  'NEW',
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Rs. ${contract.traderSellingPrice.toStringAsFixed(2)}/kg',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
              Text(
                timeAgo,
                style: TextStyle(
                  fontSize: 10.sp,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    _showConfirmationDialog(
                      context,
                      title: 'Accept Contract?',
                      message: 'Are you sure you want to accept this contract from ${contract.traderName}? This will decrement your product inventory.',
                      confirmText: 'Accept',
                      confirmColor: const Color(0xFF2D5A27),
                      onConfirm: () {
                        context.read<ContractBloc>().add(ContractEvent.updateContractStatus(
                          id: contract.id!,
                          status: 'active',
                        ));
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2D5A27),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text(
                    'Accept',
                    style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    _showConfirmationDialog(
                      context,
                      title: 'Decline Contract?',
                      message: 'Are you sure you want to decline this contract request? This action cannot be undone.',
                      confirmText: 'Decline',
                      confirmColor: Colors.red,
                      onConfirm: () {
                        context.read<ContractBloc>().add(ContractEvent.updateContractStatus(
                          id: contract.id!,
                          status: 'declined',
                        ));
                      },
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: const Color(0xFF2D5A27),
                    side: const BorderSide(color: Color(0xFF2D5A27)),
                    padding: EdgeInsets.symmetric(vertical: 8.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text(
                    'Decline',
                    style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActiveOrdersSection(List<ContractEntity> contracts) {
    final activeContracts = contracts.where((c) => c.status == 'active').toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Active Orders',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1B3A1A),
          ),
        ),
        SizedBox(height: 16.h),
        if (activeContracts.isEmpty)
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Text('No active orders', style: TextStyle(color: Colors.grey[500])),
            ),
          )
        else
          ...activeContracts.map((contract) => Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: _buildOrderCard(
              contract.productName ?? 'Product',
              contract.traderName ?? 'Unknown Trader',
              '${contract.quantity}kg',
              'Target: Rs. ${contract.traderSellingPrice}',
              const Color(0xFF4CAF50),
            ),
          )),
      ],
    );
  }

  Widget _buildOrderCard(
    String product,
    String buyer,
    String progress,
    String delivery,
    Color statusColor,
  ) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1B3A1A),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      buyer,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  'ACTIVE',
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w600,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Progress',
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: Colors.grey[500],
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      progress,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1B3A1A),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Delivery',
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: Colors.grey[500],
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      delivery,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1B3A1A),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showConfirmationDialog(
    BuildContext context, {
    required String title,
    required String message,
    required String confirmText,
    required Color confirmColor,
    required VoidCallback onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w900,
            color: const Color(0xFF1B3A1A),
          ),
        ),
        content: Text(
          message,
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey[600],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: Colors.grey[500],
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              onConfirm();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: confirmColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            child: Text(
              confirmText,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
