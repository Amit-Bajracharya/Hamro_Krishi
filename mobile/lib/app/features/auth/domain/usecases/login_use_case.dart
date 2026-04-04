import 'package:dartz/dartz.dart';
import 'package:hamrokrishi_app/app/features/auth/domain/entities/user_entity.dart';
import 'package:hamrokrishi_app/app/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<String, UserEntity>> call({
    required String identity,
    required String password,
  }) async {
    return await repository.login(identity: identity, password: password);
  }
}
