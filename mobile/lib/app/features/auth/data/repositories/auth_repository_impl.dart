import 'package:dartz/dartz.dart';
import 'package:hamrokrishi_app/app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:hamrokrishi_app/app/features/auth/domain/entities/user_entity.dart';
import 'package:hamrokrishi_app/app/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<String, UserEntity>> login({
    required String identity,
    required String password,
  }) async {
    try {
      final user = await remoteDataSource.login(identity: identity, password: password);
      return Right(user);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> registerFarmer({
    required String name,
    required String email,
    required String password,
    required String phone,
    required double latitude,
    required double longitude,
  }) async {
    try {
      await remoteDataSource.registerFarmer(
        name: name,
        email: email,
        password: password,
        phone: phone,
        latitude: latitude,
        longitude: longitude,
      );
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> registerTrader({
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
      await remoteDataSource.registerTrader(
        name: name,
        email: email,
        password: password,
        phone: phone,
        latitude: latitude,
        longitude: longitude,
        businessName: businessName,
        operatingRegions: operatingRegions,
      );
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> registerConsumer({
    required String name,
    required String email,
    required String password,
    required String phone,
    required double latitude,
    required double longitude,
  }) async {
    try {
      await remoteDataSource.registerConsumer(
        name: name,
        email: email,
        password: password,
        phone: phone,
        latitude: latitude,
        longitude: longitude,
      );
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }
}