import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_weather_use_case.dart';
import 'weather_event.dart';
import 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeatherUseCase getWeatherUseCase;

  WeatherBloc({required this.getWeatherUseCase}) : super(const WeatherState.initial()) {
    on<FetchWeather>(_onFetchWeather);
  }

  Future<void> _onFetchWeather(
    FetchWeather event,
    Emitter<WeatherState> emit,
  ) async {
    emit(const WeatherState.loading());
    try {
      final weather = await getWeatherUseCase.execute(
        event.latitude,
        event.longitude,
      );
      emit(WeatherState.loaded(weather));
    } catch (e) {
      emit(WeatherState.error(e.toString()));
    }
  }
}
