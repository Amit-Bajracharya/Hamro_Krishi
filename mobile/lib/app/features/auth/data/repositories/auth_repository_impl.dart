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
}
