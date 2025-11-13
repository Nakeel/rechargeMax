import 'package:flutter/foundation.dart';
import 'package:recharge_max/core/abstractions/build_config.dart';

class Env {
  static final BuildConfig _dev = BuildConfig(
    baseUrl: 'https://apidev.yalo.ng',
    appName: 'Staging App',
          paystackKey: "pk_test_425d35f27736e0393f1400aefb846a5bf2e97c33",
          mapApiKey:
          "AIzaSyA4GNV35z-n1OoX9tIUuQFhutA-7hh6ODE"
          // "AIzaSyDaUyV6ABxrRnL6Ljw9-f3KKY43_ksKNyY",

  );
  static final BuildConfig _prod = BuildConfig(
    baseUrl: 'https://api.yalo.ng',
    appName: 'Production App',
    paystackKey: "pk_live_10567b8e24a6b1c9e62f1548b0371fbe7bac61f8",
      mapApiKey:
      "AIzaSyA4GNV35z-n1OoX9tIUuQFhutA-7hh6ODE"
    // "AIzaSyDaUyV6ABxrRnL6Ljw9-f3KKY43_ksKNyY",

  );

  static final BuildConfig _qa = BuildConfig(
      baseUrl: 'https://apiqa.yalo.ng',
      appName: 'QA App',
      paystackKey: "pk_test_425d35f27736e0393f1400aefb846a5bf2e97c33",
      mapApiKey:
      "AIzaSyA4GNV35z-n1OoX9tIUuQFhutA-7hh6ODE"
    // "AIzaSyDaUyV6ABxrRnL6Ljw9-f3KKY43_ksKNyY",

  );

  static BuildConfig get getConfig => kReleaseMode ? _dev : _dev;
}
