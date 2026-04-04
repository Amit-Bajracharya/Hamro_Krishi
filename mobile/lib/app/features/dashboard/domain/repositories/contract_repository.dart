import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../entities/contract_entity.dart';

abstract class IContractRepository {
  Future<Either<Failure, ContractEntity>> createContract(ContractEntity contract);
}
