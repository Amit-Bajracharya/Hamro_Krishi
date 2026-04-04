import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hamrokrishi_app/app/features/auth/domain/usecases/register_trader_use_case.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/bloc/register_trader_event.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/bloc/register_trader_state.dart';

class RegisterTraderBloc extends Bloc<RegisterTraderEvent, RegisterTraderState> {
  final RegisterTraderUseCase registerTraderUseCase;

  RegisterTraderBloc({required this.registerTraderUseCase}) : super(const RegisterTraderState.initial()) {
    on<RegisterSubmitted>(_onRegisterSubmitted);
    on<TogglePasswordVisibility>(_onTogglePasswordVisibility);
  }

  Future<void> _onRegisterSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterTraderState> emit,
  ) async {
    emit(RegisterTraderState.loading(isPasswordHidden: state.isPasswordHidden));

    final result = await registerTraderUseCase(
      name: event.name,
      email: event.email,
      password: event.password,
      phone: event.phone,
      latitude: event.latitude,
      longitude: event.longitude,
      businessName: event.businessName,
      operatingRegions: event.operatingRegions,
    );

    result.fold(
      (error) => emit(RegisterTraderState.failure(
        error: error,
        isPasswordHidden: state.isPasswordHidden,
      )),
      (_) => emit(RegisterTraderState.success(
        isPasswordHidden: state.isPasswordHidden,
      )),
    );
  }

  void _onTogglePasswordVisibility(
    TogglePasswordVisibility event,
    Emitter<RegisterTraderState> emit,
  ) {
    state.maybeWhen(
      initial: (isHidden) => emit(RegisterTraderState.initial(isPasswordHidden: !isHidden)),
      loading: (isHidden) => emit(RegisterTraderState.loading(isPasswordHidden: !isHidden)),
      success: (isHidden) => emit(RegisterTraderState.success(isPasswordHidden: !isHidden)),
      failure: (error, isHidden) => emit(RegisterTraderState.failure(error: error, isPasswordHidden: !isHidden)),
      orElse: () {},
    );
  }
}
