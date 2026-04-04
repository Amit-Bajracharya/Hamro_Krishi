import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamrokrishi_app/app/features/consumer_market/domain/entities/market_item_entity.dart';
import 'package:hamrokrishi_app/app/features/consumer_market/presentation/bloc/consumer_market_bloc.dart';

class ConsumerMarketScreen extends StatefulWidget {
  const ConsumerMarketScreen({super.key});

  @override
  State<ConsumerMarketScreen> createState() => _ConsumerMarketScreenState();
}

class _ConsumerMarketScreenState extends State<ConsumerMarketScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ConsumerMarketBloc>().add(const ConsumerMarketEvent.fetchMarketplace());
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
              loaded: (items) => _buildContent(context, items),
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

  Widget _buildContent(BuildContext context, List<MarketItemEntity> items) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<ConsumerMarketBloc>().add(const ConsumerMarketEvent.fetchMarketplace());
      },
      color: const Color(0xFF2D5A27),
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            SizedBox(height: 16.h),
            _buildMarketAverages(items),
            SizedBox(height: 24.h),
            if (items.isEmpty)
              Padding(
                padding: EdgeInsets.only(top: 40.h),
                child: Text('No products currently available in the marketplace.',
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey[500])),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: items.length,
                separatorBuilder: (context, index) => SizedBox(height: 24.h),
                itemBuilder: (context, index) => _buildProductCard(items[index]),
              ),
            SizedBox(height: 100.h),
          ],
        ),
      ),
    );
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
              onPressed: () {
                 ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Direct purchase coming soon!')));
              },
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
              onPressed: () {
                 ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Market order coming soon!')));
              },
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
}
