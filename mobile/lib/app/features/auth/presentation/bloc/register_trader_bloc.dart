import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hamrokrishi_app/app/core/services/location_service.dart';
import 'package:hamrokrishi_app/app/features/auth/domain/usecases/register_trader_use_case.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/bloc/register_trader_event.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/bloc/register_trader_state.dart';

class RegisterTraderBloc extends Bloc<RegisterTraderEvent, RegisterTraderState> {
  final RegisterTraderUseCase registerTraderUseCase;
  final LocationService locationService;

  RegisterTraderBloc({
    required this.registerTraderUseCase,
    required this.locationService,
  }) : super(const RegisterTraderState.initial()) {
    on<RegisterSubmitted>(_onRegisterSubmitted);
    on<TogglePasswordVisibility>(_onTogglePasswordVisibility);
    on<FetchLocation>(_onFetchLocation);
  }

  Future<void> _onFetchLocation(
    FetchLocation event,
    Emitter<RegisterTraderState> emit,
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
    Emitter<RegisterTraderState> emit,
  ) async {
    emit(RegisterTraderState.loading(
      isPasswordHidden: state.isPasswordHidden,
      latitude: state.latitude,
      longitude: state.longitude,
      locationError: state.locationError,
    ));

    final result = await registerTraderUseCase(
      name: event.name,
      email: event.email,
      password: event.password,
      phone: event.phone,
      latitude: state.latitude ?? 0.0,
      longitude: state.longitude ?? 0.0,
      businessName: event.businessName,
      operatingRegions: event.operatingRegions,
    );

    result.fold(
      (error) => emit(RegisterTraderState.failure(
        error: error,
        isPasswordHidden: state.isPasswordHidden,
        latitude: state.latitude,
        longitude: state.longitude,
        locationError: state.locationError,
      )),
      (_) => emit(RegisterTraderState.success(
        isPasswordHidden: state.isPasswordHidden,
        latitude: state.latitude,
        longitude: state.longitude,
        locationError: state.locationError,
      )),
    );
  }

  void _onTogglePasswordVisibility(
    TogglePasswordVisibility event,
    Emitter<RegisterTraderState> emit,
  ) {
    state.maybeWhen(
      initial: (isHidden, lat, lng, isLocLoading, locErr) => emit(RegisterTraderState.initial(
        isPasswordHidden: !isHidden,
        latitude: lat,
        longitude: lng,
        isLocationLoading: isLocLoading,
        locationError: locErr,
      )),
      loading: (isHidden, lat, lng, isLocLoading, locErr) => emit(RegisterTraderState.loading(
        isPasswordHidden: !isHidden,
        latitude: lat,
        longitude: lng,
        isLocationLoading: isLocLoading,
        locationError: locErr,
      )),
      success: (isHidden, lat, lng, isLocLoading, locErr) => emit(RegisterTraderState.success(
        isPasswordHidden: !isHidden,
        latitude: lat,
        longitude: lng,
        isLocationLoading: isLocLoading,
        locationError: locErr,
      )),
      failure: (error, isHidden, lat, lng, isLocLoading, locErr) => emit(RegisterTraderState.failure(
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
