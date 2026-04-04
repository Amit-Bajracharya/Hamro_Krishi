import 'package:dartz/dartz.dart';
import 'package:hamrokrishi_app/app/core/error/failures.dart';

abstract class IFarmerRepository {
  Future<Either<Failure, int>> getFarmerCount();
}
