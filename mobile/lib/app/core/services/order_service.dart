import 'package:dio/dio.dart';
import '../constants/api_constants.dart';

class OrderService {
  static final Dio _dio = Dio();
  static const String _baseUrl = BASE_URL;

  static Future<Map<String, dynamic>> createOrder({
    required String buyerId,
    required String productId,
    required double quantity,
    required double price,
    required String buyerType,
    required String sellerId,
    required String sellerType,
  }) async {
    try {
      final response = await _dio.post(
        '$_baseUrl${ApiConstants.orders}',
        data: {
          'buyer_id': buyerId,
          'product_id': productId,
          'quantity': quantity,
          'price': price,
          'buyer_type': buyerType,
          'seller_id': sellerId,
          'seller_type': sellerType,
        },
      );

      if (response.statusCode == 201) {
        return {
          'success': true,
          'order': response.data['order'],
          'transaction': response.data['transaction'],
        };
      } else {
        var err = 'Failed to create order';
        if (response.data is Map) err = response.data['error'] ?? err;
        return {
          'success': false,
          'error': err,
        };
      }
    } on DioException catch (e) {
      return {
        'success': false,
        'error': (e.response?.data is Map) ? (e.response?.data['error'] ?? 'Network error: ${e.message}') : 'Network error: ${e.message}',
      };
    } catch (e) {
      return {
        'success': false,
        'error': 'Unexpected error: ${e.toString()}',
      };
    }
  }

  static Future<Map<String, dynamic>> getOrdersByBuyer(String buyerId) async {
    try {
      final response = await _dio.get(
        '$_baseUrl${ApiConstants.orders}/buyer/$buyerId',
      );

      if (response.statusCode == 200) {
        return {
          'success': true,
          'orders': response.data['data'],
          'count': response.data['count'],
        };
      } else {
        var err = 'Failed to fetch orders';
        if (response.data is Map) err = response.data['error'] ?? err;
        return {
          'success': false,
          'error': err,
        };
      }
    } on DioException catch (e) {
      return {
        'success': false,
        'error': (e.response?.data is Map) ? (e.response?.data['error'] ?? 'Network error: ${e.message}') : 'Network error: ${e.message}',
      };
    } catch (e) {
      return {
        'success': false,
        'error': 'Unexpected error: ${e.toString()}',
      };
    }
  }

  static Future<Map<String, dynamic>> updateOrderStatus(String orderId, String status) async {
    try {
      final response = await _dio.patch(
        '$_baseUrl${ApiConstants.orders}/$orderId/status',
        data: {
          'status': status,
        },
      );

      if (response.statusCode == 200) {
        return {
          'success': true,
          'order': response.data['data'],
        };
      } else {
        var err = 'Failed to update order status';
        if (response.data is Map) err = response.data['error'] ?? err;
        return {
          'success': false,
          'error': err,
        };
      }
    } on DioException catch (e) {
      return {
        'success': false,
        'error': (e.response?.data is Map) ? (e.response?.data['error'] ?? 'Network error: ${e.message}') : 'Network error: ${e.message}',
      };
    } catch (e) {
      return {
        'success': false,
        'error': 'Unexpected error: ${e.toString()}',
      };
    }
  }
  static Future<Map<String, dynamic>> getOrdersBySeller(String sellerId) async {
    try {
      final response = await _dio.get(
        '$_baseUrl${ApiConstants.orders}/seller/$sellerId',
      );

      if (response.statusCode == 200) {
        return {
          'success': true,
          'orders': response.data['data'],
          'count': response.data['count'],
        };
      } else {
        return {
          'success': false,
          'error': response.data['error'] ?? 'Failed to fetch orders',
        };
      }
    } on DioException catch (e) {
      return {
        'success': false,
        'error': e.response?.data['error'] ?? 'Network error: ${e.message}',
      };
    } catch (e) {
      return {
        'success': false,
        'error': 'Unexpected error: ${e.toString()}',
      };
    }
  }

  static Future<Map<String, dynamic>> acceptOrder(String orderId) async {
    try {
      final response = await _dio.post(
        '$_baseUrl${ApiConstants.orders}/$orderId/accept',
      );

      if (response.statusCode == 200) {
        return {
          'success': true,
          'order': response.data['order'],
          'transaction': response.data['transaction'],
        };
      } else {
        var err = 'Failed to accept order';
        if (response.data is Map) err = response.data['error'] ?? err;
        return {
          'success': false,
          'error': err,
        };
      }
    } on DioException catch (e) {
      return {
        'success': false,
        'error': e.response?.data['error'] ?? 'Network error: ${e.message}',
      };
    } catch (e) {
      return {
        'success': false,
        'error': 'Unexpected error: ${e.toString()}',
      };
    }
  }
}
