// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherModel _$WeatherModelFromJson(Map<String, dynamic> json) => WeatherModel(
  temperature: (json['temperature'] as num).toDouble(),
  condition: json['condition'] as String,
  humidity: (json['humidity'] as num).toInt(),
  windSpeed: (json['windSpeed'] as num).toDouble(),
  rainProbability: (json['rainProbability'] as num).toInt(),
  icon: json['icon'] as String,
);

Map<String, dynamic> _$WeatherModelToJson(WeatherModel instance) =>
    <String, dynamic>{
      'temperature': instance.temperature,
      'condition': instance.condition,
      'humidity': instance.humidity,
      'windSpeed': instance.windSpeed,
      'rainProbability': instance.rainProbability,
      'icon': instance.icon,
    };
