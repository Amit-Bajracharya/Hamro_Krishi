import '../entities/weather.dart';
import '../repositories/weather_repository.dart';

class GetWeatherUseCase {
  final IWeatherRepository repository;

  GetWeatherUseCase(this.repository);

  Future<Weather> execute(double lat, double lon) async {
    return await repository.getWeather(lat, lon);
  }
}
