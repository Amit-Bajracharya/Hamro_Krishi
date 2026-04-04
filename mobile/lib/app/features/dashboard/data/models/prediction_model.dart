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
    return PredictionModel(
      productName: json['productName'] as String,
      demandLevel: json['demandLevel'] as String,
      estimatedPriceTrend: json['estimatedPriceTrend'] as String,
      reasoning: json['reasoning'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => _$PredictionModelToJson(this);
}
