import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hamrokrishi_app/app/features/auth/domain/usecases/login_use_case.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/bloc/login_event.dart';
import 'package:hamrokrishi_app/app/features/auth/presentation/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc({required this.loginUseCase}) : super(const LoginState.initial()) {
    on<LoginSubmitted>(_onLoginSubmitted);
    on<TogglePasswordVisibility>(_onTogglePasswordVisibility);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<LoginState> emit,
  ) async {
    emit(const LoginState.initial());
  }

  Future<void> _onLoginSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginState.loading(isPasswordHidden: state.isPasswordHidden));
    
    final result = await loginUseCase(
      identity: event.identity,
      password: event.password,
    );
    
    result.fold(
      (error) => emit(LoginState.failure(
        error: error,
        isPasswordHidden: state.isPasswordHidden,
      )),
      (user) => emit(LoginState.success(
        user: user,
        isPasswordHidden: state.isPasswordHidden,
      )),
    );
  }

  void _onTogglePasswordVisibility(
    TogglePasswordVisibility event,
    Emitter<LoginState> emit,
  ) {
    state.maybeWhen(
      initial: (isHidden) => emit(LoginState.initial(isPasswordHidden: !isHidden)),
      loading: (isHidden) => emit(LoginState.loading(isPasswordHidden: !isHidden)),
      success: (user, isHidden) => emit(LoginState.success(user: user, isPasswordHidden: !isHidden)),
      failure: (error, isHidden) => emit(LoginState.failure(error: error, isPasswordHidden: !isHidden)),
      orElse: () {},
    );
  }
}
