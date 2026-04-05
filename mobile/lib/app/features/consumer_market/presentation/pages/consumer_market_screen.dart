import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamrokrishi_app/app/features/consumer_market/domain/entities/market_item_entity.dart';
import 'package:hamrokrishi_app/app/features/consumer_market/presentation/bloc/consumer_market_bloc.dart';
import 'package:hamrokrishi_app/app/features/product/domain/entities/product_entity.dart';
import 'package:hamrokrishi_app/app/core/services/order_service.dart';
import 'package:hamrokrishi_app/app/core/services/user_session_service.dart';

class ConsumerMarketScreen extends StatefulWidget {
  const ConsumerMarketScreen({super.key});

  @override
  State<ConsumerMarketScreen> createState() => _ConsumerMarketScreenState();
}

class _ConsumerMarketScreenState extends State<ConsumerMarketScreen> {
  String _sortOption = 'price_low'; // Options: 'price_low', 'price_high', 'location'
  String _farmerSortOption = 'price_low'; // Sort for farmer products
  
  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    // Initialize user session first
    await _initializeUserSession();
    
    // Then fetch marketplace data
    if (mounted) {
      context.read<ConsumerMarketBloc>().add(const ConsumerMarketEvent.fetchMarketplace());
    }
  }

  Future<void> _initializeUserSession() async {
    // Create demo session if not logged in
    final isLoggedIn = await UserSessionService.isLoggedIn();
    if (!isLoggedIn) {
      await UserSessionService.createDemoCustomerSession();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAF7),
      appBar: _buildAppBar(),
      body: SafeArea(
        child: BlocBuilder<ConsumerMarketBloc, ConsumerMarketState>(
          builder: (context, state) {
            return state.maybeWhen(
              loading: () => const Center(child: CircularProgressIndicator(color: Color(0xFF2D5A27))),
              loaded: (marketItems, farmerProducts) => _buildContent(context, marketItems, farmerProducts),
              error: (message) => Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline, size: 48.sp, color: Colors.red),
                    SizedBox(height: 16.h),
                    Text('Error: $message', style: TextStyle(color: Colors.red, fontSize: 14.sp)),
                    SizedBox(height: 16.h),
                    ElevatedButton(
                      onPressed: () {
                        context.read<ConsumerMarketBloc>().add(const ConsumerMarketEvent.fetchMarketplace());
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF2D5A27)),
                      child: const Text('Retry', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ),
              orElse: () => const Center(child: Text('No data found')),
            );
          },
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'REAL-TIME INSIGHTS',
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
              letterSpacing: 1.2,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            'Price Transparency Feed',
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.w900,
              color: const Color(0xFF1B3A1A),
              letterSpacing: -0.5,
            ),
          ),
        ],
      ),
      centerTitle: false,
    );
  }

  Widget _buildContent(BuildContext context, List<MarketItemEntity> marketItems, List<ProductEntity> farmerProducts) {
    // Sort items based on selected option
    final sortedMarketItems = _sortItems(marketItems, _sortOption);
    final sortedFarmerProducts = _sortFarmerProducts(farmerProducts, _farmerSortOption);
    
    return RefreshIndicator(
      onRefresh: () async {
        context.read<ConsumerMarketBloc>().add(const ConsumerMarketEvent.fetchMarketplace());
      },
      color: const Color(0xFF2D5A27),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16.h),
            // Market Section Header
            Text(
              'Marketplace',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1B3A1A),
              ),
            ),
            SizedBox(height: 12.h),
            _buildSortDropdown(),
            SizedBox(height: 20.h),
            _buildMarketAverages(sortedMarketItems),
            SizedBox(height: 24.h),
            if (sortedMarketItems.isEmpty)
              Padding(
                padding: EdgeInsets.only(top: 40.h),
                child: Text('No products currently available in the marketplace.',
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey[500])),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: sortedMarketItems.length,
                separatorBuilder: (context, index) => SizedBox(height: 24.h),
                itemBuilder: (context, index) => _buildProductCard(sortedMarketItems[index]),
              ),
            SizedBox(height: 40.h),
            // Farmer Products Section Header
            Container(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey[300]!, width: 1),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Direct from Farmers',
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1B3A1A),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    'Buy fresh produce directly from local farmers',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            _buildFarmerSortDropdown(),
            SizedBox(height: 20.h),
            if (sortedFarmerProducts.isEmpty)
              Padding(
                padding: EdgeInsets.only(top: 40.h, bottom: 40.h),
                child: Center(
                  child: Text('No farmer products currently available.',
                      style: TextStyle(fontSize: 14.sp, color: Colors.grey[500])),
                ),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: sortedFarmerProducts.length,
                separatorBuilder: (context, index) => SizedBox(height: 24.h),
                itemBuilder: (context, index) => _buildFarmerProductCard(sortedFarmerProducts[index]),
              ),
            SizedBox(height: 100.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSortDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.sort, size: 20.sp, color: const Color(0xFF2D5A27)),
          SizedBox(width: 12.w),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _sortOption,
                isExpanded: true,
                icon: Icon(Icons.arrow_drop_down, color: const Color(0xFF2D5A27)),
                style: TextStyle(fontSize: 14.sp, color: const Color(0xFF1B3A1A)),
                items: const [
                  DropdownMenuItem(value: 'price_low', child: Text('Price: Low to High')),
                  DropdownMenuItem(value: 'price_high', child: Text('Price: High to Low')),
                  DropdownMenuItem(value: 'location', child: Text('Sort by Location')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _sortOption = value;
                    });
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<MarketItemEntity> _sortItems(List<MarketItemEntity> items, String sortOption) {
    final sorted = List<MarketItemEntity>.from(items);
    switch (sortOption) {
      case 'price_low':
        sorted.sort((a, b) => a.traderSellingPrice.compareTo(b.traderSellingPrice));
        break;
      case 'price_high':
        sorted.sort((a, b) => b.traderSellingPrice.compareTo(a.traderSellingPrice));
        break;
      case 'location':
        sorted.sort((a, b) => a.farmerName.toLowerCase().compareTo(b.farmerName.toLowerCase()));
        break;
    }
    return sorted;
  }

  Widget _buildMarketAverages(List<MarketItemEntity> items) {
    double totalMargin = 0;
    int validItems = 0;
    for (var item in items) {
      if (item.farmerSellingPrice > 0 && item.traderSellingPrice > item.farmerSellingPrice) {
        double margin = ((item.traderSellingPrice - item.farmerSellingPrice) / item.traderSellingPrice) * 100;
        totalMargin += margin;
        validItems++;
      }
    }
    double avgMargin = validItems > 0 ? totalMargin / validItems : 8.4;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF1B3A1A).withOpacity(0.05),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Average Market Margin', style: TextStyle(fontSize: 12.sp, color: Colors.grey[700])),
              SizedBox(height: 4.h),
              Text('${avgMargin.toStringAsFixed(1)}%',
                  style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold, color: const Color(0xFF2D5A27))),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('Status', style: TextStyle(fontSize: 12.sp, color: Colors.grey[700])),
              SizedBox(height: 4.h),
              Row(
                children: [
                  Container(width: 8.w, height: 8.w, decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle)),
                  SizedBox(width: 6.w),
                  Text('Fair Trade Active', style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold, color: const Color(0xFF1B3A1A))),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(MarketItemEntity item) {
    final statusColor = item.quantity > 50 ? Colors.lightGreen : Colors.orange;
    final statusText = item.quantity > 50 ? 'IN STOCK' : 'LOW STOCK';

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
           BoxShadow(
             color: Colors.black.withOpacity(0.04),
             blurRadius: 15,
             offset: const Offset(0, 5),
           ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.productName,
                      style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: const Color(0xFF1B3A1A)),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '${item.category.toUpperCase()} • ${item.quantity}kg Available',
                      style: TextStyle(fontSize: 12.sp, color: Colors.grey[500]),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  statusText,
                  style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold, color: statusColor.shade800),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(
                child: _buildPriceBox('FARMER BUY PRICE', item.farmerSellingPrice),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildPriceBox('CUSTOMER SELL PRICE', item.traderSellingPrice),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: ElevatedButton.icon(
              onPressed: () => _showPurchaseDialog(context, item, isFarmer: true),
              icon: Icon(Icons.shopping_cart_outlined, size: 18.sp, color: Colors.white),
              label: const Text('Direct Buy from Farmer', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2D5A27),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                elevation: 0,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: OutlinedButton(
              onPressed: () => _showPurchaseDialog(context, item, isFarmer: false),
              style: OutlinedButton.styleFrom(
                backgroundColor: const Color(0xFFFF9800),
                side: const BorderSide(color: Colors.transparent),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
              ),
              child: const Text('Market Order', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.person_outline, size: 14.sp, color: Colors.grey[500]),
              SizedBox(width: 4.w),
              Text('Farmer: ${item.farmerName}', style: TextStyle(fontSize: 11.sp, color: Colors.grey[500])),
              SizedBox(width: 12.w),
              Icon(Icons.storefront_outlined, size: 14.sp, color: Colors.grey[500]),
              SizedBox(width: 4.w),
              Text('Trader: ${item.traderName}', style: TextStyle(fontSize: 11.sp, color: Colors.grey[500])),
            ],
          ),
          if (item.farmerLatitude != null && item.farmerLongitude != null)
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.location_on, size: 14.sp, color: const Color(0xFF2D5A27)),
                  SizedBox(width: 4.w),
                  Text(
                    '${item.farmerLatitude!.toStringAsFixed(4)}, ${item.farmerLongitude!.toStringAsFixed(4)}',
                    style: TextStyle(fontSize: 11.sp, color: const Color(0xFF2D5A27)),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPriceBox(String title, double price) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF9FAF7),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(fontSize: 9.sp, fontWeight: FontWeight.bold, color: Colors.grey[500], letterSpacing: 0.5)),
          SizedBox(height: 4.h),
          Text('रू ${price.toStringAsFixed(0)}', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: const Color(0xFF1B3A1A))),
        ],
      ),
    );
  }

  void _showPurchaseDialog(BuildContext mainContext, MarketItemEntity item, {required bool isFarmer}) {
    final quantityController = TextEditingController(text: "1");
    final formKey = GlobalKey<FormState>();
    final double price = isFarmer ? item.farmerSellingPrice : item.traderSellingPrice;
    bool isSubmitting = false;

    showDialog(
      context: mainContext,
      builder: (dialogContext) => StatefulBuilder(
        builder: (statefulContext, setState) {
          final double quantity = double.tryParse(quantityController.text) ?? 0;
          final double total = quantity * price;

          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
            title: Text(
              isFarmer ? 'Buy from Farmer' : 'Market Order', 
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: const Color(0xFF1B3A1A))
            ),
            content: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.productName, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4.h),
                  Text('Price: Rs. $price / kg', style: TextStyle(fontSize: 14.sp, color: Colors.grey[700])),
                  SizedBox(height: 16.h),
                  TextFormField(
                    controller: quantityController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Quantity (kg)',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                      prefixIcon: Icon(Icons.shopping_bag_outlined, color: const Color(0xFF2D5A27)),
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Please enter quantity';
                      final double? q = double.tryParse(value);
                      if (q == null || q <= 0) return 'Invalid quantity';
                      if (q > item.quantity) return 'Only ${item.quantity} kg available';
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9FAF7), 
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Colors.grey.shade200)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total Cost:', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.grey[700])),
                        Text(
                          'Rs. ${total.toStringAsFixed(2)}', 
                          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w900, color: const Color(0xFF2D5A27))
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: isSubmitting ? null : () => Navigator.pop(dialogContext),
                child: Text('Cancel', style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.bold)),
              ),
              ElevatedButton(
                onPressed: isSubmitting ? null : () async {
                  if (formKey.currentState!.validate()) {
                    setState(() {
                      isSubmitting = true;
                    });
                    
                    try {
                      // Get current user session
                      final buyerId = await UserSessionService.getCurrentUserId();
                      final userRole = await UserSessionService.getCurrentUserRole();
                      
                      if (buyerId == null || userRole == null) {
                        throw Exception('User not logged in');
                      }
                      
                      // Map 'consumer' role to 'customer' for order API
                      final buyerType = userRole == 'consumer' ? 'customer' : userRole;
                      
                      // Create order with real data
                      final result = await OrderService.createOrder(
                        buyerId: buyerId,
                        productId: item.productId ?? item.contractId, // Use product_id if available, fallback to contract_id
                        quantity: quantity,
                        price: price,
                        buyerType: buyerType,
                        sellerId: isFarmer ? (item.farmerId ?? '50a28d79-4bf3-446a-8684-32a4b8916006') : (item.middlemanId ?? 'demo-trader-id'),
                        sellerType: isFarmer ? 'farmer' : 'middleman',
                      );
                      
                      if (result['success']) {
                        if (dialogContext.mounted) {
                          Navigator.pop(dialogContext);
                        }
                        if (mainContext.mounted) {
                          ScaffoldMessenger.of(mainContext).showSnackBar(
                            SnackBar(
                              content: Text('Order placed successfully (Pending)! Total: Rs. ${total.toStringAsFixed(2)}'), 
                              backgroundColor: Colors.green
                            ),
                          );
                          
                          // Refresh market data to update inventory
                          mainContext.read<ConsumerMarketBloc>().add(const ConsumerMarketEvent.fetchMarketplace());
                        }
                      } else {
                        setState(() {
                          isSubmitting = false;
                        });
                        if (mainContext.mounted) {
                          ScaffoldMessenger.of(mainContext).showSnackBar(
                            SnackBar(
                              content: Text('Failed to place order: ${result['error']}'), 
                              backgroundColor: Colors.red
                            ),
                          );
                        }
                      }
                    } catch (e) {
                      setState(() {
                        isSubmitting = false;
                      });
                      if (mainContext.mounted) {
                        ScaffoldMessenger.of(mainContext).showSnackBar(
                          SnackBar(
                            content: Text('Error: ${e.toString()}'), 
                            backgroundColor: Colors.red
                          ),
                        );
                      }
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isFarmer ? const Color(0xFF2D5A27) : const Color(0xFFFF9800), 
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                  foregroundColor: Colors.white,
                ),
                child: isSubmitting 
                  ? SizedBox(
                      width: 20.sp, 
                      height: 20.sp, 
                      child: const CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                    )
                  : const Text('Confirm Purchase', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          );
        },
      ),
    );
  }

  List<ProductEntity> _sortFarmerProducts(List<ProductEntity> products, String sortOption) {
    final sorted = List<ProductEntity>.from(products);
    switch (sortOption) {
      case 'price_low':
        sorted.sort((a, b) => a.price.compareTo(b.price));
        break;
      case 'price_high':
        sorted.sort((a, b) => b.price.compareTo(a.price));
        break;
      case 'location':
        sorted.sort((a, b) => (a.farmerName ?? '').toLowerCase().compareTo((b.farmerName ?? '').toLowerCase()));
        break;
    }
    return sorted;
  }

  Widget _buildFarmerSortDropdown() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.sort, size: 20.sp, color: const Color(0xFF2D5A27)),
          SizedBox(width: 12.w),
          Expanded(
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _farmerSortOption,
                isExpanded: true,
                icon: Icon(Icons.arrow_drop_down, color: const Color(0xFF2D5A27)),
                style: TextStyle(fontSize: 14.sp, color: const Color(0xFF1B3A1A)),
                items: const [
                  DropdownMenuItem(value: 'price_low', child: Text('Price: Low to High')),
                  DropdownMenuItem(value: 'price_high', child: Text('Price: High to Low')),
                  DropdownMenuItem(value: 'location', child: Text('Sort by Location')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _farmerSortOption = value;
                    });
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFarmerProductCard(ProductEntity product) {
    final statusColor = product.quantity > 50 ? Colors.lightGreen : Colors.orange;
    final statusText = product.quantity > 50 ? 'IN STOCK' : 'LOW STOCK';

    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
           BoxShadow(
             color: Colors.black.withOpacity(0.04),
             blurRadius: 15,
             offset: const Offset(0, 5),
           ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: const Color(0xFF1B3A1A)),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      '${product.category.toUpperCase()} • ${product.quantity}kg Available',
                      style: TextStyle(fontSize: 12.sp, color: Colors.grey[500]),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  statusText,
                  style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold, color: statusColor.shade800),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Container(
            padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
            decoration: BoxDecoration(
              color: const Color(0xFFF9FAF7),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.grey[200]!),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('FARMER PRICE', style: TextStyle(fontSize: 9.sp, fontWeight: FontWeight.bold, color: Colors.grey[500], letterSpacing: 0.5)),
                    SizedBox(height: 4.h),
                    Text('रू ${product.price.toStringAsFixed(0)}', style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: const Color(0xFF1B3A1A))),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.person_outline, size: 14.sp, color: Colors.grey[500]),
                    SizedBox(width: 4.w),
                    Text(product.farmerName ?? 'Unknown Farmer', style: TextStyle(fontSize: 12.sp, color: Colors.grey[600])),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          SizedBox(
            width: double.infinity,
            height: 48.h,
            child: ElevatedButton.icon(
              onPressed: () => _showFarmerBuyDialog(context, product),
              icon: Icon(Icons.shopping_cart_outlined, size: 18.sp, color: Colors.white),
              label: const Text('Buy from Farmer', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2D5A27),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                elevation: 0,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on, size: 14.sp, color: const Color(0xFF2D5A27)),
              SizedBox(width: 4.w),
              Text(
                '${product.latitude.toStringAsFixed(4)}, ${product.longitude.toStringAsFixed(4)}',
                style: TextStyle(fontSize: 11.sp, color: const Color(0xFF2D5A27)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showFarmerBuyDialog(BuildContext mainContext, ProductEntity product) {
    final quantityController = TextEditingController(text: "1");
    final formKey = GlobalKey<FormState>();
    final double price = product.price;
    bool isSubmitting = false;

    showDialog(
      context: mainContext,
      builder: (dialogContext) => StatefulBuilder(
        builder: (statefulContext, setState) {
          final double quantity = double.tryParse(quantityController.text) ?? 0;
          final double total = quantity * price;

          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
            title: Text(
              'Buy from Farmer', 
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp, color: const Color(0xFF1B3A1A))
            ),
            content: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name, style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold)),
                  SizedBox(height: 4.h),
                  Text('Price: Rs. $price / kg', style: TextStyle(fontSize: 14.sp, color: Colors.grey[700])),
                  SizedBox(height: 4.h),
                  Text('Farmer: ${product.farmerName ?? 'Unknown'}', style: TextStyle(fontSize: 12.sp, color: Colors.grey[600])),
                  SizedBox(height: 16.h),
                  TextFormField(
                    controller: quantityController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Quantity (kg)',
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                      prefixIcon: Icon(Icons.shopping_bag_outlined, color: const Color(0xFF2D5A27)),
                    ),
                    onChanged: (value) {
                      setState(() {});
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Please enter quantity';
                      final double? q = double.tryParse(value);
                      if (q == null || q <= 0) return 'Invalid quantity';
                      if (q > product.quantity) return 'Only ${product.quantity} kg available';
                      return null;
                    },
                  ),
                  SizedBox(height: 16.h),
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF9FAF7), 
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Colors.grey.shade200)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total Cost:', style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold, color: Colors.grey[700])),
                        Text(
                          'Rs. ${total.toStringAsFixed(2)}', 
                          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w900, color: const Color(0xFF2D5A27))
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: isSubmitting ? null : () => Navigator.pop(dialogContext),
                child: Text('Cancel', style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.bold)),
              ),
              ElevatedButton(
                onPressed: isSubmitting ? null : () async {
                  if (formKey.currentState!.validate()) {
                    setState(() {
                      isSubmitting = true;
                    });
                    
                    try {
                      // Get current user session
                      final buyerId = await UserSessionService.getCurrentUserId();
                      final userRole = await UserSessionService.getCurrentUserRole();
                      
                      if (buyerId == null || userRole == null) {
                        throw Exception('User not logged in');
                      }
                      
                      // Map 'consumer' role to 'customer' for order API
                      final buyerType = userRole == 'consumer' ? 'customer' : userRole;
                      
                      // Create order with real data
                      final result = await OrderService.createOrder(
                        buyerId: buyerId,
                        productId: product.id ?? product.farmerId ?? 'unknown-product',
                        quantity: quantity,
                        price: price,
                        buyerType: buyerType,
                        sellerId: product.farmerId ?? 'demo-farmer-id',
                        sellerType: 'farmer',
                      );
                      
                      if (result['success']) {
                        if (dialogContext.mounted) {
                          Navigator.pop(dialogContext);
                        }
                        if (mainContext.mounted) {
                          ScaffoldMessenger.of(mainContext).showSnackBar(
                            SnackBar(
                              content: Text('Order placed successfully (Pending)! Total: Rs. ${total.toStringAsFixed(2)}'), 
                              backgroundColor: Colors.green
                            ),
                          );
                          
                          // Refresh market data to update inventory
                          mainContext.read<ConsumerMarketBloc>().add(const ConsumerMarketEvent.fetchMarketplace());
                        }
                      } else {
                        setState(() {
                          isSubmitting = false;
                        });
                        if (mainContext.mounted) {
                          ScaffoldMessenger.of(mainContext).showSnackBar(
                            SnackBar(
                              content: Text('Failed to place order: ${result['error']}'), 
                              backgroundColor: Colors.red
                            ),
                          );
                        }
                      }
                    } catch (e) {
                      setState(() {
                        isSubmitting = false;
                      });
                      if (mainContext.mounted) {
                        ScaffoldMessenger.of(mainContext).showSnackBar(
                          SnackBar(
                            content: Text('Error: ${e.toString()}'), 
                            backgroundColor: Colors.red
                          ),
                        );
                      }
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2D5A27), 
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
                  foregroundColor: Colors.white,
                ),
                child: isSubmitting 
                  ? SizedBox(
                      width: 20.sp, 
                      height: 20.sp, 
                      child: const CircularProgressIndicator(color: Colors.white, strokeWidth: 2)
                    )
                  : const Text('Confirm Purchase', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          );
        },
      ),
    );
  }
}
