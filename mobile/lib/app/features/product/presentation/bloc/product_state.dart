part of 'product_bloc.dart';

@freezed
class ProductState with _$ProductState {
  const factory ProductState.initial({File? imageFile}) = Initial;
  const factory ProductState.loading() = Loading;
  const factory ProductState.success({required String message, File? imageFile}) = Success;
  const factory ProductState.loaded({required List<ProductEntity> products}) = Loaded;
  const factory ProductState.failure({required String error}) = Failure;
}
