import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService<T> {
  final String boxName;

  HiveService(this.boxName);

  /// Initialize the box
  Future<void> init() async {
    await Hive.initFlutter();
    if (!Hive.isBoxOpen(boxName)) {
      await Hive.openBox<T>(boxName);
    }
  }

  /// Add data to the box
  Future<void> addData(String key, T value) async {
    final box = Hive.box<T>(boxName);
    await box.put(key, value);
  }

  /// Get data from the box
  T? getData(String key) {
    final box = Hive.box<T>(boxName);
    return box.get(key);
  }

  /// Update data if key exists
  Future<void> updateData(String key, T value) async {
    final box = Hive.box<T>(boxName);
    if (box.containsKey(key)) {
      await box.put(key, value);
    }
  }

  /// Delete data from the box
  Future<void> deleteData(String key) async {
    final box = Hive.box<T>(boxName);
    if (box.containsKey(key)) {
      await box.delete(key);
    }
  }

  /// Get all data from the box
  List<T> getAllData() {
    final box = Hive.box<T>(boxName);
    return box.values.toList();
  }

  /// Clear all data in the box
  Future<void> clearBox() async {
    final box = Hive.box<T>(boxName);
    await box.clear();
  }

  /// Check if a key exists
  bool exists(String key) {
    final box = Hive.box<T>(boxName);
    return box.containsKey(key);
  }

  /// Get data with filtering (Example: Filter by ID or other fields)
  List<T> filterData(bool Function(T) filter) {
    final box = Hive.box<T>(boxName);
    return box.values.where(filter).toList();
  }

  /// Get data with sorting
  List<T> sortData(Comparator<T> comparator) {
    final box = Hive.box<T>(boxName);
    var values = box.values.toList();
    values.sort(comparator);
    return values;
  }
}