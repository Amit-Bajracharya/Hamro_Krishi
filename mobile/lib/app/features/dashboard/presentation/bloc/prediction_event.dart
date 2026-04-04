import 'package:freezed_annotation/freezed_annotation.dart';

part 'prediction_event.freezed.dart';

@freezed
abstract class PredictionEvent with _$PredictionEvent {
  const factory PredictionEvent.fetchPrediction({
    required String productName,
  }) = FetchPrediction;
}
