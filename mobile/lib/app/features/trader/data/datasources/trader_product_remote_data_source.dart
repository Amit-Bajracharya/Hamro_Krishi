import 'package:dio/dio.dart';
import 'package:hamrokrishi_app/app/core/constants/api_constants.dart';
import 'package:hamrokrishi_app/app/features/trader/data/models/trader_product_model.dart';

abstract class ITraderProductRemoteDataSource {
  Future<void> addTraderProduct(TraderProductModel product);
  Future<List<TraderProductModel>> getTraderProducts(String traderId);
  Future<TraderProductModel> getTraderProductDetail(String id);
  Future<void> updateStatus(String id, String status);
}

class TraderProductRemoteDataSourceImpl implements ITraderProductRemoteDataSource {
  final Dio dio;

  TraderProductRemoteDataSourceImpl({required this.dio});

  @override
  Future<void> addTraderProduct(TraderProductModel product) async {
    try {
      final response = await dio.post(
        ApiConstants.traderProducts,
        data: product.toJson(),
      );

      if (response.statusCode != 201) {
        throw Exception(response.data['error'] ?? 'Failed to list product');
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['error'] ?? 'Network error while listing product');
    }
  }

  @override
  Future<List<TraderProductModel>> getTraderProducts(String traderId) async {
    try {
      final response = await dio.get('${ApiConstants.traderProducts}/trader/$traderId');

      if (response.statusCode == 200) {
        final List data = response.data['data'];
        return data.map((json) => TraderProductModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch trader products');
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['error'] ?? 'Network error while fetching products');
    }
  }

  @override
  Future<TraderProductModel> getTraderProductDetail(String id) async {
    try {
      final response = await dio.get('${ApiConstants.traderProducts}/$id');

      if (response.statusCode == 200) {
        return TraderProductModel.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to fetch product details');
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['error'] ?? 'Network error while fetching details');
    }
  }

  @override
  Future<void> updateStatus(String id, String status) async {
    try {
      final response = await dio.put(
        '${ApiConstants.traderProducts}/$id/status',
        data: {'status': status},
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to update status');
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['error'] ?? 'Error updating status');
    }
  }
}
