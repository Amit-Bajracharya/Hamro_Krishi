// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_item_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MarketItemEntity _$MarketItemEntityFromJson(Map<String, dynamic> json) =>
    _MarketItemEntity(
      contractId: json['contract_id'] as String,
      productId: json['product_id'] as String?,
      farmerId: json['farmer_id'] as String?,
      middlemanId: json['middleman_id'] as String?,
      productName: json['product_name'] as String,
      category: json['category'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      farmerSellingPrice: (json['farmer_selling_price'] as num).toDouble(),
      traderSellingPrice: (json['trader_selling_price'] as num).toDouble(),
      status: json['status'] as String,
      farmerName: json['farmer_name'] as String,
      traderName: json['trader_name'] as String,
      imageUrl: json['image_url'] as String?,
      expiryDate: json['expiry_date'] == null
          ? null
          : DateTime.parse(json['expiry_date'] as String),
      farmerLatitude: (json['farmer_latitude'] as num?)?.toDouble(),
      farmerLongitude: (json['farmer_longitude'] as num?)?.toDouble(),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$MarketItemEntityToJson(_MarketItemEntity instance) =>
    <String, dynamic>{
      'contract_id': instance.contractId,
      'product_id': instance.productId,
      'farmer_id': instance.farmerId,
      'middleman_id': instance.middlemanId,
      'product_name': instance.productName,
      'category': instance.category,
      'quantity': instance.quantity,
      'farmer_selling_price': instance.farmerSellingPrice,
      'trader_selling_price': instance.traderSellingPrice,
      'status': instance.status,
      'farmer_name': instance.farmerName,
      'trader_name': instance.traderName,
      'image_url': instance.imageUrl,
      'expiry_date': instance.expiryDate?.toIso8601String(),
      'farmer_latitude': instance.farmerLatitude,
      'farmer_longitude': instance.farmerLongitude,
      'created_at': instance.createdAt?.toIso8601String(),
    };
