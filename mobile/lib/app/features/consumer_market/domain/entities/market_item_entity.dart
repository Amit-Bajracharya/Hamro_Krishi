import 'package:freezed_annotation/freezed_annotation.dart';

part 'market_item_entity.freezed.dart';
part 'market_item_entity.g.dart';

@freezed
abstract class MarketItemEntity with _$MarketItemEntity {
  const factory MarketItemEntity({
    @JsonKey(name: 'contract_id') required String contractId,
    @JsonKey(name: 'product_id') String? productId,
    @JsonKey(name: 'farmer_id') String? farmerId,
    @JsonKey(name: 'middleman_id') String? middlemanId,
    @JsonKey(name: 'product_name') required String productName,
    required String category,
    required double quantity,
    @JsonKey(name: 'farmer_selling_price') required double farmerSellingPrice,
    @JsonKey(name: 'trader_selling_price') required double traderSellingPrice,
    required String status,
    @JsonKey(name: 'farmer_name') required String farmerName,
    @JsonKey(name: 'trader_name') required String traderName,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'expiry_date') DateTime? expiryDate,
    @JsonKey(name: 'farmer_latitude') double? farmerLatitude,
    @JsonKey(name: 'farmer_longitude') double? farmerLongitude,
    @JsonKey(name: 'created_at') DateTime? createdAt,
  }) = _MarketItemEntity;

  factory MarketItemEntity.fromJson(Map<String, dynamic> json) => _$MarketItemEntityFromJson(json);
}
