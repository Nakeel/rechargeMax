
import 'package:dartz/dartz.dart';
import 'package:recharge_max/core/error/failure.dart';

abstract interface class GeneralUsecase<T, Params> {
  Future<Either<Failure, T>> call(Params params);
}

// For usecase that need no params
class NoParams {}