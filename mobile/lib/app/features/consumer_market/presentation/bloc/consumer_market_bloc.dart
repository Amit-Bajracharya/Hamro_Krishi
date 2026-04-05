import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hamrokrishi_app/app/features/consumer_market/data/datasources/consumer_market_remote_data_source.dart';
import 'package:hamrokrishi_app/app/features/consumer_market/domain/entities/market_item_entity.dart';
import 'package:hamrokrishi_app/app/features/product/domain/entities/product_entity.dart';
import 'package:hamrokrishi_app/app/features/product/domain/repositories/product_repository.dart';

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
  const factory ConsumerMarketState.loaded({
    required List<MarketItemEntity> marketItems,
    required List<ProductEntity> farmerProducts,
  }) = ConsumerMarketLoaded;
  const factory ConsumerMarketState.error(String message) = ConsumerMarketError;
}

// BLOC
class ConsumerMarketBloc extends Bloc<ConsumerMarketEvent, ConsumerMarketState> {
  final IConsumerMarketRemoteDataSource remoteDataSource;
  final IProductRepository productRepository;

  ConsumerMarketBloc({
    required this.remoteDataSource,
    required this.productRepository,
  }) : super(const ConsumerMarketInitial()) {
    on<FetchMarketplace>(_onFetchMarketplace);
  }

  Future<void> _onFetchMarketplace(FetchMarketplace event, Emitter<ConsumerMarketState> emit) async {
    emit(const ConsumerMarketLoading());
    try {
      final items = await remoteDataSource.getConsumerMarketplace();
      final productsResult = await productRepository.getAllProducts();
      
      final farmerProducts = productsResult.fold(
        (failure) => <ProductEntity>[],
        (products) => products,
      );
      
      emit(ConsumerMarketLoaded(
        marketItems: items,
        farmerProducts: farmerProducts,
      ));
    } catch (e) {
      emit(ConsumerMarketError(e.toString()));
    }
  }
}
