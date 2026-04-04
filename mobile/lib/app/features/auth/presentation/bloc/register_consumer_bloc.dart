import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hamrokrishi_app/app/features/auth/domain/usecases/register_consumer_use_case.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/bloc/register_consumer_event.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/bloc/register_consumer_state.dart';

class RegisterConsumerBloc extends Bloc<RegisterConsumerEvent, RegisterConsumerState> {
  final RegisterConsumerUseCase registerConsumerUseCase;

  RegisterConsumerBloc({required this.registerConsumerUseCase}) : super(const RegisterConsumerState.initial()) {
    on<RegisterSubmitted>(_onRegisterSubmitted);
    on<TogglePasswordVisibility>(_onTogglePasswordVisibility);
  }

  Future<void> _onRegisterSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterConsumerState> emit,
  ) async {
    emit(RegisterConsumerState.loading(isPasswordHidden: state.isPasswordHidden));

    final result = await registerConsumerUseCase(
      name: event.name,
      email: event.email,
      password: event.password,
      phone: event.phone,
      latitude: event.latitude,
      longitude: event.longitude,
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
      initial: (isHidden) => emit(RegisterConsumerState.initial(isPasswordHidden: !isHidden)),
      loading: (isHidden) => emit(RegisterConsumerState.loading(isPasswordHidden: !isHidden)),
      success: (isHidden) => emit(RegisterConsumerState.success(isPasswordHidden: !isHidden)),
      failure: (error, isHidden) => emit(RegisterConsumerState.failure(error: error, isPasswordHidden: !isHidden)),
      orElse: () {},
    );
  }
}
