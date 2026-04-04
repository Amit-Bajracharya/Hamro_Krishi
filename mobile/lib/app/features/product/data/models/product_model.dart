import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hamrokrishi_app/app/features/product/domain/entities/product_entity.dart';
import 'package:hamrokrishi_app/app/features/product/data/models/double_converter.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
abstract class ProductModel with _$ProductModel {
  const ProductModel._();

  const factory ProductModel({
    String? id,
    required String name,
    required String category,
    @JsonKey(name: 'harvest_date') DateTime? harvestDate,
    @JsonKey(name: 'expiry_date') required DateTime expiryDate,
    @DoubleConverter() required double price,
    @DoubleConverter() required double quantity,
    @JsonKey(name: 'farmer_id') String? farmerId,
    @DoubleConverter() required double latitude,
    @DoubleConverter() required double longitude,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'farmer_name') String? farmerName,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _ProductModel;

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);

  factory ProductModel.fromEntity(ProductEntity entity) {
    return ProductModel(
      id: entity.id,
      name: entity.name,
      category: entity.category,
      harvestDate: entity.harvestDate,
      expiryDate: entity.expiryDate,
      price: entity.price,
      quantity: entity.quantity,
      farmerId: entity.farmerId,
      latitude: entity.latitude,
      longitude: entity.longitude,
      imageUrl: entity.imageUrl,
      farmerName: entity.farmerName,
      createdAt: entity.createdAt,
    );
  }

  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      name: name,
      category: category,
      harvestDate: harvestDate,
      expiryDate: expiryDate,
      price: price,
      quantity: quantity,
      farmerId: farmerId,
      latitude: latitude,
      longitude: longitude,
      imageUrl: imageUrl,
      farmerName: farmerName,
      createdAt: createdAt,
    );
  }
}
