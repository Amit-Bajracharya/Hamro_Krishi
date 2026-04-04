import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/weather.dart';

part 'weather_model.g.dart';

@JsonSerializable()
class WeatherModel extends Weather {
  WeatherModel({
    required super.temperature,
    required super.condition,
    required super.humidity,
    required super.windSpeed,
    required super.rainProbability,
    required super.icon,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      temperature: (json['main']['temp'] as num).toDouble() - 273.15, // Kelvin to Celsius
      condition: json['weather'][0]['description'] as String,
      humidity: json['main']['humidity'] as int,
      windSpeed: (json['wind']['speed'] as num).toDouble() * 3.6, // m/s to km/h
      rainProbability: json['clouds']['all'] as int, 
      icon: json['weather'][0]['icon'] as String,
    );
  }

  Map<String, dynamic> toJson() => _$WeatherModelToJson(this);
}
