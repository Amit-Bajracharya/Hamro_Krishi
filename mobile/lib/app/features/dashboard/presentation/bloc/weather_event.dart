import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_event.freezed.dart';

@freezed
abstract class WeatherEvent with _$WeatherEvent {
  const factory WeatherEvent.fetchWeather({
    required double latitude,
    required double longitude,
  }) = FetchWeather;
}
