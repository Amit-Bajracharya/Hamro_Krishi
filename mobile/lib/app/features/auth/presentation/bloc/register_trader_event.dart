import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_trader_event.freezed.dart';

@freezed
class RegisterTraderEvent with _$RegisterTraderEvent {
  const factory RegisterTraderEvent.registerSubmitted({
    required String name,
    required String email,
    required String password,
    required String phone,
    required double latitude,
    required double longitude,
    required String businessName,
    required String operatingRegions,
  }) = RegisterSubmitted;

  const factory RegisterTraderEvent.togglePasswordVisibility() = TogglePasswordVisibility;
}
