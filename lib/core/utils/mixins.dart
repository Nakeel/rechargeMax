import 'package:flutter/material.dart';

import 'app_logger.dart';

mixin RequestIdMixin {
  final Map<String, String> _requestIds = {};

  /// Call this at the start of an event to create and register a new requestId
  String registerRequest(String key) {
    final requestId = UniqueKey().toString();
    _requestIds[key] = requestId;
    return requestId;
  }

  /// Check if the current requestId is still valid
  bool isRequestActive(String key, String requestId) {
    AppLogger.info('===================================');
    AppLogger.info('isRequestActive ${_requestIds[key]} $requestId');
    return _requestIds[key] == requestId;
  }
}