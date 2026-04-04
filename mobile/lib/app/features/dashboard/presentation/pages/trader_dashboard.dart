import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TraderDashboard extends StatelessWidget {
  const TraderDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAF7),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24.h),
              _buildHeader(),
              SizedBox(height: 32.h),
              _buildStatsCards(),
              SizedBox(height: 32.h),
              _buildContractsSection(),
              SizedBox(height: 32.h),
              _buildOpportunitiesSection(),
              SizedBox(height: 100.h), // Space for bottom navigation
            ],
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
          'Good morning, Alex',
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

  Widget _buildStatsCards() {
    return Column(
      children: [
        _buildActiveFarmersCard(),
        SizedBox(height: 16.h),
        _buildInventoryCard(),
      ],
    );
  }

  Widget _buildActiveFarmersCard() {
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
            '1,248',
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

  Widget _buildOpportunitiesSection() {
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
        _buildOpportunityCard(
          'Premium Heirloom Wheat',
          'High-value specialty crop',
          'assets/images/wheat.png',
          const Color(0xFF2D5A27),
        ),
        SizedBox(height: 12.h),
        _buildOpportunityCard(
          'Non-GMO Soybeans',
          'Organic market demand',
          'assets/images/soybeans.png',
          const Color(0xFF4A7C59),
        ),
        SizedBox(height: 12.h),
        _buildOpportunityCard(
          'Oil-Seed Sunflowers',
          'Industrial oil production',
          'assets/images/sunflowers.png',
          const Color(0xFF6B8E5A),
        ),
        SizedBox(height: 12.h),
        _buildOpportunityCard(
          'Malting Barley',
          'Brewery partnerships',
          'assets/images/barley.png',
          const Color(0xFF8FAF7C),
        ),
      ],
    );
  }

  Widget _buildOpportunityCard(
    String title,
    String description,
    String image,
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
            ),
            child: Icon(Icons.eco, color: color, size: 24.sp),
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
