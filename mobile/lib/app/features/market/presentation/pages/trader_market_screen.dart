import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamrokrishi_app/app/features/market/presentation/bloc/trader_market_bloc.dart';
import 'package:hamrokrishi_app/app/features/market/presentation/bloc/trader_market_event.dart';
import 'package:hamrokrishi_app/app/features/market/presentation/bloc/trader_market_state.dart';
import 'package:hamrokrishi_app/app/features/product/domain/entities/product_entity.dart';
import 'package:hamrokrishi_app/app/features/dashboard/presentation/bloc/contract_bloc.dart';
import 'package:hamrokrishi_app/app/features/dashboard/presentation/bloc/contract_event.dart';
import 'package:hamrokrishi_app/app/features/dashboard/presentation/bloc/contract_state.dart';
import 'package:hamrokrishi_app/app/features/dashboard/domain/entities/contract_entity.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/bloc/login_bloc.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/bloc/login_state.dart';
import 'package:hamrokrishi_app/app/core/di/injection_container.dart';
import 'package:intl/intl.dart';

class TraderMarketScreen extends StatelessWidget {
  const TraderMarketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ContractBloc>(),
      child: BlocListener<ContractBloc, ContractState>(
        listener: (context, state) {
          state.whenOrNull(
            submitting: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Submitting contract offer...')),
              );
            },
            success: (contract) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Contract offer submitted successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
              Navigator.of(context).pop(); // Close dialog on success
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
        child: Scaffold(
          backgroundColor: const Color(0xFFF9FAF7),
      body: SafeArea(
        child: BlocBuilder<TraderMarketBloc, TraderMarketState>(
          builder: (context, state) {
            return state.when(
              initial: () => const Center(child: CircularProgressIndicator()),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (message) => Center(child: Text('Error: $message')),
              loaded: (farmerCount, products) => RefreshIndicator(
                onRefresh: () async {
                  context.read<TraderMarketBloc>().add(const TraderMarketEvent.fetchData());
                },
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 24.h),
                      _buildHeader(),
                      SizedBox(height: 32.h),
                      _buildSearchBar(),
                      SizedBox(height: 24.h),
                      _buildFilterChips(),
                      SizedBox(height: 32.h),
                      _buildMarketOverview(farmerCount, products.length),
                      SizedBox(height: 32.h),
                      _buildAvailableProductsSection(products),
                      SizedBox(height: 32.h),
                      _buildTrendingProductsSection(),
                      SizedBox(height: 100.h), // Space for bottom navigation
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'TRADER MARKET',
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w800,
            color: Colors.grey[500],
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Marketplace',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w900,
            color: const Color(0xFF1B3A1A),
            letterSpacing: -0.5,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Connect with farmers and source quality produce',
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Row(
        children: [
          Icon(Icons.search, color: Colors.grey[400], size: 20.sp),
          SizedBox(width: 12.w),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search products, farmers, locations...',
                hintStyle: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey[400],
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          Icon(Icons.filter_list, color: const Color(0xFF2D5A27), size: 20.sp),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _buildFilterChip('All Products', true),
          SizedBox(width: 12.w),
          _buildFilterChip('Vegetables', false),
          SizedBox(width: 12.w),
          _buildFilterChip('Fruits', false),
          SizedBox(width: 12.w),
          _buildFilterChip('Grains', false),
          SizedBox(width: 12.w),
          _buildFilterChip('Dairy', false),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF2D5A27) : Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: isSelected ? const Color(0xFF2D5A27) : Colors.grey.withOpacity(0.3),
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: isSelected ? Colors.white : const Color(0xFF1B3A1A),
        ),
      ),
    );
  }

  Widget _buildMarketOverview(int farmerCount, int productCount) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFF2D5A27), const Color(0xFF4A7C59)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.trending_up, color: Colors.white, size: 24.sp),
              SizedBox(width: 12.w),
              Text(
                'Market Overview',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(
                child: _buildOverviewItem('Active Farmers', farmerCount.toString(), Colors.white),
              ),
              SizedBox(width: 20.w),
              Expanded(
                child: _buildOverviewItem('Available Products', productCount.toString(), Colors.white70),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: _buildOverviewItem('Avg. Price', '2.45/kg', Colors.white70),
              ),
              SizedBox(width: 20.w),
              Expanded(
                child: _buildOverviewItem('Today\'s Trades', '43', Colors.white),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewItem(String label, String value, Color valueColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: valueColor,
          ),
        ),
      ],
    );
  }

  Widget _buildAvailableProductsSection(List<ProductEntity> products) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Available Products',
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
                'No products available in the market.',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
          )
        else
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1, // Single column for large/medium cards as requested
              mainAxisSpacing: 20.h,
              mainAxisExtent: 320.h, // Adjusted for medium image + details
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return _buildProductCard(context, product);
            },
          ),
      ],
    );
  }

  Widget _buildProductCard(BuildContext context, ProductEntity product) {
    return InkWell(
      onTap: () => _showOfferContractDialog(context, product),
      borderRadius: BorderRadius.circular(24.r),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section (Medium Size)
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
              child: Container(
                height: 180.h, // Medium height
                width: double.infinity,
                color: const Color(0xFF2D5A27).withOpacity(0.05),
                child: product.imageUrl != null
                    ? Image.network(
                        product.imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Icon(
                          Icons.image_not_supported_outlined,
                          color: Colors.grey[300],
                          size: 40.sp,
                        ),
                      )
                    : Icon(
                        Icons.eco,
                        color: const Color(0xFF2D5A27).withOpacity(0.2),
                        size: 50.sp,
                      ),
              ),
            ),
            // Details Section
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          product.name,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF1B3A1A),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        'Rs. ${product.price.toStringAsFixed(0)}/kg',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF2D5A27),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Icon(Icons.person_outline, size: 14.sp, color: Colors.grey[500]),
                      SizedBox(width: 4.w),
                      Text(
                        product.farmerName ?? 'Unknown Farmer',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F5E9),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          '${product.quantity} kg avail.',
                          style: TextStyle(
                            fontSize: 11.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF2D5A27),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),
                  // Location if available
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined, size: 14.sp, color: Colors.grey[400]),
                      SizedBox(width: 4.w),
                      Text(
                        'Kathmandu, Nepal', // Placeholder for now
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showOfferContractDialog(BuildContext context, ProductEntity product) {
    final quantityController = TextEditingController(text: product.quantity.toString());
    final priceController = TextEditingController(text: product.price.toString());
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (dialogContext) => BlocProvider.value(
        value: context.read<ContractBloc>(),
        child: AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
          title: Column(
            children: [
              Text(
                'Offer Contract',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1B3A1A),
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'For ${product.name}',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDialogInfoRow('Farmer', product.farmerName ?? 'Unknown'),
                  _buildDialogInfoRow('Farmer Price', 'Rs. ${product.price}/kg'),
                  SizedBox(height: 20.h),
                  Text(
                    'Quantity (kg)',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  TextFormField(
                    controller: quantityController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Enter quantity',
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Please enter quantity' : null,
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Your Selling Price (Rs./kg)',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  TextFormField(
                    controller: priceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Enter your price',
                      filled: true,
                      fillColor: Colors.grey[100],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (value) =>
                        value == null || value.isEmpty ? 'Please enter price' : null,
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  final loginState = context.read<LoginBloc>().state;
                  final traderId = loginState.maybeWhen(
                    success: (user, _) => user.id,
                    orElse: () => '',
                  );

                  if (traderId.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please login to offer contract')),
                    );
                    return;
                  }

                  final contract = ContractEntity(
                    farmerId: product.farmerId ?? '',
                    middlemanId: traderId,
                    productId: product.id ?? '',
                    quantity: double.parse(quantityController.text),
                    farmerSellingPrice: product.price,
                    traderSellingPrice: double.parse(priceController.text),
                    startDate: DateTime.now(),
                    status: 'active',
                  );

                  context.read<ContractBloc>().add(ContractEvent.createContract(contract));
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2D5A27),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: const Text('Submit Offer', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDialogInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 13.sp,
              color: Colors.grey[600],
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1B3A1A),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendingProductsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Trending Products',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1B3A1A),
          ),
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Expanded(
              child: _buildTrendingCard(
                'Organic Lettuce',
                '+15%',
                const Color(0xFF4CAF50),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildTrendingCard(
                'Fresh Strawberries',
                '+22%',
                const Color(0xFFFF9800),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: _buildTrendingCard(
                'Quality Rice',
                '+8%',
                const Color(0xFF2196F3),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildTrendingCard(
                'Farm Eggs',
                '+12%',
                const Color(0xFF9C27B0),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTrendingCard(String productName, String change, Color color) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            productName,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1B3A1A),
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(Icons.trending_up, color: color, size: 16.sp),
              SizedBox(width: 4.w),
              Text(
                change,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
