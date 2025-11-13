import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:audioplayers/audioplayers.dart';

typedef SpinResultCallback = void Function(int index, String label);

class SpinWheelWidget extends StatefulWidget {
  final List<String> items;
  final double size;
  final Duration spinDuration;
  final SpinResultCallback? onResult;
  final List<Color>? colors;
  final TextStyle? textStyle;
  final bool showCenterButton;
  final bool enableSounds;
  final bool enableConfetti;
  final SpinWheelController? controller;

  const SpinWheelWidget({
    super.key,
    required this.items,
    this.size = 300,
    this.spinDuration = const Duration(seconds: 4),
    this.onResult,
    this.colors,
    this.textStyle,
    this.showCenterButton = true,
    this.enableSounds = true,
    this.enableConfetti = true,
    this.controller,
  });

  @override
  State<SpinWheelWidget> createState() => _SpinWheelWidgetState();
}

class _SpinWheelWidgetState extends State<SpinWheelWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late ConfettiController _confettiController;
  final AudioPlayer _audioPlayer = AudioPlayer();

  double _currentAngle = 0;
  bool _spinning = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.spinDuration);
    _confettiController = ConfettiController(duration: const Duration(seconds: 2));
    _animation = Tween<double>(begin: 0, end: 0).animate(_controller);

    widget.controller?._state = this;

    _animation.addListener(() => setState(() {}));
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() => _spinning = false);
        // _currentAngle = targetAngle % (2 * math.pi);

        if (widget.enableConfetti) _confettiController.play();
        _playSound('sounds/win.wav');

        widget.onResult?.call(0, widget.items[0]);
      }
    });
  }

  Future<void> _playSound(String assetPath) async {
    if (!widget.enableSounds) return;
    try {
      await _audioPlayer.play(AssetSource(assetPath));
    } catch (_) {}
  }

  void _spin({int? fixedIndex}) {
    if (_spinning) return;
    setState(() => _spinning = true);

    _playSound('sounds/spin_start.wav');

    final random = math.Random();
    final randomTurns = random.nextInt(5) + 5; // 5–9 full rotations
    final segmentAngle = 2 * math.pi / widget.items.length;
    final selectedIndex =
        fixedIndex ?? random.nextInt(widget.items.length); // 👈 control point

    final targetAngle = randomTurns * 2 * math.pi +
        (widget.items.length - selectedIndex) * segmentAngle -
        segmentAngle / 2;

    _animation = Tween<double>(begin: _currentAngle, end: targetAngle)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward(from: 0);


  }

  /// 🎯 Spin to a specific index programmatically
  void spinTo(int index) {
    _spin(fixedIndex: index);
  }


  @override
  void dispose() {
    _controller.dispose();
    _confettiController.dispose();
    _audioPlayer.dispose();
    widget.controller?._state = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = widget.size;

    return Stack(
      alignment: Alignment.center,
      children: [
        Transform.rotate(
          angle: _animation.value ?? _currentAngle,
          child: CustomPaint(
            size: Size.square(size),
            painter: _WheelPainter(
              items: widget.items,
              colors: widget.colors ??
                  [Colors.orange, Colors.teal, Colors.purple, Colors.blue],
              textStyle: widget.textStyle ??
                  const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
            ),
          ),
        ),

        // Pointer indicator
        Positioned(
          top: (size / 2) - 10,
          child: const Icon(
            Icons.arrow_drop_down,
            size: 40,
            color: Colors.redAccent,
          ),
        ),

        // Confetti
        if (widget.enableConfetti)
          ConfettiWidget(
            confettiController: _confettiController,
            blastDirectionality: BlastDirectionality.explosive,
            emissionFrequency: 0.02,
            numberOfParticles: 30,
            maxBlastForce: 30,
            minBlastForce: 5,
            gravity: 0.1,
          ),

        // Center spin button
        if (widget.showCenterButton)
          GestureDetector(
            onTap: _spin,
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: _spinning ? Colors.grey : Colors.redAccent,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: const Text(
                'SPIN',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _WheelPainter extends CustomPainter {
  final List<String> items;
  final List<Color> colors;
  final TextStyle textStyle;

  _WheelPainter({
    required this.items,
    required this.colors,
    required this.textStyle,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..style = PaintingStyle.fill;
    final radius = size.width / 2;
    final rect = Rect.fromCircle(center: Offset(radius, radius), radius: radius);
    final sweep = 2 * math.pi / items.length;
    final textPainter = TextPainter(textAlign: TextAlign.center, textDirection: TextDirection.ltr);

    for (int i = 0; i < items.length; i++) {
      paint.color = colors[i % colors.length];
      final startAngle = i * sweep;
      canvas.drawArc(rect, startAngle, sweep, true, paint);

      // Draw item text
      final textSpan = TextSpan(text: items[i], style: textStyle);
      textPainter.text = textSpan;
      textPainter.layout();

      final angle = startAngle + sweep / 2;
      final textRadius = radius * 0.65;
      final offset = Offset(
        radius + textRadius * math.cos(angle) - textPainter.width / 2,
        radius + textRadius * math.sin(angle) - textPainter.height / 2,
      );

      canvas.save();
      canvas.translate(offset.dx + textPainter.width / 2, offset.dy + textPainter.height / 2);
      canvas.rotate(angle + math.pi / 2);
      canvas.translate(-textPainter.width / 2, -textPainter.height / 2);
      textPainter.paint(canvas, Offset.zero);
      canvas.restore();
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}


class SpinWheelController {
  _SpinWheelWidgetState? _state;

  /// Spin randomly
  void spin() => _state?._spin();

  /// Spin to a specific segment index
  void spinTo(int index) => _state?._spin(fixedIndex: index);

  /// Whether the wheel is currently spinning
  bool get isSpinning => _state?._spinning ?? false;
}
