import 'injection_module.dart';
import 'router_module.dart';

///Resolves dependencies and routers.
///Dependencies such as [Injector] and [Router] are resolved here.
abstract class FeatureResolver {
  // InjectionModule? get injectionModule;
  RouterModule? get routerModule;
}
