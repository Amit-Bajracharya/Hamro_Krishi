import 'package:dio/dio.dart';
import 'package:hamrokrishi_app/app/core/constants/api_constants.dart';
import '../models/prediction_model.dart';

abstract class IPredictionRemoteDataSource {
  Future<List<PredictionModel>> getDemandPrediction(String productName);
}

class PredictionRemoteDataSourceImpl implements IPredictionRemoteDataSource {
  final Dio dio;

  PredictionRemoteDataSourceImpl({required this.dio});

  @override
  Future<List<PredictionModel>> getDemandPrediction(String productName) async {
    try {
      final response = await dio.get(
        '${ApiConstants.prediction}/dashboard',
      );

      print('--- Prediction API Debug ---');
      print('Status: ${response.statusCode}');
      print('Response Data: ${response.data}');
      print('---------------------------');

      if (response.statusCode == 200) {
        final data = response.data['data'] as Map<String, dynamic>;
        final List<PredictionModel> predictions = [];
        
        if (data.containsKey('vegetables')) {
          predictions.addAll((data['vegetables'] as List)
              .map((e) => PredictionModel.fromJson(e as Map<String, dynamic>)));
        }
        
        if (data.containsKey('fruits')) {
          predictions.addAll((data['fruits'] as List)
              .map((e) => PredictionModel.fromJson(e as Map<String, dynamic>)));
        }
        
        return predictions;
      } else {
        throw Exception('Failed to load prediction: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('--- Prediction API Error ---');
      print('Error: ${e.message}');
      print('Response: ${e.response?.data}');
      print('---------------------------');
      throw Exception(e.message ?? 'Unknown error occurred');
    }
  }
}
