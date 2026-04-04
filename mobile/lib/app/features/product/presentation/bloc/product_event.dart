part of 'product_bloc.dart';

@freezed
class ProductEvent with _$ProductEvent {
  const factory ProductEvent.pickImage({required ImageSource source}) = PickImageEvent;
  const factory ProductEvent.submitHarvest({required ProductEntity product}) = SubmitHarvestEvent;
}
