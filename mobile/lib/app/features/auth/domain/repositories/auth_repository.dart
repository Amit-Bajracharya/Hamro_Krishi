import 'package:dartz/dartz.dart';
import 'package:hamrokrishi_app/app/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<String, UserEntity>> login({
    required String identity,
    required String password,
  });

  Future<Either<String, void>> registerFarmer({
    required String name,
    required String email,
    required String password,
    required String phone,
    required double latitude,
    required double longitude,
  });
}
