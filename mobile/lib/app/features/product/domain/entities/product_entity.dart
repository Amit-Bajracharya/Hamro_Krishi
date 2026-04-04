import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_entity.freezed.dart';
part 'product_entity.g.dart';

@freezed
abstract class ProductEntity with _$ProductEntity {
  const factory ProductEntity({
    String? id,
    required String name,
    required String category,
    DateTime? harvestDate,
    required DateTime expiryDate,
    required double price,
    required double quantity,
    String? farmerId,
    required double latitude,
    required double longitude,
    String? imageUrl,
    DateTime? createdAt,
  }) = _ProductEntity;

  factory ProductEntity.fromJson(Map<String, dynamic> json) => _$ProductEntityFromJson(json);
}
