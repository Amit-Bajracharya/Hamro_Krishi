import '../entities/prediction.dart';

abstract class IPredictionRepository {
  Future<Prediction> getDemandPrediction(String productName);
}
