import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamrokrishi_app/app/core/services/order_service.dart';
import 'package:hamrokrishi_app/app/core/services/user_session_service.dart';

class FarmerOrdersScreen extends StatefulWidget {
  const FarmerOrdersScreen({super.key});

  @override
  State<FarmerOrdersScreen> createState() => _FarmerOrdersScreenState();
}

class _FarmerOrdersScreenState extends State<FarmerOrdersScreen> {
  bool _isLoading = true;
  List<dynamic> _orders = [];
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchOrders();
  }

  Future<void> _fetchOrders() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final farmerId = await UserSessionService.getCurrentUserId();
      print('FarmerOrders: Farmer ID from session: $farmerId');
      if (farmerId == null) throw Exception('Farmer ID not found');

      final result = await OrderService.getOrdersBySeller(farmerId);
      print('FarmerOrders: API result: $result');
      if (result['success']) {
        setState(() {
          _orders = result['orders'] ?? [];
          _isLoading = false;
        });
        print('FarmerOrders: Loaded ${_orders.length} orders');
      } else {
        setState(() {
          _error = result['error'];
          _isLoading = false;
        });
        print('FarmerOrders: Error - ${result['error']}');
      }
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
      print('FarmerOrders: Exception - $e');
    }
  }

  Future<void> _acceptOrder(String orderId) async {
    BuildContext? dialogContext;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        dialogContext = ctx;
        return const Center(child: CircularProgressIndicator());
      },
    );
    
    try {
      final result = await OrderService.acceptOrder(orderId);
      
      // Close loading dialog
      if (dialogContext != null && Navigator.canPop(dialogContext!)) {
        Navigator.pop(dialogContext!);
      }

      if (result['success']) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Order accepted successfully'), backgroundColor: Colors.green),
          );
        }
        _fetchOrders();
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed: ${result['error']}'), backgroundColor: Colors.red),
          );
        }
      }
    } catch (e) {
      // Close loading dialog on error
      if (dialogContext != null && Navigator.canPop(dialogContext!)) {
        Navigator.pop(dialogContext!);
      }
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAF7),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _fetchOrders,
          color: const Color(0xFF2D5A27),
          child: CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 16.h),
                sliver: SliverToBoxAdapter(
                  child: _buildHeader(),
                ),
              ),
              if (_isLoading)
                const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator(color: Color(0xFF2D5A27))),
                )
              else if (_error != null)
                SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline, color: Colors.red, size: 48.sp),
                        SizedBox(height: 16.h),
                        Text(_error!, style: const TextStyle(color: Colors.red)),
                      ],
                    ),
                  ),
                )
              else if (_orders.isEmpty)
                SliverFillRemaining(
                  child: Center(
                    child: Text('No incoming orders right now.',
                        style: TextStyle(fontSize: 14.sp, color: Colors.grey[500])),
                  ),
                )
              else
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final order = _orders[index];
                        return _buildOrderCard(order);
                      },
                      childCount: _orders.length,
                    ),
                  ),
                ),
              SliverToBoxAdapter(child: SizedBox(height: 100.h)),
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
          'ORDERS',
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w800,
            color: Colors.grey[500],
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Incoming Orders',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w900,
            color: const Color(0xFF1B3A1A),
            letterSpacing: -0.5,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Track and finalize orders from consumers',
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey[600],
          ),
        ),
        SizedBox(height: 16.h),
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: const Color(0xFF2D5A27).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              Icon(Icons.shopping_bag_outlined, color: const Color(0xFF2D5A27)),
              SizedBox(width: 12.w),
              Text(
                '${_orders.length} Total Orders',
                style: TextStyle(fontWeight: FontWeight.bold, color: const Color(0xFF2D5A27)),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOrderCard(Map<String, dynamic> order) {
    final status = order['status'] ?? 'pending';
    final isPending = status == 'pending';
    final buyerName = order['buyer_name'] ?? 'Unknown Buyer';
    final quantity = order['quantity']?.toString() ?? '0';
    final price = order['price']?.toString() ?? '0';
    final total = (double.tryParse(quantity) ?? 0) * (double.tryParse(price) ?? 0);
    final productName = order['product_name'] ?? 'Unknown Product';

    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: isPending ? Colors.orange.withOpacity(0.1) : Colors.green.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Text(
                  status.toUpperCase(),
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                    color: isPending ? Colors.orange[800] : Colors.green[800],
                  ),
                ),
              ),
              Text(
                'Rs. ${total.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1B3A1A),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              CircleAvatar(
                backgroundColor: const Color(0xFF2D5A27).withOpacity(0.1),
                child: Icon(Icons.person, color: const Color(0xFF2D5A27)),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      buyerName,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF1B3A1A),
                      ),
                    ),
                    Text(
                      'Ordered $quantity kg of $productName',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (isPending) ...[
            SizedBox(height: 16.h),
            Divider(color: Colors.grey[200]),
            SizedBox(height: 8.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _acceptOrder(order['id']),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2D5A27),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                ),
                child: Text(
                  'Accept Order',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }
}
