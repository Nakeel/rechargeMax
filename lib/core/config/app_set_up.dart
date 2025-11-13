
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recharge_max/core/resolver/init_dependencies.dart';

class AppSetUp {
  static bool _isInitialized = false;
  
  Future init() async {
    // Skip initialization in debug mode if already initialized (hot reload)
    if (kDebugMode && _isInitialized) {
      return;
    }
    
    WidgetsFlutterBinding.ensureInitialized();

    await ScreenUtil.ensureScreenSize();
    
    // Only initialize dependencies once
    if (!_isInitialized) {
      initDependencies();
    }
    
    // Firebase initialization is safe to call multiple times
    // if (Platform.isIOS) {
    //   await Firebase.initializeApp(
    //     options: DefaultFirebaseOptions.currentPlatform,
    //   );
    // } else {
    //   await Firebase.initializeApp();
    // }

    // await FcmHelper.init();

    // final token = await FcmHelper.getToken();

    // FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);

    await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    
    _isInitialized = true;
  }

}
