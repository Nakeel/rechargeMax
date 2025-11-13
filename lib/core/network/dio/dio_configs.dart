const _kDefaultReceiveTimeout = 5000;
const _kDefaultConnectionTimeout = 5000;

class DioConfigs {
  final String baseUrl;
  final int receiveTimeout;
  final int connectionTimeout;
  final Map<String, dynamic> headers;

  const DioConfigs(
      {required this.baseUrl,
      this.receiveTimeout = _kDefaultReceiveTimeout,
      this.connectionTimeout = _kDefaultConnectionTimeout,
      this.headers = const {"Content-Type": "application/json"}});
}
