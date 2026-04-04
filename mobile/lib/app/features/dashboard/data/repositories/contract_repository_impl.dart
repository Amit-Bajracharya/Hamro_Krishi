import 'package:dartz/dartz.dart';
import 'package:hamrokrishi_app/app/features/dashboard/domain/entities/contract_entity.dart';
import '../../../../core/error/failures.dart';
import '../datasources/contract_remote_data_source.dart';

import '../models/contract_model.dart';
import '../../domain/repositories/contract_repository.dart';

class ContractRepositoryImpl implements IContractRepository {
  final IContractRemoteDataSource remoteDataSource;

  ContractRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, ContractEntity>> createContract(ContractEntity contract) async {
    try {
      final model = ContractModel.fromEntity(contract);
      final resultModel = await remoteDataSource.createContract(model);
      return Right(resultModel.toEntity());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ContractEntity>>> getUserContracts(String userId, String role) async {
    try {
      final models = await remoteDataSource.getUserContracts(userId, role);
      final entities = models.map((model) => model.toEntity()).toList();
      return Right(entities);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, ContractEntity>> updateContractStatus(String id, String status) async {
    try {
      final model = await remoteDataSource.updateContractStatus(id, status);
      return Right(model.toEntity());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
