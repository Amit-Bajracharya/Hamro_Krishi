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

  String _extractErrorMessage(dynamic data, String defaultMessage) {
    if (data is Map<String, dynamic>) {
      return data['error'] ?? data['message'] ?? defaultMessage;
    }
    if (data is String && data.isNotEmpty) {
      // If it's a string but looks like HTML, don't return the whole thing
      if (data.contains('<!DOCTYPE html>') || data.contains('<html')) {
        return 'Server error (404/500). Please check if the backend is running.';
      }
      return data;
    }
    return defaultMessage;
  }

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
      
      if (response.statusCode == 200) {
        if (response.data is Map<String, dynamic>) {
          return UserEntity.fromJson(response.data as Map<String, dynamic>);
        } else {
          throw Exception('Invalid response format from server');
        }
      } else {
        throw Exception(_extractErrorMessage(response.data, 'Login failed'));
      }
    } on DioException catch (e) {
      throw Exception(_extractErrorMessage(e.response?.data, e.message ?? 'Network error'));
    } catch (e) {
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
        throw Exception(_extractErrorMessage(response.data, 'Failed to create farmer profile'));
      }
    } on DioException catch (e) {
      throw Exception(_extractErrorMessage(e.response?.data, e.message ?? 'Network error'));
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
        throw Exception(_extractErrorMessage(response.data, 'Failed to create trader profile'));
      }
    } on DioException catch (e) {
      throw Exception(_extractErrorMessage(e.response?.data, e.message ?? 'Network error'));
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
        throw Exception(_extractErrorMessage(response.data, 'Failed to create consumer profile'));
      }
    } on DioException catch (e) {
      throw Exception(_extractErrorMessage(e.response?.data, e.message ?? 'Network error'));
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}