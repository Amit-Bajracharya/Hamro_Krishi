import 'package:dio/dio.dart';
import 'package:hamrokrishi_app/app/core/constants/api_constants.dart';
import '../models/weather_model.dart';

abstract class IWeatherRemoteDataSource {
  Future<WeatherModel> getWeather(double lat, double lon);
}

class WeatherRemoteDataSourceImpl implements IWeatherRemoteDataSource {
  final Dio dio;

  WeatherRemoteDataSourceImpl({required this.dio});

  @override
  Future<WeatherModel> getWeather(double lat, double lon) async {
    try {
      final response = await dio.get(
        '$WEATHER_BASE_URL/weather',
        queryParameters: {
          'lat': lat,
          'lon': lon,
          'appid': WEATHER_API_KEY,
        },
      );

      if (response.statusCode == 200) {
        return WeatherModel.fromJson(response.data);
      } else {
        throw Exception('Failed to load weather');
      }
    } on DioException catch (e) {
      throw Exception(e.message ?? 'Unknown error occurred');
    }
  }
}
