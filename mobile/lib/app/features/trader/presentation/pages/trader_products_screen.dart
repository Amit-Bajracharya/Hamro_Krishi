import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/bloc/login_bloc.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/bloc/login_state.dart';
import 'package:hamrokrishi_app/app/features/trader/domain/entities/trader_product_entity.dart';
import 'package:hamrokrishi_app/app/features/trader/presentation/bloc/trader_product_bloc.dart';
import 'package:hamrokrishi_app/app/routes/route_constants.dart';
import 'package:intl/intl.dart';

class TraderProductsScreen extends StatefulWidget {
  const TraderProductsScreen({super.key});

  @override
  State<TraderProductsScreen> createState() => _TraderProductsScreenState();
}

class _TraderProductsScreenState extends State<TraderProductsScreen> {
  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  void _fetchProducts() {
    final loginState = context.read<LoginBloc>().state;
    loginState.maybeMap(
      success: (state) {
        context.read<TraderProductBloc>().add(TraderProductEvent.fetchTraderProducts(traderId: state.user.id));
      },
      orElse: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAF7),
      body: SafeArea(
        child: BlocBuilder<TraderProductBloc, TraderProductState>(
          builder: (context, state) {
            return state.maybeWhen(
              loading: () => const Center(child: CircularProgressIndicator(color: Color(0xFF2D5A27))),
              loaded: (products, _) => _buildContent(context, products),
              failure: (error) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 48.sp, color: Colors.red),
                    SizedBox(height: 16.h),
                    Text('Error: $error', style: TextStyle(color: Colors.red, fontSize: 14.sp)),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('${AppRoutes.traderProducts}/${AppRoutes.addTraderProduct}').then((_) => _fetchProducts());
        },
        backgroundColor: const Color(0xFF2D5A27),
        child: Icon(Icons.add, color: Colors.white, size: 24.sp),
      ),
    );
  }

  Widget _buildContent(BuildContext context, List<TraderProductEntity> products) {
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
            _buildProductsList(products),
            SizedBox(height: 100.h),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SALE INVENTORY',
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w800,
            color: Colors.grey[500],
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Manage Your Products',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w900,
            color: const Color(0xFF1B3A1A),
            letterSpacing: -0.5,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Track items listed for resale from your contracts',
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildStatsCards(List<TraderProductEntity> products) {
    final activeCount = products.length;
    final totalListed = products.fold(0.0, (sum, p) => sum + p.quantityForSale);

    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            'Active Listings',
            activeCount.toString(),
            'Items for sale',
            const Color(0xFF4CAF50),
            Icons.inventory_2,
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: _buildStatCard(
            'Total Quantity',
            '${totalListed.toStringAsFixed(1)}kg',
            'Across all items',
            const Color(0xFF2196F3),
            Icons.scale,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, String subtitle, Color color, IconData icon) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 24.sp),
          SizedBox(height: 12.h),
          Text(value, style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: const Color(0xFF1B3A1A))),
          SizedBox(height: 4.h),
          Text(title, style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w600, color: Colors.grey[600])),
          Text(subtitle, style: TextStyle(fontSize: 10.sp, color: Colors.grey[400])),
        ],
      ),
    );
  }

  Widget _buildProductsList(List<TraderProductEntity> products) {
    if (products.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.only(top: 40.h),
          child: Column(
            children: [
              Icon(Icons.inventory_2_outlined, size: 64.sp, color: Colors.grey[300]),
              SizedBox(height: 16.h),
              Text('No products listed yet', style: TextStyle(color: Colors.grey[500], fontSize: 16.sp)),
              Text('Click + to list a product from your contracts', style: TextStyle(color: Colors.grey[400], fontSize: 12.sp)),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: products.length,
      separatorBuilder: (context, index) => SizedBox(height: 16.h),
      itemBuilder: (context, index) => _buildProductCard(products[index]),
    );
  }

  Widget _buildProductCard(TraderProductEntity product) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 60.w,
                height: 60.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF2D5A27).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: product.imageUrl != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(12.r),
                        child: Image.network(product.imageUrl!, fit: BoxFit.cover),
                      )
                    : Icon(Icons.eco, color: const Color(0xFF2D5A27), size: 30.sp),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.productName ?? 'Unknown Product',
                      style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: const Color(0xFF1B3A1A)),
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2D5A27).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Text(
                            product.category?.toUpperCase() ?? 'OTHER',
                            style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold, color: const Color(0xFF2D5A27)),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          '${product.quantityForSale} KG',
                          style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: Colors.grey[700]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'NPR ${product.price?.toStringAsFixed(0) ?? '0'}',
                    style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: const Color(0xFF2D5A27)),
                  ),
                  Text('per kg', style: TextStyle(fontSize: 10.sp, color: Colors.grey[500])),
                ],
              ),
            ],
          ),
          SizedBox(height: 16.h),
          const Divider(),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.location_on_outlined, size: 14.sp, color: Colors.grey[500]),
                  SizedBox(width: 4.w),
                  Text(
                    '${product.latitude.toStringAsFixed(2)}, ${product.longitude.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 11.sp, color: Colors.grey[500]),
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: _getStatusColor(product.status).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  product.status.toUpperCase(),
                  style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold, color: _getStatusColor(product.status)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'available':
        return Colors.green;
      case 'sold':
        return Colors.blue;
      case 'hidden':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }
}
