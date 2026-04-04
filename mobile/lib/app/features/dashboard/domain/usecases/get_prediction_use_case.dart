import '../entities/prediction.dart';
import '../repositories/prediction_repository.dart';

class GetPredictionUseCase {
  final IPredictionRepository repository;

  GetPredictionUseCase(this.repository);

  Future<Prediction> execute(String productName) async {
    return await repository.getDemandPrediction(productName);
  }
}
