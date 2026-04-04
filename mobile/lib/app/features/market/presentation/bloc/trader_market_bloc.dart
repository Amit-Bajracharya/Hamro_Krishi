import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hamrokrishi_app/app/features/dashboard/domain/repositories/farmer_repository.dart';
import 'package:hamrokrishi_app/app/features/product/domain/repositories/product_repository.dart';
import 'trader_market_event.dart';
import 'trader_market_state.dart';

class TraderMarketBloc extends Bloc<TraderMarketEvent, TraderMarketState> {
  final IFarmerRepository farmerRepository;
  final IProductRepository productRepository;

  TraderMarketBloc({
    required this.farmerRepository,
    required this.productRepository,
  }) : super(const MarketInitial()) {
    on<FetchMarketData>(_onFetchData);
  }

  Future<void> _onFetchData(
    FetchMarketData event,
    Emitter<TraderMarketState> emit,
  ) async {
    emit(const MarketLoading());

    final farmerResult = await farmerRepository.getFarmerCount();
    final productResult = await productRepository.getAllProducts();

    farmerResult.fold(
      (failure) => emit(MarketError(failure.message)),
      (count) {
        productResult.fold(
          (failure) => emit(MarketError(failure.message)),
          (products) => emit(MarketLoaded(
            farmerCount: count,
            products: products,
          )),
        );
      },
    );
  }
}
