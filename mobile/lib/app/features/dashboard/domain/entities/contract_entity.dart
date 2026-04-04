import 'package:freezed_annotation/freezed_annotation.dart';

part 'contract_entity.freezed.dart';
part 'contract_entity.g.dart';

@freezed
abstract class ContractEntity with _$ContractEntity {
  const factory ContractEntity({
    String? id,
    @JsonKey(name: 'farmer_id') required String farmerId,
    @JsonKey(name: 'middleman_id') required String middlemanId,
    @JsonKey(name: 'product_id') required String productId,
    required double quantity,
    @JsonKey(name: 'farmer_selling_price') required double farmerSellingPrice,
    @JsonKey(name: 'trader_selling_price') required double traderSellingPrice,
    @JsonKey(name: 'start_date') required DateTime startDate,
    @Default('active') String status,
    @JsonKey(name: 'trader_name') String? traderName,
    @JsonKey(name: 'farmer_name') String? farmerName,
    @JsonKey(name: 'product_name') String? productName,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _ContractEntity;

  factory ContractEntity.fromJson(Map<String, dynamic> json) => _$ContractEntityFromJson(json);
}
