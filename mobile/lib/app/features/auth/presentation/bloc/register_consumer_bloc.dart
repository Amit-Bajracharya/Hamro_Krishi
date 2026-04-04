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
    emit(state.copyWith(isLocationLoading: true));
    try {
      final position = await locationService.getCurrentPosition();
      emit(state.copyWith(
        latitude: position.latitude,
        longitude: position.longitude,
        isLocationLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        isLocationLoading: false,
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
      )),
      (_) => emit(RegisterConsumerState.success(
        isPasswordHidden: state.isPasswordHidden,
      )),
    );
  }

  void _onTogglePasswordVisibility(
    TogglePasswordVisibility event,
    Emitter<RegisterConsumerState> emit,
  ) {
    state.maybeWhen(
      initial: (isHidden, lat, lng, isLocLoading) => emit(RegisterConsumerState.initial(
        isPasswordHidden: !isHidden,
        latitude: lat,        longitude: lng,        isLocationLoading: isLocLoading,
      )),
      loading: (isHidden, lat, lng, isLocLoading) => emit(RegisterConsumerState.loading(
        isPasswordHidden: !isHidden,
        latitude: lat,        longitude: lng,        isLocationLoading: isLocLoading,
      )),
      success: (isHidden, lat, lng, isLocLoading) => emit(RegisterConsumerState.success(
        isPasswordHidden: !isHidden,
        latitude: lat,        longitude: lng,        isLocationLoading: isLocLoading,
      )),
      failure: (error, isHidden, lat, lng, isLocLoading) => emit(RegisterConsumerState.failure(
        error: error,
        isPasswordHidden: !isHidden,
        latitude: lat,        longitude: lng,        isLocationLoading: isLocLoading,
      )),
      orElse: () {},
    );
  }
}
