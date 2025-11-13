import 'package:dartz/dartz.dart';
import 'package:recharge_max/core/error/failure.dart';


/// A generic handler that enables cancellation-aware execution of async use cases.
class CancelableStreamHandler<T> {
  final Future<Either<Failure, T>> Function() _callback;
  bool _isCanceled = false;

  CancelableStreamHandler(this._callback);

  Future<Either<Failure, T>> execute() async {
    if (_isCanceled) {
      return left(Failure( "Request was cancelled"));
    }

    final result = await _callback();
    if (_isCanceled) {
      return left(Failure( "Request was cancelled"));
    }

    return result;
  }

  void cancel() {
    _isCanceled = true;
  }

  void dispose() {
    cancel();
  }
}
