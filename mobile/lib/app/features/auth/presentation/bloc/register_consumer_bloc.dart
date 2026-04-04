import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hamrokrishi_app/app/core/services/location_service.dart';
import 'package:hamrokrishi_app/app/features/auth/domain/usecases/register_consumer_use_case.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/bloc/register_consumer_event.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/bloc/register_consumer_state.dart';

class RegisterConsumerBloc extends Bloc<RegisterConsumerEvent, RegisterConsumerState> {
  final RegisterConsumerUseCase registerConsumerUseCase;
  final LocationService locationService;

  RegisterConsumerBloc({
    required this.registerConsumerUseCase,
    required this.locationService,
  }) : super(const RegisterConsumerState.initial()) {
    on<RegisterSubmitted>(_onRegisterSubmitted);
    on<TogglePasswordVisibility>(_onTogglePasswordVisibility);
    on<FetchLocation>(_onFetchLocation);
  }

  Future<void> _onFetchLocation(
    FetchLocation event,
    Emitter<RegisterConsumerState> emit,
  ) async {
    emit(state.copyWith(
      isLocationLoading: true,
      locationError: null,
    ));
    try {
      final position = await locationService.getCurrentPosition();
      emit(state.copyWith(
        latitude: position.latitude,
        longitude: position.longitude,
        isLocationLoading: false,
        locationError: null,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLocationLoading: false,
        locationError: e.toString().replaceFirst('Exception: ', ''),
      ));
    }
  }

  Future<void> _onRegisterSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterConsumerState> emit,
  ) async {
    emit(RegisterConsumerState.loading(
      isPasswordHidden: state.isPasswordHidden,
      latitude: state.latitude,
      longitude: state.longitude,
      locationError: state.locationError,
    ));

    final result = await registerConsumerUseCase(
      name: event.name,
      email: event.email,
      password: event.password,
      phone: event.phone,
      latitude: state.latitude ?? 0.0,
      longitude: state.longitude ?? 0.0,
    );

    result.fold(
      (error) => emit(RegisterConsumerState.failure(
        error: error,
        isPasswordHidden: state.isPasswordHidden,
        latitude: state.latitude,
        longitude: state.longitude,
        locationError: state.locationError,
      )),
      (_) => emit(RegisterConsumerState.success(
        isPasswordHidden: state.isPasswordHidden,
        latitude: state.latitude,
        longitude: state.longitude,
        locationError: state.locationError,
      )),
    );
  }

  void _onTogglePasswordVisibility(
    TogglePasswordVisibility event,
    Emitter<RegisterConsumerState> emit,
  ) {
    state.maybeWhen(
      initial: (isHidden, lat, lng, isLocLoading, locErr) => emit(RegisterConsumerState.initial(
        isPasswordHidden: !isHidden,
        latitude: lat,
        longitude: lng,
        isLocationLoading: isLocLoading,
        locationError: locErr,
      )),
      loading: (isHidden, lat, lng, isLocLoading, locErr) => emit(RegisterConsumerState.loading(
        isPasswordHidden: !isHidden,
        latitude: lat,
        longitude: lng,
        isLocationLoading: isLocLoading,
        locationError: locErr,
      )),
      success: (isHidden, lat, lng, isLocLoading, locErr) => emit(RegisterConsumerState.success(
        isPasswordHidden: !isHidden,
        latitude: lat,
        longitude: lng,
        isLocationLoading: isLocLoading,
        locationError: locErr,
      )),
      failure: (error, isHidden, lat, lng, isLocLoading, locErr) => emit(RegisterConsumerState.failure(
        error: error,
        isPasswordHidden: !isHidden,
        latitude: lat,
        longitude: lng,
        isLocationLoading: isLocLoading,
        locationError: locErr,
      )),
      orElse: () {},
    );
  }
}
