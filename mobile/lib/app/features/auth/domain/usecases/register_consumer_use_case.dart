import 'package:dartz/dartz.dart';
import 'package:hamrokrishi_app/app/features/auth/domain/repositories/auth_repository.dart';

class RegisterConsumerUseCase {
  final AuthRepository repository;

  RegisterConsumerUseCase(this.repository);

  Future<Either<String, void>> call({
    required String name,
    required String email,
    required String password,
    required String phone,
    required double latitude,
    required double longitude,
  }) {
    return repository.registerConsumer(
      name: name,
      email: email,
      password: password,
      phone: phone,
      latitude: latitude,
      longitude: longitude,
    );
  }
}
