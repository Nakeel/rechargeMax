
import 'package:recharge_max/core/abstractions/feature_resolver.dart';
import 'package:recharge_max/core/abstractions/router_module.dart';

import '../router/app_router.dart';

class BaseAppResolver implements FeatureResolver {

  @override
  RouterModule? get routerModule => BaseAppRouteModule();
}
