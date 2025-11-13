import 'dart:async';
import 'dart:ui';

class UIDebouncer {
  final int milliseconds;
  Timer? _timer;

  UIDebouncer({required this.milliseconds});

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  void dispose() {
    _timer?.cancel();
  }
}
