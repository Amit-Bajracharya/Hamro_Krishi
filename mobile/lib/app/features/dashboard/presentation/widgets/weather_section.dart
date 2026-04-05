import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamrokrishi_app/app/features/dashboard/domain/entities/weather.dart';
import 'package:hamrokrishi_app/app/features/dashboard/presentation/bloc/weather_bloc.dart';
import 'package:hamrokrishi_app/app/features/dashboard/presentation/bloc/weather_event.dart';
import 'package:hamrokrishi_app/app/features/dashboard/presentation/bloc/weather_state.dart';

class WeatherSection extends StatelessWidget {
  final VoidCallback onRefresh;

  const WeatherSection({super.key, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
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
                    onPressed: onRefresh,
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
                onTap: onRefresh,
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
                Expanded(
                  child: Text(
                    weather.temperature > 15 && weather.temperature < 35 
                        ? 'Good conditions for farming'
                        : 'Be careful with the weather today',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
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
}
