import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_farmer_state.freezed.dart';

@freezed
abstract class RegisterFarmerState with _$RegisterFarmerState {
  const factory RegisterFarmerState.initial({
    @Default(true) bool isPasswordHidden,
  }) = Initial;

  const factory RegisterFarmerState.loading({
    required bool isPasswordHidden,
  }) = Loading;

  const factory RegisterFarmerState.success({
    required bool isPasswordHidden,
  }) = Success;

  const factory RegisterFarmerState.failure({
    required String error,
    required bool isPasswordHidden,
  }) = Failure;
}
