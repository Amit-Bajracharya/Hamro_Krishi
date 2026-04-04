import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FarmerDashboard extends StatelessWidget {
  const FarmerDashboard({super.key});

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
              _buildGreeting(),
              SizedBox(height: 24.h),
              _buildRevenueCard(),
              SizedBox(height: 16.h),
              _buildContractsCard(),
              SizedBox(height: 32.h),
              _buildPriceTransparencyHeader(),
              SizedBox(height: 16.h),
              _buildMarketIndexCard(
                name: 'Tomatoes',
                category: 'Market Average (per 50kg Basket)',
                buyPrice: 'N24,500',
                sellPrice: 'N21,800',
                statusColor: const Color(0xFF2D5A27),
                updateText: 'Updated 12 minutes ago',
                image: 'assets/images/tomatoes.png',
              ),
              SizedBox(height: 16.h),
              _buildMarketIndexCard(
                name: 'Onions',
                category: 'Market Average (per 100kg Bag)',
                buyPrice: 'N68,000',
                sellPrice: 'N65,200',
                statusColor: Colors.red,
                updateText: 'Downward trend detected',
                image: 'assets/images/onions.png',
                isWarning: true,
              ),
              SizedBox(height: 100.h), // Space for bottom action bar
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _buildBottomActionBar(),
    );
  }

  Widget _buildGreeting() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'HARVEST SUMMARY',
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w800,
            color: Colors.grey[500],
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Good morning, Elias',
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

  Widget _buildRevenueCard() {
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
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Monthly Revenue',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                '₦4,280,000',
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
                    '12.4% vs last month',
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
          Positioned(
            right: -10,
            bottom: -10,
            child: Opacity(
              opacity: 0.1,
              child: Icon(Icons.waves, size: 100, color: Colors.grey[300]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContractsCard() {
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
          Icon(Icons.description_rounded, color: Colors.white.withOpacity(0.8), size: 28.sp),
          SizedBox(height: 16.h),
          Text(
            'ACTIVE CONTRACTS',
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w800,
              color: Colors.white.withOpacity(0.6),
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            '14',
            style: TextStyle(
              fontSize: 48.sp,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
           Divider(color: Colors.white.withOpacity(0.2), height: 32.h),
          Text(
            '3 Pending Fulfillment',
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
              color: Colors.white.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPriceTransparencyHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Price Transparency',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1B3A1A),
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Real-time market indices for your\nregion',
              style: TextStyle(
                fontSize: 13.sp,
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        Row(
          children: [
            Text(
              'View\nInsights',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1B3A1A),
              ),
            ),
            SizedBox(width: 8.w),
             Icon(Icons.arrow_forward, size: 16.sp, color: const Color(0xFF1B3A1A)),
          ],
        ),
      ],
    );
  }

  Widget _buildMarketIndexCard({
    required String name,
    required String category,
    required String buyPrice,
    required String sellPrice,
    required Color statusColor,
    required String updateText,
    required String image,
    bool isWarning = false,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F4EE),
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.r),
                child: Container(
                  width: 40.w,
                  height: 40.w,
                  color: Colors.grey[300],
                  child: const Icon(Icons.eco, color: Colors.green), // Placeholder for image
                ),
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: const Color(0xFF1B3A1A)),
                  ),
                  Text(
                    category,
                    style: TextStyle(fontSize: 11.sp, color: Colors.grey[600]),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(child: _buildPriceBox('BUY PRICE', buyPrice)),
              SizedBox(width: 12.w),
              Expanded(child: _buildPriceBox('SELL PRICE', sellPrice)),
            ],
          ),
          SizedBox(height: 16.h),
          Container(
            height: 4.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2.r),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: 0.7,
              child: Container(
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
               Icon(
                isWarning ? Icons.trending_down : Icons.history,
                size: 14.sp,
                color: Colors.grey[600],
              ),
              SizedBox(width: 8.w),
              Text(
                updateText,
                style: TextStyle(fontSize: 11.sp, color: Colors.grey[600], fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriceBox(String label, String price) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w800, color: Colors.grey[400], letterSpacing: 0.5),
          ),
          SizedBox(height: 4.h),
          Text(
            price,
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w900, color: const Color(0xFF1B3A1A)),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActionBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F4EE),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              'Start a new delivery contract for the upcoming harvest',
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1B3A1A),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: const Color(0xFF1B3A1A),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
