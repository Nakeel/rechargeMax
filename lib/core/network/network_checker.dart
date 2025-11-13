// import 'dart:async';
// import 'dart:io';
// import 'package:connectivity_plus/connectivity_plus.dart';
//
// class InternetChecker {
//   final StreamController<bool> _controller = StreamController<bool>.broadcast();
//   Stream<bool> get onStatusChange => _controller.stream;
//
//   bool _hasInternet = false;
//   Timer? _timer;
//   late StreamSubscription _connectivitySubscription;
//
//   bool get hasInternet => _hasInternet;
//
//   InternetChecker() {
//     Future.sync(() => _checkInternet());
//     _startMonitoring();
//   }
//
//   void _startMonitoring() {
//     _connectivitySubscription = Connectivity()
//         .onConnectivityChanged
//         .map((results) => results.contains(ConnectivityResult.wifi) || results.contains(ConnectivityResult.mobile))
//         .listen((isConnected) {
//       if (isConnected) {
//         _checkInternet();
//       } else {
//         if (_hasInternet) {
//           _hasInternet = false;
//           _controller.add(false);
//         }
//       }
//     });
//
//     _timer = Timer.periodic(Duration(seconds: 30), (timer) {
//       _checkInternet();
//     });
//   }
//
//   Future<void> _checkInternet() async {
//     bool networkAvailable = await _isNetworkAvailable();
//
//     if (!networkAvailable) {
//       if (_hasInternet) {
//         _hasInternet = false;
//         _controller.add(false);
//       }
//       return;
//     }
//
//     bool internetAccessible = await _canAccessInternet();
//
//     if (_hasInternet != internetAccessible) {
//       _hasInternet = internetAccessible;
//       _controller.add(_hasInternet);
//     }
//   }
//
//   Future<bool> _isNetworkAvailable() async {
//     var connectivityResult = await Connectivity().checkConnectivity();
//     return connectivityResult != ConnectivityResult.none;
//   }
//
//   Future<bool> _canAccessInternet() async {
//     try {
//       final result = await InternetAddress.lookup('google.com');
//       return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
//     } catch (e) {
//       print('Internet check failed: $e');
//       return false;
//     }
//   }
//
//   void dispose() {
//     _controller.close();
//     _timer?.cancel();
//     _connectivitySubscription.cancel();
//   }
// }