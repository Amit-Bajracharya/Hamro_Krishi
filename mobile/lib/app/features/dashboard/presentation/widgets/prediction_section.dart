import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hamrokrishi_app/app/features/dashboard/domain/entities/prediction.dart';
import 'package:hamrokrishi_app/app/features/dashboard/presentation/bloc/prediction_bloc.dart';
import 'package:hamrokrishi_app/app/features/dashboard/presentation/bloc/prediction_state.dart';

class PredictionSection extends StatelessWidget {
  final VoidCallback onRefresh;

  const PredictionSection({super.key, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PredictionBloc, PredictionState>(
      builder: (context, state) {
        return state.when(
          initial: () => _buildContainer(child: const Center(child: CircularProgressIndicator(color: Colors.white))),
          loading: () => _buildContainer(child: const Center(child: CircularProgressIndicator(color: Colors.white))),
          error: (message) => _buildContainer(child: _buildErrorState(message)),
          loaded: (predictions) => _buildContainer(child: _buildPredictionContent(predictions)),
        );
      },
    );
  }

  Widget _buildContainer({required Widget child}) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: 250.h),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: const Color(0xFF004D40), // Solid Deep Teal first
        gradient: const LinearGradient(
          colors: [Color.fromARGB(255, 2, 80, 8), Color(0xFF00796B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildErrorState(String message) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.error_outline, color: Colors.white, size: 32),
        SizedBox(height: 8.h),
        Text(message, style: const TextStyle(color: Colors.white)),
        TextButton(onPressed: onRefresh, child: const Text('Retry', style: TextStyle(color: Colors.white))),
      ],
    );
  }

  Widget _buildPredictionContent(List<Prediction> predictions) {
    final requestedProducts = ['Potato', 'Apple', 'Cauliflower', 'Onion', 'Lauka'];
    final filteredPredictions = predictions.where((p) {
      return requestedProducts.any((r) => 
        p.productName.toLowerCase().contains(r.toLowerCase()));
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.auto_awesome, color: Colors.white, size: 20.sp),
                ),
                SizedBox(width: 12.w),
                Text(
                  'Market Predictions',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            IconButton(
              onPressed: onRefresh,
              icon: Icon(Icons.refresh, color: Colors.white.withOpacity(0.8), size: 20.sp),
            ),
          ],
        ),
        SizedBox(height: 20.h),
        if (filteredPredictions.isEmpty)
          Center(
            child: Text(
              'No predictions available',
              style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 14.sp),
            ),
          )
        else
          SizedBox(
            height: 180.h,
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
      width: 280.w,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
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
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  prediction.demandLevel.toUpperCase(),
                  style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              Icon(Icons.trending_up, color: Colors.white.withOpacity(0.8), size: 16.sp),
              SizedBox(width: 8.w),
              Text(
                'Trend: ${prediction.estimatedPriceTrend}',
                style: TextStyle(fontSize: 13.sp, color: Colors.white.withOpacity(0.9)),
              ),
            ],
          ),
          const Spacer(),
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Text(
              prediction.reasoning,
              style: TextStyle(fontSize: 11.sp, color: Colors.white.withOpacity(0.8), fontStyle: FontStyle.italic),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
