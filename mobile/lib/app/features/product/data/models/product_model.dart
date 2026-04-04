import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hamrokrishi_app/app/features/product/domain/entities/product_entity.dart';

part 'product_model.freezed.dart';
part 'product_model.g.dart';

@freezed
abstract class ProductModel with _$ProductModel {
  const ProductModel._();
  @JsonSerializable(fieldRename: FieldRename.snake)
  const factory ProductModel({
    String? id,
    required String name,
    required String category,
    DateTime? harvestDate,
    required DateTime expiryDate,
    required double price,
    required double quantity,
    String? farmerId,
    required double latitude,
    required double longitude,
    String? imageUrl,
    DateTime? createdAt,
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
      createdAt: createdAt,
    );
  }
}
