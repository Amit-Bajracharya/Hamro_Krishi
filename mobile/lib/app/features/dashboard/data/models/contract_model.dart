import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/contract_entity.dart';
import '../../../product/data/models/double_converter.dart';

part 'contract_model.freezed.dart';
part 'contract_model.g.dart';

@freezed
abstract class ContractModel with _$ContractModel {
  const ContractModel._();

  const factory ContractModel({
    String? id,
    @JsonKey(name: 'farmer_id') required String farmerId,
    @JsonKey(name: 'middleman_id') required String middlemanId,
    @JsonKey(name: 'product_id') required String productId,
    @DoubleConverter() required double quantity,
    @JsonKey(name: 'farmer_selling_price') @DoubleConverter() required double farmerSellingPrice,
    @JsonKey(name: 'trader_selling_price') @DoubleConverter() required double traderSellingPrice,
    @JsonKey(name: 'start_date') required DateTime startDate,
    @Default('active') String status,
    @JsonKey(name: 'trader_name') String? traderName,
    @JsonKey(name: 'farmer_name') String? farmerName,
    @JsonKey(name: 'product_name') String? productName,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
  }) = _ContractModel;

  factory ContractModel.fromJson(Map<String, dynamic> json) => _$ContractModelFromJson(json);

  factory ContractModel.fromEntity(ContractEntity entity) {
    return ContractModel(
      id: entity.id,
      farmerId: entity.farmerId,
      middlemanId: entity.middlemanId,
      productId: entity.productId,
      quantity: entity.quantity,
      farmerSellingPrice: entity.farmerSellingPrice,
      traderSellingPrice: entity.traderSellingPrice,
      startDate: entity.startDate,
      status: entity.status,
      traderName: entity.traderName,
      farmerName: entity.farmerName,
      productName: entity.productName,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  ContractEntity toEntity() {
    return ContractEntity(
      id: id,
      farmerId: farmerId,
      middlemanId: middlemanId,
      productId: productId,
      quantity: quantity,
      farmerSellingPrice: farmerSellingPrice,
      traderSellingPrice: traderSellingPrice,
      startDate: startDate,
      status: status,
      traderName: traderName,
      farmerName: farmerName,
      productName: productName,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
