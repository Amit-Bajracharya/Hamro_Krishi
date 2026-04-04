import 'package:hamrokrishi_app/app/features/dashboard/data/datasources/weather_remote_data_source.dart';
import 'package:hamrokrishi_app/app/features/dashboard/domain/repositories/weather_repository.dart';
import 'package:hamrokrishi_app/app/features/dashboard/domain/entities/weather.dart';

class WeatherRepositoryImpl implements IWeatherRepository {
  final IWeatherRemoteDataSource remoteDataSource;

  WeatherRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Weather> getWeather(double lat, double lon) async {
    return await remoteDataSource.getWeather(lat, lon);
  }
}
