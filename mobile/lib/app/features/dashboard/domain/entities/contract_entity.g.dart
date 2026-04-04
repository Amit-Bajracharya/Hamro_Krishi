// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contract_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ContractEntity _$ContractEntityFromJson(Map<String, dynamic> json) =>
    _ContractEntity(
      id: json['id'] as String?,
      farmerId: json['farmer_id'] as String,
      middlemanId: json['middleman_id'] as String,
      productId: json['product_id'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      farmerSellingPrice: (json['farmer_selling_price'] as num).toDouble(),
      traderSellingPrice: (json['trader_selling_price'] as num).toDouble(),
      startDate: DateTime.parse(json['start_date'] as String),
      status: json['status'] as String? ?? 'active',
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
    );

Map<String, dynamic> _$ContractEntityToJson(_ContractEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'farmer_id': instance.farmerId,
      'middleman_id': instance.middlemanId,
      'product_id': instance.productId,
      'quantity': instance.quantity,
      'farmer_selling_price': instance.farmerSellingPrice,
      'trader_selling_price': instance.traderSellingPrice,
      'start_date': instance.startDate.toIso8601String(),
      'status': instance.status,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
    };
