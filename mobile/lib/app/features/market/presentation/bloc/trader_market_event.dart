import 'package:freezed_annotation/freezed_annotation.dart';

part 'trader_market_event.freezed.dart';

@freezed
class TraderMarketEvent with _$TraderMarketEvent {
  const factory TraderMarketEvent.fetchData() = FetchMarketData;
}
