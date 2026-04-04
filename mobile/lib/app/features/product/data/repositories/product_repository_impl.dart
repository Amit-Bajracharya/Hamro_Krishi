import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:hamrokrishi_app/app/core/error/failures.dart';
import 'package:hamrokrishi_app/app/features/product/data/datasources/product_remote_data_source.dart';
import 'package:hamrokrishi_app/app/features/product/data/models/product_model.dart';
import 'package:hamrokrishi_app/app/features/product/domain/entities/product_entity.dart';
import 'package:hamrokrishi_app/app/features/product/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements IProductRepository {
  final IProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, void>> addProduct(ProductEntity product, File? imageFile) async {
    try {
      String? imageUrl;
      if (imageFile != null) {
        imageUrl = await remoteDataSource.uploadImage(imageFile);
      }

      final productModel = ProductModel.fromEntity(product).copyWith(imageUrl: imageUrl);
      await remoteDataSource.addProduct(productModel);

      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getFarmerProducts(String farmerId) async {
    try {
      final models = await remoteDataSource.getFarmerProducts(farmerId);
      final entities = models.map((model) => model.toEntity()).toList();

      return Right(entities);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
