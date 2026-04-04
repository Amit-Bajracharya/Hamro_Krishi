import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/contract_entity.dart';
import '../repositories/contract_repository.dart';

class GetUserContractsUseCase {
  final IContractRepository repository;

  GetUserContractsUseCase({required this.repository});

  Future<Either<Failure, List<ContractEntity>>> call(String userId, String role) async {
    return await repository.getUserContracts(userId, role);
  }
}
