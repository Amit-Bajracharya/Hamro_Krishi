// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProductModel _$ProductModelFromJson(Map<String, dynamic> json) =>
    _ProductModel(
      id: json['id'] as String?,
      name: json['name'] as String,
      category: json['category'] as String,
      harvestDate: json['harvest_date'] == null
          ? null
          : DateTime.parse(json['harvest_date'] as String),
      expiryDate: DateTime.parse(json['expiry_date'] as String),
      price: (json['price'] as num).toDouble(),
      quantity: (json['quantity'] as num).toDouble(),
      farmerId: json['farmer_id'] as String?,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      imageUrl: json['image_url'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$ProductModelToJson(_ProductModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': instance.category,
      'harvest_date': instance.harvestDate?.toIso8601String(),
      'expiry_date': instance.expiryDate.toIso8601String(),
      'price': instance.price,
      'quantity': instance.quantity,
      'farmer_id': instance.farmerId,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'image_url': instance.imageUrl,
      'created_at': instance.createdAt?.toIso8601String(),
    };
