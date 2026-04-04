import 'package:freezed_annotation/freezed_annotation.dart';

part 'trader_dashboard_event.freezed.dart';

@freezed
class TraderDashboardEvent with _$TraderDashboardEvent {
  const factory TraderDashboardEvent.fetchData() = FetchTraderDashboardData;
}
