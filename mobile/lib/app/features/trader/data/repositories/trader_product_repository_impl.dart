import 'package:dartz/dartz.dart';
import 'package:hamrokrishi_app/app/features/trader/data/datasources/trader_product_remote_data_source.dart';
import 'package:hamrokrishi_app/app/features/trader/data/models/trader_product_model.dart';
import 'package:hamrokrishi_app/app/features/trader/domain/entities/trader_product_entity.dart';

abstract class ITraderProductRepository {
  Future<Either<String, void>> addTraderProduct(TraderProductEntity product);
  Future<Either<String, List<TraderProductEntity>>> getTraderProducts(String traderId);
  Future<Either<String, TraderProductEntity>> getTraderProductDetail(String id);
  Future<Either<String, void>> updateStatus(String id, String status);
}

class TraderProductRepositoryImpl implements ITraderProductRepository {
  final ITraderProductRemoteDataSource remoteDataSource;

  TraderProductRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<String, void>> addTraderProduct(TraderProductEntity product) async {
    try {
      await remoteDataSource.addTraderProduct(TraderProductModel.fromEntity(product));
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, List<TraderProductEntity>>> getTraderProducts(String traderId) async {
    try {
      final models = await remoteDataSource.getTraderProducts(traderId);
      return Right(models.map((m) => m.toEntity()).toList());
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, TraderProductEntity>> getTraderProductDetail(String id) async {
    try {
      final model = await remoteDataSource.getTraderProductDetail(id);
      return Right(model.toEntity());
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> updateStatus(String id, String status) async {
    try {
      await remoteDataSource.updateStatus(id, status);
      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
