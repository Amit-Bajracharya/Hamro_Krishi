import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/contract_entity.dart';

abstract class IContractRepository {
  Future<Either<Failure, ContractEntity>> createContract(ContractEntity contract);
  Future<Either<Failure, List<ContractEntity>>> getUserContracts(String userId, String role);
  Future<Either<Failure, ContractEntity>> updateContractStatus(String id, String status);
}
