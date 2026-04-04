import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/bloc/login_bloc.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/bloc/login_state.dart';
import 'package:hamrokrishi_app/app/features/dashboard/presentation/bloc/trader_dashboard_bloc.dart';
import 'package:hamrokrishi_app/app/features/dashboard/presentation/bloc/trader_dashboard_state.dart';
import 'package:hamrokrishi_app/app/features/product/domain/entities/product_entity.dart';

class TraderDashboard extends StatelessWidget {
  const TraderDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAF7),
      body: SafeArea(
        child: BlocBuilder<TraderDashboardBloc, TraderDashboardState>(
          builder: (context, state) {
            return state.when(
              initial: () => const Center(child: CircularProgressIndicator()),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (message) => Center(child: Text('Error: $message')),
              loaded: (farmerCount, products) => SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24.h),
                    _buildHeader(context),
                    SizedBox(height: 32.h),
                    _buildStatsCards(farmerCount),
                    SizedBox(height: 32.h),
                    _buildContractsSection(),
                    SizedBox(height: 32.h),
                    _buildOpportunitiesSection(products),
                    SizedBox(height: 100.h), // Space for bottom navigation
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final userName = context.read<LoginBloc>().state.maybeWhen(
          success: (user, _) => user.name,
          orElse: () => 'Trader',
        );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'EDITORIAL AGRONOMY',
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w800,
            color: Colors.grey[500],
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Good morning, $userName',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w900,
            color: const Color(0xFF1B3A1A),
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsCards(int farmerCount) {
    return Column(
      children: [
        _buildActiveFarmersCard(farmerCount),
        SizedBox(height: 16.h),
        _buildInventoryCard(),
      ],
    );
  }

  Widget _buildActiveFarmersCard(int count) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF2D5A27).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(
                  Icons.people_outline,
                  color: const Color(0xFF2D5A27),
                  size: 24.sp,
                ),
              ),
              const Spacer(),
              Icon(Icons.more_vert, color: Colors.grey[400], size: 20.sp),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            'Active Farmers',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            count.toString(),
            style: TextStyle(
              fontSize: 32.sp,
              fontWeight: FontWeight.w900,
              color: const Color(0xFF1B3A1A),
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Icon(Icons.trending_up, color: Colors.green, size: 16.sp),
              SizedBox(width: 4.w),
              Text(
                '8.2% from last month',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1B3A1A),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInventoryCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: const Color(0xFF3D6B3A),
        borderRadius: BorderRadius.circular(32.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.inventory_2_outlined, color: Colors.white.withOpacity(0.8), size: 28.sp),
          SizedBox(height: 16.h),
          Text(
            'TOTAL INVENTORY',
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w800,
              color: Colors.white.withOpacity(0.6),
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            '48,291 kg',
            style: TextStyle(
              fontSize: 36.sp,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: _buildCropItem('Wheat', '32,450 kg', Colors.white),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: _buildCropItem('Barley', '15,841 kg', Colors.white70),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCropItem(String name, String amount, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: color.withOpacity(0.8),
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          amount,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }

  Widget _buildContractsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Active Contracts',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1B3A1A),
          ),
        ),
        SizedBox(height: 16.h),
        _buildContractCard('In Transit', 12, Colors.orange),
        SizedBox(height: 12.h),
        _buildContractCard('Awaiting QC', 8, Colors.blue),
        SizedBox(height: 12.h),
        _buildContractCard('Pending SIG', 3, Colors.red),
      ],
    );
  }

  Widget _buildContractCard(String status, int count, Color color) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Container(
            width: 12.w,
            height: 12.w,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(6.r),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              status,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF1B3A1A),
              ),
            ),
          ),
          Text(
            '$count contracts',
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(width: 8.w),
          Icon(Icons.chevron_right, color: Colors.grey[400], size: 20.sp),
        ],
      ),
    );
  }

  Widget _buildOpportunitiesSection(List<ProductEntity> products) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Explore Crops',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1B3A1A),
          ),
        ),
        SizedBox(height: 16.h),
        if (products.isEmpty)
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: Text(
                'No crops available for exploration yet.',
                style: TextStyle(color: Colors.grey[600], fontSize: 14.sp),
              ),
            ),
          )
        else
          ...products.map((product) => Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: _buildOpportunityCard(
                  product.name,
                  'From ${product.farmerName ?? "Unknown Farmer"}',
                  product.imageUrl,
                  const Color(0xFF2D5A27),
                ),
              )),
      ],
    );
  }

  Widget _buildOpportunityCard(
    String title,
    String description,
    String? image,
    Color color,
  ) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Container(
            width: 50.w,
            height: 50.w,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12.r),
              image: image != null
                  ? DecorationImage(
                      image: NetworkImage(image),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: image == null ? Icon(Icons.eco, color: color, size: 24.sp) : null,
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1B3A1A),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, color: color, size: 16.sp),
        ],
      ),
    );
  }
}
