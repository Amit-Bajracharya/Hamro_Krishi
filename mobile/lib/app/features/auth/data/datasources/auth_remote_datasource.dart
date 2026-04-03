import 'package:hamrokrishi_app/app/features/auth/domain/entities/user_entity.dart';

abstract class AuthRemoteDataSource {
  Future<UserEntity> login({
    required String identity,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<UserEntity> login({
    required String identity,
    required String password,
  }) async {
    // Mocking an API call
    await Future.delayed(const Duration(seconds: 2));
    if (identity == 'test@example.com' && password == 'password123') {
      return const UserEntity(
        id: '1',
        name: 'Amit Bajracharya',
        email: 'test@example.com',
      );
    } else {
      throw Exception('Invalid credentials');
    }
  }
}
