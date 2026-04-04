import 'package:hamrokrishi_app/app/features/dashboard/data/datasources/prediction_remote_data_source.dart';
import 'package:hamrokrishi_app/app/features/dashboard/domain/repositories/prediction_repository.dart';
import 'package:hamrokrishi_app/app/features/dashboard/domain/entities/prediction.dart';

class PredictionRepositoryImpl implements IPredictionRepository {
  final IPredictionRemoteDataSource remoteDataSource;

  PredictionRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Prediction> getDemandPrediction(String productName) async {
    return await remoteDataSource.getDemandPrediction(productName);
  }
}
