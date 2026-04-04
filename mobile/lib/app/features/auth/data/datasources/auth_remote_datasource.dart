import 'package:dio/dio.dart';
import 'package:hamrokrishi_app/app/core/constants/api_constants.dart';
import 'package:hamrokrishi_app/app/features/auth/domain/entities/user_entity.dart';

abstract class AuthRemoteDataSource {
  Future<UserEntity> login({
    required String identity,
    required String password,
  });

  Future<void> registerFarmer({
    required String name,
    required String email,
    required String password,
    required String phone,
    required double latitude,
    required double longitude,
  });

  Future<void> registerTrader({
    required String name,
    required String email,
    required String password,
    required String phone,
    required double latitude,
    required double longitude,
    required String businessName,
    required String operatingRegions,
  });

  Future<void> registerConsumer({
    required String name,
    required String email,
    required String password,
    required String phone,
    required double latitude,
    required double longitude,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<UserEntity> login({
    required String identity,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        ApiConstants.login,
        data: {
          'identity': identity,
          'password': password,
        },
      );
      
      print('Response status: ${response.statusCode}');
      print('Response data type: ${response.data.runtimeType}');
      print('Response data: ${response.data}');
      
      if (response.statusCode == 200) {
        // Check if response.data is a Map
        if (response.data is Map<String, dynamic>) {
          return UserEntity.fromJson(response.data as Map<String, dynamic>);
        } else {
          throw Exception('Invalid response format: Expected Map, got ${response.data.runtimeType}');
        }
      } else {
        throw Exception(response.data['message'] ?? 'Login failed');
      }
    } on DioException catch (e) {
      print('DioException: ${e.message}');
      print('Response data: ${e.response?.data}');
      final message = e.response?.data?['message'] ?? e.message ?? 'Network error';
      throw Exception(message);
    } catch (e) {
      print('General exception: $e');
      print('Exception type: ${e.runtimeType}');
      rethrow;
    }
  }

  @override
  Future<void> registerFarmer({
    required String name,
    required String email,
    required String password,
    required String phone,
    required double latitude,
    required double longitude,
  }) async {
    try {
      final response = await dio.post(
        ApiConstants.farmers,
        data: {
          'name': name,
          'email': email,
          'password': password,
          'phone': phone,
          'latitude': latitude,
          'longitude': longitude,
        },
      );

      if (response.statusCode != 201) {
        throw Exception(response.data['error'] ?? 'Failed to create farmer profile');
      }
    } on DioException catch (e) {
      final message = e.response?.data?['error'] ?? e.message ?? 'Network error';
      throw Exception(message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> registerTrader({
    required String name,
    required String email,
    required String password,
    required String phone,
    required double latitude,
    required double longitude,
    required String businessName,
    required String operatingRegions,
  }) async {
    try {
      final response = await dio.post(
        ApiConstants.traders,
        data: {
          'name': name,
          'email': email,
          'password': password,
          'phone': phone,
          'latitude': latitude,
          'longitude': longitude,
          'business_name': businessName,
          'operating_regions': operatingRegions,
        },
      );

      if (response.statusCode != 201) {
        throw Exception(response.data['error'] ?? 'Failed to create trader profile');
      }
    } on DioException catch (e) {
      final message = e.response?.data?['error'] ?? e.message ?? 'Network error';
      throw Exception(message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> registerConsumer({
    required String name,
    required String email,
    required String password,
    required String phone,
    required double latitude,
    required double longitude,
  }) async {
    try {
      final response = await dio.post(
        ApiConstants.consumers,
        data: {
          'name': name,
          'email': email,
          'password': password,
          'phone': phone,
          'latitude': latitude,
          'longitude': longitude,
        },
      );

      if (response.statusCode != 201) {
        throw Exception(response.data['error'] ?? 'Failed to create consumer profile');
      }
    } on DioException catch (e) {
      final message = e.response?.data?['error'] ?? e.message ?? 'Network error';
      throw Exception(message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}