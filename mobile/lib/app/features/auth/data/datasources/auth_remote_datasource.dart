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
      
      if (response.statusCode == 200) {
        return UserEntity.fromJson(response.data);
      } else {
        throw Exception(response.data['message'] ?? 'Login failed');
      }
    } on DioException catch (e) {
      final message = e.response?.data?['message'] ?? e.message ?? 'Network error';
      throw Exception(message);
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