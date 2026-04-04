import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/bloc/login_bloc.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/bloc/login_state.dart';
import 'package:hamrokrishi_app/app/features/product/domain/entities/product_entity.dart';
import 'package:hamrokrishi_app/app/features/product/presentation/bloc/product_bloc.dart';
import 'package:hamrokrishi_app/app/routes/route_constants.dart';
import 'package:intl/intl.dart';

class FarmerCropsScreen extends StatefulWidget {
  const FarmerCropsScreen({super.key});

  @override
  State<FarmerCropsScreen> createState() => _FarmerCropsScreenState();
}

class _FarmerCropsScreenState extends State<FarmerCropsScreen> {
  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  void _fetchProducts() {
    final loginState = context.read<LoginBloc>().state;
    loginState.maybeMap(
      success: (state) {
        context.read<ProductBloc>().add(ProductEvent.fetchFarmerProducts(farmerId: state.user.id));
      },
      orElse: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAF7),
      body: SafeArea(
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            return state.maybeMap(
              loading: (_) => const Center(child: CircularProgressIndicator(color: Color(0xFF2D5A27))),
              loaded: (s) => _buildContent(context, s.products),
              failure: (f) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 48.sp, color: Colors.red),
                    SizedBox(height: 16.h),
                    Text('Error: ${f.error}', style: TextStyle(color: Colors.red, fontSize: 14.sp)),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      onPressed: _fetchProducts,
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2D5A27)),
                      child: const Text('Retry', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
              orElse: () => _buildContent(context, []),
            );
          },
        ),
      ),
      floatingActionButton: _buildFloatingActionButton(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildContent(BuildContext context, List<ProductEntity> products) {
    return RefreshIndicator(
      onRefresh: () async => _fetchProducts(),
      color: const Color(0xFF2D5A27),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24.h),
            _buildHeader(),
            SizedBox(height: 32.h),
            _buildStatsCards(products),
            SizedBox(height: 32.h),
            _buildMyCropsSection(products),
            SizedBox(height: 32.h),
            _buildExpiringSoonSection(products),
            SizedBox(height: 100.h),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return SizedBox(
      width: 56.w,
      height: 56.w,
      child: FloatingActionButton(
        onPressed: () {
          context.push('${AppRoutes.farmerCrops}${AppRoutes.listHarvest}').then((_) => _fetchProducts());
        },
        backgroundColor: const Color(0xFF2D5A27),
        elevation: 8,
        child: Icon(Icons.add, color: Colors.white, size: 24.sp),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'CROPS',
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w800,
            color: Colors.grey[500],
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Manage Your Farm',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w900,
            color: const Color(0xFF1B3A1A),
            letterSpacing: -0.5,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Track planting, growth, and harvest schedules',
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildStatsCards(List<ProductEntity> products) {
    final activeCount = products.length;
    final readyCount = products.where((p) => p.expiryDate.isBefore(DateTime.now().add(const Duration(days: 7)))).length;
    final totalYield = products.fold(0.0, (sum, p) => sum + p.quantity);

    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            'Active Crops',
            activeCount.toString(),
            'Total listed',
            const Color(0xFF4CAF50),
            Icons.eco,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _buildStatCard(
            'Ready to Harvest',
            readyCount.toString(),
            'Expiring soon',
            const Color(0xFFFF9800),
            Icons.agriculture,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _buildStatCard(
            'Total Yield',
            '${totalYield.toStringAsFixed(1)}kg',
            'Total weight',
            const Color(0xFF2196F3),
            Icons.inventory_2,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, String subtitle, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 20.sp),
          SizedBox(height: 8.h),
          Text(title, style: TextStyle(fontSize: 10.sp, color: Colors.grey[600])),
          SizedBox(height: 4.h),
          Text(value, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: const Color(0xFF1B3A1A))),
          SizedBox(height: 2.h),
          Text(subtitle, style: TextStyle(fontSize: 8.sp, color: Colors.grey[500])),
        ],
      ),
    );
  }

  Widget _buildMyCropsSection(List<ProductEntity> products) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'My Crops',
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
              padding: EdgeInsets.symmetric(vertical: 40.h),
              child: Column(
                children: [
                  Icon(Icons.inventory_2_outlined, size: 48.sp, color: Colors.grey[300]),
                  SizedBox(height: 16.h),
                  Text('No crops listed yet', style: TextStyle(color: Colors.grey[500], fontSize: 14.sp)),
                ],
              ),
            ),
          )
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length,
            separatorBuilder: (context, index) => SizedBox(height: 12.h),
            itemBuilder: (context, index) {
              return _buildCropCard(products[index]);
            },
          ),
      ],
    );
  }

  Widget _buildCropCard(ProductEntity product) {
    final color = _getCategoryColor(product.category);
    final harvestDateStr = product.harvestDate != null ? DateFormat('MMM dd, yyyy').format(product.harvestDate!) : 'Unknown Date';
    
    // Calculate shelf life progress
    final now = DateTime.now();
    final totalDuration = product.expiryDate.difference(product.createdAt ?? product.harvestDate ?? now).inMinutes;
    final elapsed = now.difference(product.createdAt ?? product.harvestDate ?? now).inMinutes;
    double progress = totalDuration > 0 ? (elapsed / totalDuration).clamp(0.0, 1.0) : 1.0;
    
    // Derived status
    String statusLabel = 'FRESH';
    if (progress >= 1.0) statusLabel = 'EXPIRED';
    else if (progress > 0.8) statusLabel = 'URGENT';

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
              Container(
                width: 50.w,
                height: 50.w,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: product.imageUrl != null 
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: Image.network(product.imageUrl!, fit: BoxFit.cover),
                    )
                  : Icon(Icons.eco, color: color, size: 24.sp),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1B3A1A),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Text(
                            product.category.toUpperCase(),
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w600,
                              color: color,
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          '${product.quantity} KG',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'Harvested: $harvestDateStr',
                      style: TextStyle(
                        fontSize: 10.sp,
                        color: Colors.grey[500],
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
                  statusLabel,
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Shelf Life',
                    style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
                  ),
                  Text(
                    '${((1 - progress) * 100).toInt()}% Remaining',
                    style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600, color: color),
                  ),
                ],
              ),
              SizedBox(height: 4.h),
              Container(
                height: 6.h,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(3.r),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: (1 - progress),
                  child: Container(
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(3.r),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: _buildActionButton('Details', Icons.info_outline, const Color(0xFF9E9E9E)),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: _buildActionButton('Price: NPR ${product.price}', Icons.sell_outlined, const Color(0xFF4CAF50)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category.toLowerCase()) {
      case 'vegetable': return const Color(0xFF4CAF50);
      case 'fruit': return const Color(0xFFFF6B6B);
      case 'grain': return const Color(0xFFFFD93D);
      default: return const Color(0xFF8B4513);
    }
  }

  Widget _buildActionButton(String label, IconData icon, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 16.sp),
          SizedBox(width: 4.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpiringSoonSection(List<ProductEntity> products) {
    final expiringSoon = products.where((p) => p.expiryDate.isAfter(DateTime.now()) && p.expiryDate.isBefore(DateTime.now().add(const Duration(days: 3)))).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Expiring Soon',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1B3A1A),
          ),
        ),
        SizedBox(height: 16.h),
        if (expiringSoon.isEmpty)
          Text('No crops expiring in the next 3 days.', style: TextStyle(color: Colors.grey[500], fontSize: 13.sp))
        else
          ...expiringSoon.map((p) => Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: _buildActivityItem(
              'Sell ${p.name}',
              'Expiring in ${p.expiryDate.difference(DateTime.now()).inDays} days',
              DateFormat('MMM dd').format(p.expiryDate),
              Icons.warning_amber_rounded,
              const Color(0xFFFF9800),
            ),
          )),
      ],
    );
  }

  Widget _buildActivityItem(String activity, String location, String time, IconData icon, Color color) {
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
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(icon, color: color, size: 20.sp),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1B3A1A),
                  ),
                ),
                SizedBox(height: 2.h),
                Text(location, style: TextStyle(fontSize: 12.sp, color: Colors.grey[600])),
              ],
            ),
          ),
          Text(time, style: TextStyle(fontSize: 10.sp, color: Colors.grey[500])),
        ],
      ),
    );
  }
}