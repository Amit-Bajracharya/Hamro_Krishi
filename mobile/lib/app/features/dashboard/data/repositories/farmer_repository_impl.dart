import 'package:dartz/dartz.dart';
import 'package:hamrokrishi_app/app/core/error/failures.dart';
import 'package:hamrokrishi_app/app/features/dashboard/data/datasources/farmer_remote_data_source.dart';
import 'package:hamrokrishi_app/app/features/dashboard/domain/repositories/farmer_repository.dart';

class FarmerRepositoryImpl implements IFarmerRepository {
  final IFarmerRemoteDataSource remoteDataSource;

  FarmerRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, int>> getFarmerCount() async {
    try {
      final count = await remoteDataSource.getFarmerCount();
      return Right(count);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
