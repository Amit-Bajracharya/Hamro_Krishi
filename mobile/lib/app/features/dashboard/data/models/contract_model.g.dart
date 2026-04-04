// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ContractModel _$ContractModelFromJson(Map<String, dynamic> json) =>
    _ContractModel(
      id: json['id'] as String?,
      farmerId: json['farmer_id'] as String,
      middlemanId: json['middleman_id'] as String,
      productId: json['product_id'] as String,
      quantity: const DoubleConverter().fromJson(json['quantity']),
      farmerSellingPrice: const DoubleConverter().fromJson(
        json['farmer_selling_price'],
      ),
      traderSellingPrice: const DoubleConverter().fromJson(
        json['trader_selling_price'],
      ),
      startDate: DateTime.parse(json['start_date'] as String),
      status: json['status'] as String? ?? 'active',
      traderName: json['trader_name'] as String?,
      farmerName: json['farmer_name'] as String?,
      productName: json['product_name'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$ContractModelToJson(_ContractModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'farmer_id': instance.farmerId,
      'middleman_id': instance.middlemanId,
      'product_id': instance.productId,
      'quantity': const DoubleConverter().toJson(instance.quantity),
      'farmer_selling_price': const DoubleConverter().toJson(
        instance.farmerSellingPrice,
      ),
      'trader_selling_price': const DoubleConverter().toJson(
        instance.traderSellingPrice,
      ),
      'start_date': instance.startDate.toIso8601String(),
      'status': instance.status,
      'trader_name': instance.traderName,
      'farmer_name': instance.farmerName,
      'product_name': instance.productName,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
