import 'package:dio/dio.dart';
import '../../../../core/constants/api_constants.dart';

abstract class IFarmerRemoteDataSource {
  Future<int> getFarmerCount();
}

class FarmerRemoteDataSourceImpl implements IFarmerRemoteDataSource {
  final Dio dio;

  FarmerRemoteDataSourceImpl({required this.dio});

  @override
  Future<int> getFarmerCount() async {
    try {
      final response = await dio.get(ApiConstants.farmers);
      if (response.statusCode == 200) {
        return response.data['count'] as int;
      } else {
        throw Exception('Failed to fetch farmer count');
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['error'] ?? 'Network error while fetching farmer count');
    }
  }
}
