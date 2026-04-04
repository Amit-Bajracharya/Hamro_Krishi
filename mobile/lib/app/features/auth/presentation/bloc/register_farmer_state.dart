import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_farmer_state.freezed.dart';

@freezed
abstract class RegisterFarmerState with _$RegisterFarmerState {
  const factory RegisterFarmerState.initial({
    @Default(true) bool isPasswordHidden,
    double? latitude,
    double? longitude,
    @Default(false) bool isLocationLoading,
  }) = Initial;

  const factory RegisterFarmerState.loading({
    required bool isPasswordHidden,
    double? latitude,
    double? longitude,
    @Default(false) bool isLocationLoading,
  }) = Loading;

  const factory RegisterFarmerState.success({
    required bool isPasswordHidden,
    double? latitude,
    double? longitude,
    @Default(false) bool isLocationLoading,
  }) = Success;

  const factory RegisterFarmerState.failure({
    required String error,
    required bool isPasswordHidden,
    double? latitude,
    double? longitude,
    @Default(false) bool isLocationLoading,
  }) = Failure;
}
