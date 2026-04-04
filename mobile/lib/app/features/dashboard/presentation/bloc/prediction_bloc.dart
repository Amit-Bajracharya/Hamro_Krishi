import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_prediction_use_case.dart';
import 'prediction_event.dart';
import 'prediction_state.dart';

class PredictionBloc extends Bloc<PredictionEvent, PredictionState> {
  final GetPredictionUseCase getPredictionUseCase;

  PredictionBloc({required this.getPredictionUseCase}) : super(const PredictionInitial()) {
    on<FetchPrediction>(_onFetchPrediction);
  }

  Future<void> _onFetchPrediction(
    FetchPrediction event,
    Emitter<PredictionState> emit,
  ) async {
    emit(const PredictionLoading());
    try {
      final prediction = await getPredictionUseCase.execute(event.productName);
      emit(PredictionLoaded(prediction));
    } catch (e) {
      emit(PredictionError(e.toString()));
    }
  }
}
