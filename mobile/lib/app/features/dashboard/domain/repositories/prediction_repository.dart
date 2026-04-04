import '../entities/prediction.dart';

abstract class IPredictionRepository {
  Future<List<Prediction>> getDemandPrediction(String productName);
}
