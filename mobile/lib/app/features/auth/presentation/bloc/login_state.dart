import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hamrokrishi_app/app/features/auth/domain/entities/user_entity.dart';

part 'login_state.freezed.dart';

@freezed
abstract class LoginState with _$LoginState {
  const factory LoginState.initial({
    @Default(true) bool isPasswordHidden,
  }) = Initial;
  
  const factory LoginState.loading({
    required bool isPasswordHidden,
  }) = Loading;
  
  const factory LoginState.success({
    required UserEntity user,
    required bool isPasswordHidden,
  }) = Success;
  
  const factory LoginState.failure({
    required String error,
    required bool isPasswordHidden,
  }) = Failure;
}
