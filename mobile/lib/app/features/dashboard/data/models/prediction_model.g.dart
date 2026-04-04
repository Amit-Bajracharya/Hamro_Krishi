// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prediction_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PredictionModel _$PredictionModelFromJson(Map<String, dynamic> json) =>
    PredictionModel(
      productName: json['productName'] as String,
      demandLevel: json['demandLevel'] as String,
      estimatedPriceTrend: json['estimatedPriceTrend'] as String,
      reasoning: json['reasoning'] as String,
    );

Map<String, dynamic> _$PredictionModelToJson(PredictionModel instance) =>
    <String, dynamic>{
      'productName': instance.productName,
      'demandLevel': instance.demandLevel,
      'estimatedPriceTrend': instance.estimatedPriceTrend,
      'reasoning': instance.reasoning,
    };
