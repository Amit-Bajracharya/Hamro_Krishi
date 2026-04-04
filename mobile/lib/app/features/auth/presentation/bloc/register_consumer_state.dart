import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_consumer_state.freezed.dart';

@freezed
abstract class RegisterConsumerState with _$RegisterConsumerState {
  const factory RegisterConsumerState.initial({@Default(true) bool isPasswordHidden}) = Initial;
  const factory RegisterConsumerState.loading({required bool isPasswordHidden}) = Loading;
  const factory RegisterConsumerState.success({required bool isPasswordHidden}) = Success;
  const factory RegisterConsumerState.failure({required String error, required bool isPasswordHidden}) = Failure;
}
