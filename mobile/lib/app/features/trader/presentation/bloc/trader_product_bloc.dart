import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hamrokrishi_app/app/features/trader/domain/entities/trader_product_entity.dart';
import 'package:hamrokrishi_app/app/features/trader/domain/usecases/add_trader_product_use_case.dart';
import 'package:hamrokrishi_app/app/features/trader/domain/usecases/get_trader_products_use_case.dart';
import 'package:hamrokrishi_app/app/features/dashboard/domain/repositories/contract_repository.dart';
import 'package:hamrokrishi_app/app/features/dashboard/domain/entities/contract_entity.dart';

part 'trader_product_bloc.freezed.dart';

@freezed
class TraderProductEvent with _$TraderProductEvent {
  const factory TraderProductEvent.fetchTraderProducts({required String traderId}) = FetchTraderProducts;
  const factory TraderProductEvent.fetchTraderContracts({required String traderId}) = FetchTraderContracts;
  const factory TraderProductEvent.addTraderProduct({required TraderProductEntity product}) = AddTraderProduct;
}

@freezed
class TraderProductState with _$TraderProductState {
  const factory TraderProductState.initial() = TraderProductInitial;
  const factory TraderProductState.loading() = TraderProductLoading;
  const factory TraderProductState.loaded({
    required List<TraderProductEntity> products,
    @Default([]) List<ContractEntity> contracts,
  }) = TraderProductLoaded;
  const factory TraderProductState.success({required String message}) = TraderProductSuccess;
  const factory TraderProductState.failure({required String error}) = TraderProductFailure;
}

class TraderProductBloc extends Bloc<TraderProductEvent, TraderProductState> {
  final AddTraderProductUseCase addTraderProductUseCase;
  final GetTraderProductsUseCase getTraderProductsUseCase;
  final IContractRepository contractRepository;

  TraderProductBloc({
    required this.addTraderProductUseCase,
    required this.getTraderProductsUseCase,
    required this.contractRepository,
  }) : super(const TraderProductInitial()) {
    on<FetchTraderProducts>(_onFetchTraderProducts);
    on<FetchTraderContracts>(_onFetchTraderContracts);
    on<AddTraderProduct>(_onAddTraderProduct);
  }

  Future<void> _onFetchTraderProducts(
    FetchTraderProducts event,
    Emitter<TraderProductState> emit,
  ) async {
    emit(const TraderProductLoading());
    final result = await getTraderProductsUseCase.execute(event.traderId);
    result.fold(
      (error) => emit(TraderProductFailure(error: error)),
      (products) => emit(TraderProductLoaded(products: products)),
    );
  }

  Future<void> _onFetchTraderContracts(
    FetchTraderContracts event,
    Emitter<TraderProductState> emit,
  ) async {
    // Keep current products if already loaded
    final currentProducts = state.maybeWhen(
      loaded: (products, _) => products,
      orElse: () => <TraderProductEntity>[],
    );

    emit(const TraderProductLoading());
    final result = await contractRepository.getUserContracts(event.traderId, 'trader');
    result.fold(
      (failure) => emit(TraderProductFailure(error: failure.message)),
      (contracts) => emit(TraderProductLoaded(
        products: currentProducts,
        contracts: contracts.where((c) => c.status == 'active').toList(),
      )),
    );
  }

  Future<void> _onAddTraderProduct(
    AddTraderProduct event,
    Emitter<TraderProductState> emit,
  ) async {
    emit(const TraderProductLoading());
    final result = await addTraderProductUseCase.execute(event.product);
    result.fold(
      (error) => emit(TraderProductFailure(error: error)),
      (_) => emit(const TraderProductSuccess(message: 'Product listed successfully')),
    );
  }
}
