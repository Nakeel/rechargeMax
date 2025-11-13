import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';


class HiveManager {
  HiveManager._(); // Private constructor to prevent direct instantiation

  static Future<HiveManager> create() async {
    final instance = HiveManager._();
    await instance.init();
    return instance;
  }

  Future<void> init() async {
    await Hive.initFlutter();
    _registerAdapters();
    await _openBoxes();
  }

  void _registerAdapters() {
    // if (!Hive.isAdapterRegistered(0)) {
    //   Hive.registerAdapter(UserLoginDataUserAdapter());
    // }

  }

  Future<void> _openBoxes() async {
    // if (!Hive.isBoxOpen('userBox')) {
    //   await Hive.openBox<UserLoginDataUser>('userBox');
    // }
  }
}