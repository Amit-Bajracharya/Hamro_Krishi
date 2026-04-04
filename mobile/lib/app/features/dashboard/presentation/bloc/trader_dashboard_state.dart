import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hamrokrishi_app/app/features/product/domain/entities/product_entity.dart';

part 'trader_dashboard_state.freezed.dart';

@freezed
class TraderDashboardState with _$TraderDashboardState {
  const factory TraderDashboardState.initial() = TraderDashboardInitial;
  const factory TraderDashboardState.loading() = TraderDashboardLoading;
  const factory TraderDashboardState.loaded({
    required int farmerCount,
    required List<ProductEntity> products,
  }) = TraderDashboardLoaded;
  const factory TraderDashboardState.error(String message) = TraderDashboardError;
}
