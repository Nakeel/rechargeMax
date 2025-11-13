import 'dart:developer';

class Failure {
  final String error;

  Failure(this.error) {
    log(error, name: 'Failure Class');
  }

  @override
  String toString() {
    return error;
  }
}
