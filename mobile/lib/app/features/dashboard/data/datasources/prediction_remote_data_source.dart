import 'package:dio/dio.dart';
import 'package:hamrokrishi_app/app/core/constants/api_constants.dart';
import '../models/prediction_model.dart';

abstract class IPredictionRemoteDataSource {
  Future<PredictionModel> getDemandPrediction(String productName);
}

class PredictionRemoteDataSourceImpl implements IPredictionRemoteDataSource {
  final Dio dio;

  PredictionRemoteDataSourceImpl({required this.dio});

  @override
  Future<PredictionModel> getDemandPrediction(String productName) async {
    try {
      final response = await dio.get(
        '${ApiConstants.prediction}/demand',
        queryParameters: {
          'productName': productName,
        },
      );

      if (response.statusCode == 200) {
        return PredictionModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load prediction');
      }
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Unknown error occurred');
    }
  }
}
