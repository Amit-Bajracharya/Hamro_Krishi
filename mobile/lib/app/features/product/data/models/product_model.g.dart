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
      price: const DoubleConverter().fromJson(json['price']),
      quantity: const DoubleConverter().fromJson(json['quantity']),
      farmerId: json['farmer_id'] as String?,
      latitude: const DoubleConverter().fromJson(json['latitude']),
      longitude: const DoubleConverter().fromJson(json['longitude']),
      imageUrl: json['image_url'] as String?,
      farmerName: json['farmer_name'] as String?,
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
      'price': const DoubleConverter().toJson(instance.price),
      'quantity': const DoubleConverter().toJson(instance.quantity),
      'farmer_id': instance.farmerId,
      'latitude': const DoubleConverter().toJson(instance.latitude),
      'longitude': const DoubleConverter().toJson(instance.longitude),
      'image_url': instance.imageUrl,
      'farmer_name': instance.farmerName,
      'created_at': instance.createdAt?.toIso8601String(),
    };
