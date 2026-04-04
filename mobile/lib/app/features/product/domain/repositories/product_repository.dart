import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:hamrokrishi_app/app/core/error/failures.dart';
import 'package:hamrokrishi_app/app/features/product/domain/entities/product_entity.dart';

abstract class IProductRepository {
  Future<Either<Failure, void>> addProduct(ProductEntity product, File? imageFile);
  Future<Either<Failure, List<ProductEntity>>> getFarmerProducts(String farmerId);
  Future<Either<Failure, List<ProductEntity>>> getAllProducts();
}
