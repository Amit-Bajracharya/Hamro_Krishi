import 'package:dartz/dartz.dart';
import 'package:hamrokrishi_app/app/features/trader/data/repositories/trader_product_repository_impl.dart';
import 'package:hamrokrishi_app/app/features/trader/domain/entities/trader_product_entity.dart';

class AddTraderProductUseCase {
  final ITraderProductRepository repository;

  AddTraderProductUseCase(this.repository);

  Future<Either<String, void>> execute(TraderProductEntity product) {
    return repository.addTraderProduct(product);
  }
}
