import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_consumer_event.freezed.dart';

@freezed
class RegisterConsumerEvent with _$RegisterConsumerEvent {
  const factory RegisterConsumerEvent.registerSubmitted({
    required String name,
    required String email,
    required String password,
    required String phone,
    required double latitude,
    required double longitude,
  }) = RegisterSubmitted;

  const factory RegisterConsumerEvent.togglePasswordVisibility() = TogglePasswordVisibility;
}
