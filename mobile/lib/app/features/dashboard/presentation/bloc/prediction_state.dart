import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/prediction.dart';

part 'prediction_state.freezed.dart';

@freezed
class PredictionState with _$PredictionState {
  const factory PredictionState.initial() = PredictionInitial;
  const factory PredictionState.loading() = PredictionLoading;
  const factory PredictionState.loaded(List<Prediction> predictions) = PredictionLoaded;
  const factory PredictionState.error(String message) = PredictionError;
}
