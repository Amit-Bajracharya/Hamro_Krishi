import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hamrokrishi_app/app/features/dashboard/domain/repositories/farmer_repository.dart';
import 'package:hamrokrishi_app/app/features/product/domain/repositories/product_repository.dart';
import 'trader_dashboard_event.dart';
import 'trader_dashboard_state.dart';

class TraderDashboardBloc extends Bloc<TraderDashboardEvent, TraderDashboardState> {
  final IFarmerRepository farmerRepository;
  final IProductRepository productRepository;

  TraderDashboardBloc({
    required this.farmerRepository,
    required this.productRepository,
  }) : super(const TraderDashboardInitial()) {
    on<FetchTraderDashboardData>(_onFetchData);
  }

  Future<void> _onFetchData(
    FetchTraderDashboardData event,
    Emitter<TraderDashboardState> emit,
  ) async {
    emit(const TraderDashboardLoading());

    final farmerResult = await farmerRepository.getFarmerCount();
    final productResult = await productRepository.getAllProducts();

    farmerResult.fold(
      (failure) => emit(TraderDashboardError(failure.message)),
      (count) {
        productResult.fold(
          (failure) => emit(TraderDashboardError(failure.message)),
          (products) => emit(TraderDashboardLoaded(
            farmerCount: count,
            products: products,
          )),
        );
      },
    );
  }
}
