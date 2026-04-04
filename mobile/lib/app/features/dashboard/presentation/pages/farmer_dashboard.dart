import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/bloc/login_state.dart';
import 'package:hamrokrishi_app/app/features/dashboard/domain/entities/weather.dart';
import 'package:hamrokrishi_app/app/features/dashboard/presentation/bloc/weather_bloc.dart';
import 'package:hamrokrishi_app/app/features/dashboard/presentation/bloc/weather_event.dart';
import 'package:hamrokrishi_app/app/features/dashboard/presentation/bloc/weather_state.dart';
import 'package:hamrokrishi_app/app/features/dashboard/presentation/bloc/prediction_bloc.dart';
import 'package:hamrokrishi_app/app/features/dashboard/presentation/bloc/prediction_event.dart';
import 'package:hamrokrishi_app/app/features/dashboard/presentation/bloc/prediction_state.dart';
import 'package:hamrokrishi_app/app/features/dashboard/domain/entities/prediction.dart';
import 'package:hamrokrishi_app/app/features/dashboard/presentation/widgets/weather_section.dart';
import 'package:hamrokrishi_app/app/features/dashboard/presentation/widgets/prediction_section.dart';
import 'package:hamrokrishi_app/app/core/di/injection_container.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/bloc/login_bloc.dart';
import 'package:hamrokrishi_app/app/features/dashboard/presentation/bloc/contract_bloc.dart';
import 'package:hamrokrishi_app/app/features/dashboard/presentation/bloc/contract_event.dart';
import 'package:hamrokrishi_app/app/features/dashboard/presentation/bloc/contract_state.dart';
import 'package:hamrokrishi_app/app/features/product/presentation/bloc/product_bloc.dart';


import 'package:hamrokrishi_app/app/features/dashboard/domain/entities/contract_entity.dart';

class FarmerDashboard extends StatefulWidget {
  const FarmerDashboard({super.key});

  @override
  State<FarmerDashboard> createState() => _FarmerDashboardState();
}

class _FarmerDashboardState extends State<FarmerDashboard> {
  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  void _fetchWeather() async {
    // Kathmandu, Nepal coordinates
    const double ktmLat = 27.7172, ktmLon = 85.3240;
    
    if (mounted) {
      context.read<WeatherBloc>().add(const WeatherEvent.fetchWeather(
            latitude: ktmLat,
            longitude: ktmLon,
          ));
      
      // Fetch market predictions
      context.read<PredictionBloc>().add(const PredictionEvent.fetchPrediction(
            productName: '', // Fetch all
          ));

      // Fetch Farmer specific data for stats
      final loginState = context.read<LoginBloc>().state;
      loginState.maybeWhen(
        success: (user, _) {
          context.read<ContractBloc>().add(ContractEvent.fetchUserContracts(
                userId: user.id,
                role: 'farmer',
              ));
          context.read<ProductBloc>().add(ProductEvent.fetchFarmerProducts(
                farmerId: user.id,
              ));
        },
        orElse: () {},
      );
    }
  }

