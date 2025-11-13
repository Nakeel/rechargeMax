import 'package:flutter/material.dart';
import 'package:recharge_max/core/config/app_start.dart';
import 'package:recharge_max/core/network/env.dart';
import 'package:recharge_max/features/spinWheel/presentation/screen/spin_wheel_screen.dart';

void main() {
  InitializeApp().startApp();
}

class InitializeApp extends AppStart {
  InitializeApp() : super(Env.getConfig);
}

