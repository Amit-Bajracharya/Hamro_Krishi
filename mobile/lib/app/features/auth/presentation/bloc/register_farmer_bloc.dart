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
    Emitter<RegisterFarmerState> emit,
  ) async {
    emit(RegisterFarmerState.loading(
      isPasswordHidden: state.isPasswordHidden,
      latitude: state.latitude,
      longitude: state.longitude,
      locationError: state.locationError,
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
        latitude: state.latitude,
        longitude: state.longitude,
        locationError: state.locationError,
      )),
      (_) => emit(RegisterFarmerState.success(
        isPasswordHidden: state.isPasswordHidden,
        latitude: state.latitude,
        longitude: state.longitude,
        locationError: state.locationError,
      )),
    );
  }

  void _onTogglePasswordVisibility(
    TogglePasswordVisibility event,
    Emitter<RegisterFarmerState> emit,
  ) {
    state.maybeWhen(
      initial: (isHidden, lat, lng, isLocLoading, locErr) => emit(RegisterFarmerState.initial(
        isPasswordHidden: !isHidden,
        latitude: lat,
        longitude: lng,
        isLocationLoading: isLocLoading,
        locationError: locErr,
      )),
      loading: (isHidden, lat, lng, isLocLoading, locErr) => emit(RegisterFarmerState.loading(
        isPasswordHidden: !isHidden,
        latitude: lat,
        longitude: lng,
        isLocationLoading: isLocLoading,
        locationError: locErr,
      )),
      success: (isHidden, lat, lng, isLocLoading, locErr) => emit(RegisterFarmerState.success(
        isPasswordHidden: !isHidden,
        latitude: lat,
        longitude: lng,
        isLocationLoading: isLocLoading,
        locationError: locErr,
      )),
      failure: (error, isHidden, lat, lng, isLocLoading, locErr) => emit(RegisterFarmerState.failure(
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
