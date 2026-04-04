import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_trader_state.freezed.dart';

@freezed
abstract class RegisterTraderState with _$RegisterTraderState {
  const factory RegisterTraderState.initial({
    @Default(true) bool isPasswordHidden,
    double? latitude,
    double? longitude,
    @Default(false) bool isLocationLoading,
  }) = Initial;

  const factory RegisterTraderState.loading({
    required bool isPasswordHidden,
    double? latitude,
    double? longitude,
    @Default(false) bool isLocationLoading,
  }) = Loading;

  const factory RegisterTraderState.success({
    required bool isPasswordHidden,
    double? latitude,
    double? longitude,
    @Default(false) bool isLocationLoading,
  }) = Success;

  const factory RegisterTraderState.failure({
    required String error,
    required bool isPasswordHidden,
    double? latitude,
    double? longitude,
    @Default(false) bool isLocationLoading,
  }) = Failure;
}
