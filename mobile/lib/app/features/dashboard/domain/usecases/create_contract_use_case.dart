import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/contract_entity.dart';
import '../repositories/contract_repository.dart';

class CreateContractUseCase {
  final IContractRepository repository;

  CreateContractUseCase({required this.repository});

  Future<Either<Failure, ContractEntity>> call(ContractEntity contract) async {
    return await repository.createContract(contract);
  }
}
