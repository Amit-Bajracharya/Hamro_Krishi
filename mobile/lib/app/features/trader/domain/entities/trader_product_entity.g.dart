// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trader_product_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TraderProductEntity _$TraderProductEntityFromJson(Map<String, dynamic> json) =>
    _TraderProductEntity(
      id: json['id'] as String?,
      contractId: json['contract_id'] as String,
      quantityForSale: (json['quantity_for_sale'] as num).toDouble(),
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      status: json['status'] as String? ?? 'available',
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      productName: json['product_name'] as String?,
      price: (json['trader_selling_price'] as num?)?.toDouble(),
      category: json['category'] as String?,
      imageUrl: json['image_url'] as String?,
    );

Map<String, dynamic> _$TraderProductEntityToJson(
  _TraderProductEntity instance,
) => <String, dynamic>{
  'id': instance.id,
  'contract_id': instance.contractId,
  'quantity_for_sale': instance.quantityForSale,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'status': instance.status,
  'created_at': instance.createdAt?.toIso8601String(),
  'product_name': instance.productName,
  'trader_selling_price': instance.price,
  'category': instance.category,
  'image_url': instance.imageUrl,
};
