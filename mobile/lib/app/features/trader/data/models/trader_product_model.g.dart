// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trader_product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TraderProductModel _$TraderProductModelFromJson(Map<String, dynamic> json) =>
    _TraderProductModel(
      id: json['id'] as String?,
      contractId: json['contract_id'] as String,
      quantityForSale: const DoubleConverter().fromJson(
        json['quantity_for_sale'],
      ),
      latitude: const DoubleConverter().fromJson(json['latitude']),
      longitude: const DoubleConverter().fromJson(json['longitude']),
      status: json['status'] as String? ?? 'available',
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      productName: json['product_name'] as String?,
      price: const DoubleConverter().fromJson(json['trader_selling_price']),
      category: json['category'] as String?,
      imageUrl: json['image_url'] as String?,
    );

Map<String, dynamic> _$TraderProductModelToJson(
  _TraderProductModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'contract_id': instance.contractId,
  'quantity_for_sale': const DoubleConverter().toJson(instance.quantityForSale),
  'latitude': const DoubleConverter().toJson(instance.latitude),
  'longitude': const DoubleConverter().toJson(instance.longitude),
  'status': instance.status,
  'created_at': instance.createdAt?.toIso8601String(),
  'product_name': instance.productName,
  'trader_selling_price': _$JsonConverterToJson<dynamic, double>(
    instance.price,
    const DoubleConverter().toJson,
  ),
  'category': instance.category,
  'image_url': instance.imageUrl,
};

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) => value == null ? null : toJson(value);
