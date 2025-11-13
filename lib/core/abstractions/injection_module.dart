import 'dart:async';

import 'package:get_it/get_it.dart';

abstract class InjectionModule {
  FutureOr<void> registerDepenencies({required GetIt injector});
}
