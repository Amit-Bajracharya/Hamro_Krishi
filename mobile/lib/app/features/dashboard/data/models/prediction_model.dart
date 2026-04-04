import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/prediction.dart';

part 'prediction_model.g.dart';

@JsonSerializable()
class PredictionModel extends Prediction {
  PredictionModel({
    required super.productName,
    required super.demandLevel,
    required super.estimatedPriceTrend,
    required super.reasoning,
  });

  factory PredictionModel.fromJson(Map<String, dynamic> json) {
    // The backend returns it nested in { success: true, data: { ... } }
    final data = json['data'] as Map<String, dynamic>;
    return PredictionModel(
      productName: data['productName'] as String,
      demandLevel: data['demandLevel'] as String,
      estimatedPriceTrend: data['estimatedPriceTrend'] as String,
      reasoning: data['reasoning'] as String,
    );
  }

  Map<String, dynamic> toJson() => _$PredictionModelToJson(this);
}
