import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_farmer_event.freezed.dart';

@freezed
class RegisterFarmerEvent with _$RegisterFarmerEvent {
  const factory RegisterFarmerEvent.registerSubmitted({
    required String name,
    required String email,
    required String password,
    required String phone,
    required double latitude,
    required double longitude,
  }) = RegisterSubmitted;

  const factory RegisterFarmerEvent.togglePasswordVisibility() = TogglePasswordVisibility;
  const factory RegisterFarmerEvent.fetchLocation() = FetchLocation;
}
