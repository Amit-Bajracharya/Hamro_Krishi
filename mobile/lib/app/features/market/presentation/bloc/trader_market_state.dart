import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hamrokrishi_app/app/features/product/domain/entities/product_entity.dart';

part 'trader_market_state.freezed.dart';

@freezed
class TraderMarketState with _$TraderMarketState {
  const factory TraderMarketState.initial() = MarketInitial;
  const factory TraderMarketState.loading() = MarketLoading;
  const factory TraderMarketState.loaded({
    required int farmerCount,
    required List<ProductEntity> products,
  }) = MarketLoaded;
  const factory TraderMarketState.error(String message) = MarketError;
}
