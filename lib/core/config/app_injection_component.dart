
import 'package:get_it/get_it.dart';
import 'package:recharge_max/core/abstractions/injection_module.dart' show InjectionModule;
import 'package:recharge_max/core/resolver/init_dependencies.dart';


class AppInjectionComponent {
  static AppInjectionComponent instance = AppInjectionComponent._();
  AppInjectionComponent._();

  Future<GetIt> registerModules({
    required List<InjectionModule> modules,
  }) async {
    for (final mod in modules) {
      await mod.registerDepenencies(
        injector: serviceLocator,
      );
    }
    return serviceLocator;
  }
}
