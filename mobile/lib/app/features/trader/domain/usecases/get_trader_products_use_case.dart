import 'package:dartz/dartz.dart';
import 'package:hamrokrishi_app/app/features/trader/data/repositories/trader_product_repository_impl.dart';
import 'package:hamrokrishi_app/app/features/trader/domain/entities/trader_product_entity.dart';

class GetTraderProductsUseCase {
  final ITraderProductRepository repository;

  GetTraderProductsUseCase(this.repository);

  Future<Either<String, List<TraderProductEntity>>> execute(String traderId) {
    return repository.getTraderProducts(traderId);
  }
}
