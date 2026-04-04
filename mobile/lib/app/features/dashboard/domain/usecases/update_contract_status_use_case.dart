import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/contract_entity.dart';
import '../repositories/contract_repository.dart';

class UpdateContractStatusUseCase {
  final IContractRepository repository;

  UpdateContractStatusUseCase({required this.repository});

  Future<Either<Failure, ContractEntity>> call(String id, String status) async {
    return await repository.updateContractStatus(id, status);
  }
}
