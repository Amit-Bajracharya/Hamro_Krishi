import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hamrokrishi_app/app/features/product/domain/entities/product_entity.dart';
import 'package:hamrokrishi_app/app/features/product/domain/usecases/add_product_use_case.dart';
import 'package:hamrokrishi_app/app/features/product/domain/usecases/get_farmer_products_use_case.dart';
import 'package:image_picker/image_picker.dart';


part 'product_event.dart';
part 'product_state.dart';
part 'product_bloc.freezed.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final AddProductUseCase addProductUseCase;
  final GetFarmerProductsUseCase getFarmerProductsUseCase;
  final ImagePicker _picker = ImagePicker();

  ProductBloc({
    required this.addProductUseCase,
    required this.getFarmerProductsUseCase,
  }) : super(const ProductState.initial()) {
    on<PickImageEvent>(_onPickImage);
    on<SubmitHarvestEvent>(_onSubmitHarvest);
    on<FetchFarmerProductsEvent>(_onFetchFarmerProducts);
  }

  Future<void> _onPickImage(PickImageEvent event, Emitter<ProductState> emit) async {
    final XFile? image = await _picker.pickImage(source: event.source);
    if (image != null) {
      emit(state.maybeMap(
        initial: (s) => s.copyWith(imageFile: File(image.path)),
        success: (s) => s.copyWith(imageFile: File(image.path)),
        failure: (s) => ProductState.initial(imageFile: File(image.path)),
        orElse: () => state,
      ));
    }
  }

  Future<void> _onSubmitHarvest(SubmitHarvestEvent event, Emitter<ProductState> emit) async {
    final currentFile = state.maybeMap(
      initial: (s) => s.imageFile,
      success: (s) => s.imageFile,
      orElse: () => null,
    );

    emit(const ProductState.loading());

    final result = await addProductUseCase(event.product, currentFile);

    result.fold(
      (failure) => emit(ProductState.failure(error: failure.toString())),
      (_) => emit(const ProductState.success(message: 'Product listed successfully!')),
    );
  }

  Future<void> _onFetchFarmerProducts(FetchFarmerProductsEvent event, Emitter<ProductState> emit) async {
    emit(const ProductState.loading());
    final result = await getFarmerProductsUseCase(event.farmerId);
    result.fold(
      (failure) => emit(ProductState.failure(error: failure.toString())),
      (products) => emit(ProductState.loaded(products: products)),
    );
  }
}
