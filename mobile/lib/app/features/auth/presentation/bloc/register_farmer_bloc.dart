import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hamrokrishi_app/app/core/services/location_service.dart';
import 'package:hamrokrishi_app/app/features/auth/domain/usecases/register_farmer_use_case.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/bloc/register_farmer_event.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/bloc/register_farmer_state.dart';

class RegisterFarmerBloc extends Bloc<RegisterFarmerEvent, RegisterFarmerState> {
  final RegisterFarmerUseCase registerFarmerUseCase;
  final LocationService locationService;

  RegisterFarmerBloc({
    required this.registerFarmerUseCase,
    required this.locationService,
  }) : super(const RegisterFarmerState.initial()) {
    on<RegisterSubmitted>(_onRegisterSubmitted);
    on<TogglePasswordVisibility>(_onTogglePasswordVisibility);
    on<FetchLocation>(_onFetchLocation);
  }

  Future<void> _onFetchLocation(
    FetchLocation event,
    Emitter<RegisterFarmerState> emit,
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
        // We could also emit a failure state specifically for location, 
        // but for now we'll just stop loading.
      ));
    }
  }

  Future<void> _onRegisterSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterFarmerState> emit,
  ) async {
    emit(RegisterFarmerState.loading(
      isPasswordHidden: state.isPasswordHidden,
      latitude: state.latitude,
      longitude: state.longitude,
    ));

    final result = await registerFarmerUseCase(
      name: event.name,
      email: event.email,
      password: event.password,
      phone: event.phone,
      latitude: state.latitude ?? 0.0,
      longitude: state.longitude ?? 0.0,
    );

    result.fold(
      (error) => emit(RegisterFarmerState.failure(
        error: error,
        isPasswordHidden: state.isPasswordHidden,
      )),
      (_) => emit(RegisterFarmerState.success(
        isPasswordHidden: state.isPasswordHidden,
      )),
    );
  }

  void _onTogglePasswordVisibility(
    TogglePasswordVisibility event,
    Emitter<RegisterFarmerState> emit,
  ) {
    state.maybeWhen(
      initial: (isHidden, lat, lng, isLocLoading) => emit(RegisterFarmerState.initial(
        isPasswordHidden: !isHidden,
        latitude: lat,
        longitude: lng,
        isLocationLoading: isLocLoading,
      )),
      loading: (isHidden, lat, lng, isLocLoading) => emit(RegisterFarmerState.loading(
        isPasswordHidden: !isHidden,
        latitude: lat,
        longitude: lng,
        isLocationLoading: isLocLoading,
      )),
      success: (isHidden, lat, lng, isLocLoading) => emit(RegisterFarmerState.success(
        isPasswordHidden: !isHidden,
        latitude: lat,
        longitude: lng,
        isLocationLoading: isLocLoading,
      )),
      failure: (error, isHidden, lat, lng, isLocLoading) => emit(RegisterFarmerState.failure(
        error: error,
        isPasswordHidden: !isHidden,
        latitude: lat,
        longitude: lng,
        isLocationLoading: isLocLoading,
      )),
      orElse: () {},
    );
  }
}
