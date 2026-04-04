import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamrokrishi_app/app/features/dashboard/domain/entities/weather.dart';
import 'package:hamrokrishi_app/app/features/dashboard/presentation/bloc/weather_bloc.dart';
import 'package:hamrokrishi_app/app/features/dashboard/presentation/bloc/weather_event.dart';
import 'package:hamrokrishi_app/app/features/dashboard/presentation/bloc/weather_state.dart';
import 'package:hamrokrishi_app/app/features/dashboard/presentation/bloc/prediction_bloc.dart';
import 'package:hamrokrishi_app/app/features/dashboard/presentation/bloc/prediction_event.dart';
import 'package:hamrokrishi_app/app/features/dashboard/presentation/bloc/prediction_state.dart';
import 'package:hamrokrishi_app/app/features/dashboard/domain/entities/prediction.dart';

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
    }
  }

  void _fetchPrediction(String product) {
    context.read<PredictionBloc>().add(PredictionEvent.fetchPrediction(
          productName: product,
        ));
  }

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
              _buildWeatherSection(),
              SizedBox(height: 32.h),
              _buildPredictionSection(),
              SizedBox(height: 32.h),
              _buildStatsCards(),
              SizedBox(height: 32.h),
              _buildActiveContractsSection(),
              SizedBox(height: 32.h),
              _buildMarketPricesSection(),
              SizedBox(height: 32.h),
              _buildRecentActivitySection(),
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

  Widget _buildWeatherSection() {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        return state.when(
          initial: () => _buildWeatherContainer(child: const Center(child: CircularProgressIndicator(color: Colors.white))),
          loading: () => _buildWeatherContainer(child: const Center(child: CircularProgressIndicator(color: Colors.white))),
          error: (message) => _buildWeatherContainer(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.white, size: 32),
                  SizedBox(height: 8.h),
                  Text(
                    'Failed to load weather',
                    style: TextStyle(color: Colors.white, fontSize: 14.sp),
                  ),
                  TextButton(
                    onPressed: _fetchWeather,
                    child: const Text('Retry', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
          loaded: (weather) => _buildWeatherContent(weather),
        );
      },
    );
  }

  Widget _buildWeatherContainer({required Widget child}) {
    return Container(
      width: double.infinity,
      height: 200.h,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF87CEEB), Color(0xFF4A90E2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildWeatherContent(Weather weather) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF87CEEB), Color(0xFF4A90E2)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
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
              Image.network(
                'https://openweathermap.org/img/wn/${weather.icon}@2x.png',
                width: 24.sp,
                height: 24.sp,
                errorBuilder: (context, error, stackTrace) => Icon(Icons.wb_sunny, color: Colors.white, size: 24.sp),
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Today\'s Weather',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Kathmandu, Nepal',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              GestureDetector(
                onTap: _fetchWeather,
                child: Icon(Icons.refresh, color: Colors.white.withOpacity(0.8), size: 20.sp),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${weather.temperature.toStringAsFixed(0)}°C',
                    style: TextStyle(
                      fontSize: 48.sp,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    weather.condition.toUpperCase(),
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _buildWeatherDetail('Humidity', '${weather.humidity}%'),
                  SizedBox(height: 8.h),
                  _buildWeatherDetail('Wind', '${weather.windSpeed.toStringAsFixed(1)} km/h'),
                  SizedBox(height: 8.h),
                  _buildWeatherDetail('Rain', '${weather.rainProbability}%'),
                ],
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                Icon(Icons.agriculture, color: Colors.white, size: 20.sp),
                SizedBox(width: 8.w),
                Text(
                  weather.temperature > 15 && weather.temperature < 35 
                      ? 'Good conditions for farming today'
                      : 'Be careful with the weather today',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherDetail(String label, String value) {
    return Row(
      children: [
        Text(
          '$label: ',
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildPredictionSection() {
    return BlocBuilder<PredictionBloc, PredictionState>(
      builder: (context, state) {
        return state.when(
          initial: () => _buildPredictionContainer(child: const Center(child: CircularProgressIndicator(color: Colors.white))),
          loading: () => _buildPredictionContainer(child: const Center(child: CircularProgressIndicator(color: Colors.white))),
          error: (message) => _buildPredictionContainer(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.analytics_outlined, color: Colors.white, size: 32),
                  SizedBox(height: 8.h),
                  Text(
                    'Failed to load prediction',
                    style: TextStyle(color: Colors.white, fontSize: 14.sp),
                  ),
                  TextButton(
                    onPressed: () => _fetchPrediction('Tomato'),
                    child: const Text('Retry', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          ),
          loaded: (predictions) => _buildPredictionContent(predictions),
        );
      },
    );
  }

  Widget _buildPredictionContainer({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF008080), Color(0xFF20B2AA)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildPredictionContent(List<Prediction> predictions) {
    // Filter for specific products requested by user
    final requestedProducts = ['Potato', 'Apple', 'Cauliflower', 'Onion', 'Bottle Gourd (Lauka)'];
    final filteredPredictions = predictions.where((p) {
      return requestedProducts.any((r) => 
        p.productName.toLowerCase().contains(r.split(' ')[0].toLowerCase()));
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(Icons.auto_awesome, color: const Color(0xFF008080), size: 24.sp),
                SizedBox(width: 8.w),
                Text(
                  'Market Predictions',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF1B3A1A),
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () => _fetchPrediction(''),
              child: Icon(Icons.refresh, color: Colors.grey[400], size: 20.sp),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: 200.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: filteredPredictions.length,
            separatorBuilder: (context, index) => SizedBox(width: 16.w),
            itemBuilder: (context, index) {
              final prediction = filteredPredictions[index];
              return _buildPredictionCard(prediction);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPredictionCard(Prediction prediction) {
    return Container(
      width: 300.w,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF008080), Color(0xFF20B2AA)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF008080).withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  prediction.productName,
                  style: TextStyle(
                    fontSize: 17.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  prediction.demandLevel,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Icon(Icons.trending_up, color: Colors.white.withValues(alpha: 0.9), size: 18.sp),
              SizedBox(width: 6.w),
              Text(
                'Trend: ${prediction.estimatedPriceTrend}',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white.withValues(alpha: 0.9),
                ),
              ),
            ],
          ),
          const Spacer(),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
            ),
            child: Text(
              prediction.reasoning,
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.white.withValues(alpha: 0.95),
                height: 1.4,
                fontStyle: FontStyle.italic,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPredictionDetail(String label, String value) {
    return Row(
      children: [
        Text(
          '$label: ',
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.white.withOpacity(0.8),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildStatsCards() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildStatCard(
                'Total Revenue',
                '\$12,450',
                'This month',
                const Color(0xFF4CAF50),
                Icons.trending_up,
                '+12%',
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: _buildStatCard(
                'Active Contracts',
                '8',
                '2 ending soon',
                const Color(0xFF2196F3),
                Icons.description,
                '+2',
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
                '24',
                '5 categories',
                const Color(0xFFFF9800),
                Icons.inventory_2,
                '+3',
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
        _buildContractCard(
          'Contract #F2024-08',
          'Fresh Tomatoes',
          'Metro Traders Ltd.',
          '850 kg',
          '\$3.20/kg',
          '5 days left',
          const Color(0xFFFF9800),
        ),
        SizedBox(height: 12.h),
        _buildContractCard(
          'Contract #F2024-07',
          'Organic Lettuce',
          'Green Valley Co.',
          '400 kg',
          '\$4.50/kg',
          '12 days left',
          const Color(0xFF4CAF50),
        ),
        SizedBox(height: 12.h),
        _buildContractCard(
          'Contract #F2024-06',
          'Quality Wheat',
          'City Markets',
          '1,200 kg',
          '\$2.80/kg',
          '3 days left',
          const Color(0xFFFF6B6B),
        ),
      ],
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
