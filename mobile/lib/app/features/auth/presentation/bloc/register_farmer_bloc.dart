import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hamrokrishi_app/app/features/auth/domain/usecases/register_farmer_use_case.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/bloc/register_farmer_event.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/bloc/register_farmer_state.dart';

class RegisterFarmerBloc extends Bloc<RegisterFarmerEvent, RegisterFarmerState> {
  final RegisterFarmerUseCase registerFarmerUseCase;

  RegisterFarmerBloc({required this.registerFarmerUseCase}) : super(const RegisterFarmerState.initial()) {
    on<RegisterSubmitted>(_onRegisterSubmitted);
    on<TogglePasswordVisibility>(_onTogglePasswordVisibility);
  }

  Future<void> _onRegisterSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterFarmerState> emit,
  ) async {
    emit(RegisterFarmerState.loading(isPasswordHidden: state.isPasswordHidden));

    final result = await registerFarmerUseCase(
      name: event.name,
      email: event.email,
      password: event.password,
      phone: event.phone,
      latitude: event.latitude,
      longitude: event.longitude,
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
      initial: (isHidden) => emit(RegisterFarmerState.initial(isPasswordHidden: !isHidden)),
      loading: (isHidden) => emit(RegisterFarmerState.loading(isPasswordHidden: !isHidden)),
      success: (isHidden) => emit(RegisterFarmerState.success(isPasswordHidden: !isHidden)),
      failure: (error, isHidden) => emit(RegisterFarmerState.failure(error: error, isPasswordHidden: !isHidden)),
      orElse: () {},
    );
  }
}
