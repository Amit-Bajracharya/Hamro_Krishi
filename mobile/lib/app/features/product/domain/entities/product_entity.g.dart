// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProductEntity _$ProductEntityFromJson(Map<String, dynamic> json) =>
    _ProductEntity(
      id: json['id'] as String?,
      name: json['name'] as String,
      category: json['category'] as String,
      harvestDate: json['harvestDate'] == null
          ? null
          : DateTime.parse(json['harvestDate'] as String),
      expiryDate: DateTime.parse(json['expiryDate'] as String),
      price: (json['price'] as num).toDouble(),
      quantity: (json['quantity'] as num).toDouble(),
      farmerId: json['farmerId'] as String?,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String?,
      farmerName: json['farmerName'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
    );

Map<String, dynamic> _$ProductEntityToJson(_ProductEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'category': instance.category,
      'harvestDate': instance.harvestDate?.toIso8601String(),
      'expiryDate': instance.expiryDate.toIso8601String(),
      'price': instance.price,
      'quantity': instance.quantity,
      'farmerId': instance.farmerId,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'imageUrl': instance.imageUrl,
      'farmerName': instance.farmerName,
      'createdAt': instance.createdAt?.toIso8601String(),
    };
