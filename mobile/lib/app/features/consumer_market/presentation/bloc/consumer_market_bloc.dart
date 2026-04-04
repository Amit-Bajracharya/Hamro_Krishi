import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hamrokrishi_app/app/features/consumer_market/data/datasources/consumer_market_remote_data_source.dart';
import 'package:hamrokrishi_app/app/features/consumer_market/domain/entities/market_item_entity.dart';

part 'consumer_market_bloc.freezed.dart';

// EVENTS
@freezed
class ConsumerMarketEvent with _$ConsumerMarketEvent {
  const factory ConsumerMarketEvent.fetchMarketplace() = FetchMarketplace;
}

// STATES
@freezed
class ConsumerMarketState with _$ConsumerMarketState {
  const factory ConsumerMarketState.initial() = ConsumerMarketInitial;
  const factory ConsumerMarketState.loading() = ConsumerMarketLoading;
  const factory ConsumerMarketState.loaded(List<MarketItemEntity> items) = ConsumerMarketLoaded;
  const factory ConsumerMarketState.error(String message) = ConsumerMarketError;
}

// BLOC
class ConsumerMarketBloc extends Bloc<ConsumerMarketEvent, ConsumerMarketState> {
  final IConsumerMarketRemoteDataSource remoteDataSource;

  ConsumerMarketBloc({required this.remoteDataSource}) : super(const ConsumerMarketInitial()) {
    on<FetchMarketplace>(_onFetchMarketplace);
  }

  Future<void> _onFetchMarketplace(FetchMarketplace event, Emitter<ConsumerMarketState> emit) async {
    emit(const ConsumerMarketLoading());
    try {
      final items = await remoteDataSource.getConsumerMarketplace();
      emit(ConsumerMarketLoaded(items));
    } catch (e) {
      emit(ConsumerMarketError(e.toString()));
    }
  }
}
