import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_consumer_state.freezed.dart';

@freezed
abstract class RegisterConsumerState with _$RegisterConsumerState {
  const factory RegisterConsumerState.initial({
    @Default(true) bool isPasswordHidden,
    double? latitude,
    double? longitude,
    @Default(false) bool isLocationLoading,
  }) = Initial;

  const factory RegisterConsumerState.loading({
    required bool isPasswordHidden,
    double? latitude,
    double? longitude,
    @Default(false) bool isLocationLoading,
  }) = Loading;

  const factory RegisterConsumerState.success({
    required bool isPasswordHidden,
    double? latitude,
    double? longitude,
    @Default(false) bool isLocationLoading,
  }) = Success;

  const factory RegisterConsumerState.failure({
    required String error,
    required bool isPasswordHidden,
    double? latitude,
    double? longitude,
    @Default(false) bool isLocationLoading,
  }) = Failure;
}
