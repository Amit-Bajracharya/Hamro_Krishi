import 'package:dio/dio.dart';
import 'package:hamrokrishi_app/app/core/constants/api_constants.dart';
import 'package:hamrokrishi_app/app/features/auth/domain/entities/user_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
      // 1. Sign up user via Supabase
      final authResponse = await Supabase.instance.client.auth.signUp(
        email: email,
        password: password,
      );

      final user = authResponse.user;
      if (user == null) {
        throw Exception('Signup failed: No user returned from Supabase');
      }

      // 2. Call Node.js backend to create farmer profile
      final response = await dio.post(
        ApiConstants.farmers,
        data: {
          'id': user.id,
          'name': name,
          'email': email,
          'phone': phone,
          'latitude': latitude,
          'longitude': longitude,
        },
      );

      if (response.statusCode != 201) {
        throw Exception(response.data['error'] ?? 'Failed to create farmer profile');
      }
    } on AuthException catch (e) {
      throw Exception(e.message);
    } on DioException catch (e) {
      final message = e.response?.data?['error'] ?? e.message ?? 'Network error';
      throw Exception(message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}