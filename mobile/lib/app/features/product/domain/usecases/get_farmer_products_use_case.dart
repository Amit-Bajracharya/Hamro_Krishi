import 'package:dartz/dartz.dart';
import 'package:hamrokrishi_app/app/core/error/failures.dart';
import 'package:hamrokrishi_app/app/features/product/domain/entities/product_entity.dart';
import 'package:hamrokrishi_app/app/features/product/domain/repositories/product_repository.dart';

class GetFarmerProductsUseCase {
  final IProductRepository repository;

  GetFarmerProductsUseCase(this.repository);

  Future<Either<Failure, List<ProductEntity>>> call(String farmerId) async {
    return await repository.getFarmerProducts(farmerId);
  }
}
