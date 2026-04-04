import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hamrokrishi_app/app/features/product/data/models/double_converter.dart';
import 'package:hamrokrishi_app/app/features/trader/domain/entities/trader_product_entity.dart';

part 'trader_product_model.freezed.dart';
part 'trader_product_model.g.dart';

@freezed
abstract class TraderProductModel with _$TraderProductModel {
  const TraderProductModel._();

  const factory TraderProductModel({
    String? id,
    @JsonKey(name: 'contract_id') required String contractId,
    @DoubleConverter() @JsonKey(name: 'quantity_for_sale') required double quantityForSale,
    @DoubleConverter() required double latitude,
    @DoubleConverter() required double longitude,
    @Default('available') String status,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    // Joined fields from Contract and Product
    @JsonKey(name: 'product_name') String? productName,
    @DoubleConverter() @JsonKey(name: 'trader_selling_price') double? price,
    @JsonKey(name: 'category') String? category,
    @JsonKey(name: 'image_url') String? imageUrl,
  }) = _TraderProductModel;

  factory TraderProductModel.fromJson(Map<String, dynamic> json) =>
      _$TraderProductModelFromJson(json);

  factory TraderProductModel.fromEntity(TraderProductEntity entity) {
    return TraderProductModel(
      id: entity.id,
      contractId: entity.contractId,
      quantityForSale: entity.quantityForSale,
      latitude: entity.latitude,
      longitude: entity.longitude,
      status: entity.status,
      createdAt: entity.createdAt,
      productName: entity.productName,
      price: entity.price,
      category: entity.category,
      imageUrl: entity.imageUrl,
    );
  }

  TraderProductEntity toEntity() {
    return TraderProductEntity(
      id: id,
      contractId: contractId,
      quantityForSale: quantityForSale,
      latitude: latitude,
      longitude: longitude,
      status: status,
      createdAt: createdAt,
      productName: productName,
      price: price,
      category: category,
      imageUrl: imageUrl,
    );
  }
}
