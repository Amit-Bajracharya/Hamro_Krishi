import 'package:dartz/dartz.dart';
import 'package:hamrokrishi_app/app/features/auth/domain/repositories/auth_repository.dart';

class RegisterTraderUseCase {
  final AuthRepository repository;

  RegisterTraderUseCase(this.repository);

  Future<Either<String, void>> call({
    required String name,
    required String email,
    required String password,
    required String phone,
    required double latitude,
    required double longitude,
    required String businessName,
    required String operatingRegions,
  }) {
    return repository.registerTrader(
      name: name,
      email: email,
      password: password,
      phone: phone,
      latitude: latitude,
      longitude: longitude,
      businessName: businessName,
      operatingRegions: operatingRegions,
    );
  }
}