  void _fetchPrediction(String product) {
    context.read<PredictionBloc>().add(PredictionEvent.fetchPrediction(
          productName: product,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<ContractBloc>()),
        BlocProvider(create: (context) => sl<ProductBloc>()),
      ],
      child: Builder(
        builder: (context) {
          // Re-trigger fetch because we just provided these blocs
          WidgetsBinding.instance.addPostFrameCallback((_) {
             _fetchWeather();
          });

          return Scaffold(
            backgroundColor: const Color(0xFFF9FAF7),
            body: SafeArea(
              child: RefreshIndicator(
                onRefresh: () async => _fetchWeather(),
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 24.h),
                      _buildHeader(),
                      SizedBox(height: 32.h),
                      WeatherSection(onRefresh: _fetchWeather),
                      SizedBox(height: 32.h),
                      PredictionSection(onRefresh: () => _fetchPrediction('')),
                      SizedBox(height: 32.h),
                      _buildStatsSection(),
                      SizedBox(height: 32.h),
                      _buildActiveContractsSection(),
                      SizedBox(height: 32.h),
                      _buildMarketPricesSection(),
                      SizedBox(height: 32.h),
                      _buildRecentActivitySection(),
                      SizedBox(height: 100.h), 
                    ],
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'FARMER DASHBOARD',
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w800,
            color: Colors.grey[500],
            letterSpacing: 1.2,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Good morning !!',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w900,
            color: const Color(0xFF1B3A1A),
            letterSpacing: -0.5,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'Here\'s what\'s happening with your farm today',
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildStatsSection() {
    return BlocBuilder<ContractBloc, ContractState>(
      builder: (context, contractState) {
        return BlocBuilder<ProductBloc, ProductState>(
          builder: (context, productState) {
            final contracts = contractState.maybeWhen(
              contractsLoaded: (c) => c,
              orElse: () => <ContractEntity>[],
            );
            
            final products = productState.maybeWhen(
              loaded: (p) => p,
              orElse: () => [],
            );

            final activeContracts = contracts.where((c) => c.status == 'active').toList();
            final totalRevenue = activeContracts.fold<double>(0, (sum, c) => sum + (c.farmerSellingPrice * c.quantity));

            return _buildStatsCards(
              totalRevenue: totalRevenue,
              activeContractsCount: activeContracts.length,
              productsListedCount: products.length,
            );
          },
        );
      },
    );
  }

  Widget _buildStatsCards({
    required double totalRevenue,
    required int activeContractsCount,
    required int productsListedCount,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                'Total Revenue',
                'Rs. ${totalRevenue.toStringAsFixed(0)}',
                'From active contracts',
                const Color(0xFF4CAF50),
                Icons.trending_up,
                totalRevenue > 0 ? '+100%' : '0%',
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildStatCard(
                'Active Contracts',
                activeContractsCount.toString(),
                'Current active',
                const Color(0xFF2196F3),
                Icons.description,
                activeContractsCount > 0 ? 'Live' : 'No active',
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                'Products Listed',
                productsListedCount.toString(),
                'On marketplace',
                const Color(0xFFFF9800),
                Icons.inventory_2,
                productsListedCount > 0 ? 'Live' : 'Drafts',
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildStatCard(
                'Buyer Rating',
                '4.8',
                'Excellent',
                const Color(0xFF9C27B0),
                Icons.star,
                '+0.2',
              ),
            ),
          ],
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
    String change,
  ) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
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
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Icon(icon, color: color, size: 20.sp),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Text(
                  change,
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

  Widget _buildActiveContractsSection() {
    return BlocBuilder<ContractBloc, ContractState>(
      builder: (context, state) {
        final activeContracts = state.maybeWhen(
          contractsLoaded: (contracts) => contracts.where((c) => c.status == 'active').toList(),
          orElse: () => <ContractEntity>[],
        );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Active Contracts',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1B3A1A),
                  ),
                ),
                Text(
                  'View all',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: const Color(0xFF2D5A27),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            if (activeContracts.isEmpty)
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: Text('No active contracts', style: TextStyle(color: Colors.grey[500])),
                ),
              )
            else
              ...activeContracts.take(3).map((contract) => Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: _buildContractCard(
                  'ID: ${contract.id?.substring(0, 8) ?? 'N/A'}',
                  contract.productName ?? 'Product',
                  contract.traderName ?? 'Trader',
                  '${contract.quantity} kg',
                  'Rs. ${contract.farmerSellingPrice}/kg',
                  'Active',
                  const Color(0xFF4CAF50),
                ),
              )),
          ],
        );
      },
    );
  }

  Widget _buildContractCard(
    String contractId,
    String product,
    String buyer,
    String quantity,
    String price,
    String timeLeft,
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
                      contractId,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[600],
                      ),
                    ),
                    SizedBox(height: 4.h),
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
                  timeLeft,
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
                child: _buildContractDetail('Quantity', quantity),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: _buildContractDetail('Price', price),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContractDetail(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10.sp,
            color: Colors.grey[500],
          ),
        ),
        SizedBox(height: 2.h),
        Text(
          value,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1B3A1A),
          ),
        ),
      ],
    );
  }

  Widget _buildMarketPricesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Market Prices',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1B3A1A),
          ),
        ),
        SizedBox(height: 16.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [const Color(0xFF2D5A27), const Color(0xFF4A7C59)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.trending_up, color: Colors.white, size: 24.sp),
                  SizedBox(width: 12.w),
                  Text(
                    'Today\'s Market Index',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              _buildPriceItem('Tomatoes', '\$3.45/kg', '+5%', Colors.white),
              SizedBox(height: 12.h),
              _buildPriceItem('Lettuce', '\$4.20/kg', '+2%', Colors.white70),
              SizedBox(height: 12.h),
              _buildPriceItem('Wheat', '\$2.95/kg', '-1%', Colors.white70),
              SizedBox(height: 12.h),
              _buildPriceItem('Corn', '\$3.10/kg', '+3%', Colors.white70),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPriceItem(String product, String price, String change, Color textColor) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          product,
          style: TextStyle(
            fontSize: 14.sp,
            color: textColor,
          ),
        ),
        Row(
          children: [
            Text(
              price,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
            SizedBox(width: 12.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
              decoration: BoxDecoration(
                color: change.contains('+') 
                    ? Colors.white.withOpacity(0.2)
                    : Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Text(
                change,
                style: TextStyle(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRecentActivitySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Activity',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF1B3A1A),
          ),
        ),
        SizedBox(height: 16.h),
        _buildActivityItem(
          'New order received',
          'Metro Traders - 200kg tomatoes',
          '2 hours ago',
          Icons.shopping_cart,
          const Color(0xFF4CAF50),
        ),
        SizedBox(height: 12.h),
        _buildActivityItem(
          'Contract completed',
          'Green Valley Co. - lettuce delivery',
          '1 day ago',
          Icons.check_circle,
          const Color(0xFF2196F3),
        ),
        SizedBox(height: 12.h),
        _buildActivityItem(
          'Payment received',
          '\$1,280 from City Markets',
          '2 days ago',
          Icons.payment,
          const Color(0xFF9C27B0),
        ),
      ],
    );
  }

  Widget _buildActivityItem(
    String title,
    String description,
    String time,
    IconData icon,
    Color color,
  ) {
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
                  title,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF1B3A1A),
                  ),
                ),
                SizedBox(height: 2.h),
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
          Text(
            time,
            style: TextStyle(
              fontSize: 10.sp,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}
