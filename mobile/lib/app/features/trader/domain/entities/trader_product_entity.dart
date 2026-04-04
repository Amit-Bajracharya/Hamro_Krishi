import 'package:freezed_annotation/freezed_annotation.dart';

part 'trader_product_entity.freezed.dart';
part 'trader_product_entity.g.dart';

@freezed
abstract class TraderProductEntity with _$TraderProductEntity {
  const factory TraderProductEntity({
    String? id,
    @JsonKey(name: 'contract_id') required String contractId,
    @JsonKey(name: 'quantity_for_sale') required double quantityForSale,
    required double latitude,
    required double longitude,
    @Default('available') String status,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    // Joined fields for UI
    @JsonKey(name: 'product_name') String? productName,
    @JsonKey(name: 'trader_selling_price') double? price,
    @JsonKey(name: 'category') String? category,
    @JsonKey(name: 'image_url') String? imageUrl,
  }) = _TraderProductEntity;

  factory TraderProductEntity.fromJson(Map<String, dynamic> json) =>
      _$TraderProductEntityFromJson(json);
}
