import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:hamrokrishi_app/app/core/error/failures.dart';
import 'package:hamrokrishi_app/app/features/product/domain/entities/product_entity.dart';
import 'package:hamrokrishi_app/app/features/product/domain/repositories/product_repository.dart';

class AddProductUseCase {
  final IProductRepository repository;

  AddProductUseCase(this.repository);

  Future<Either<Failure, void>> call(ProductEntity product, File? imageFile) {
    return repository.addProduct(product, imageFile);
  }
}
