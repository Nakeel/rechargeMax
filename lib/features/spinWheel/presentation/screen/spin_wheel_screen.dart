import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:recharge_max/features/spinWheel/presentation/screen/custom_spin_the_wheel_widget.dart';

class SpinTheWheelScreen extends StatefulWidget {
  const SpinTheWheelScreen({super.key});

  @override
  State<SpinTheWheelScreen> createState() => _SpinTheWheelScreenState();
}

class _SpinTheWheelScreenState extends State<SpinTheWheelScreen> {
  StreamController<int> controller = StreamController<int>();
  final items = ['💰 100', '🎁 Gift', '❌ Try Again', '💎 500', '🎉 Jackpot!'];
  final wheelController = SpinWheelController();

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }

  void _spin() {
    // Pick random index
    // final randomIndex = Fortune.randomInt(0, items.length);
    // controller.add(randomIndex);

    wheelController.spinTo(4);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      appBar: AppBar(title: const Text('Spin the Wheel')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SizedBox(
          //   height: 300,
          //   child: FortuneWheel(
          //     selected: controller.stream,
          //     indicators: const <FortuneIndicator>[
          //       FortuneIndicator(
          //         alignment: Alignment.topCenter,
          //         child: TriangleIndicator(
          //           color: Colors.redAccent,
          //         ),
          //       ),
          //     ],
          //     items: [
          //       for (var item in items)
          //         FortuneItem(
          //           child: Text(
          //             item,
          //             style: const TextStyle(fontWeight: FontWeight.bold),
          //           ),
          //         ),
          //     ],
          //     onAnimationEnd: () {
          //       // Called when wheel stops spinning
          //       final selected = controller.stream;
          //       // optional logic can go here
          //     },
          //   ),
          // ),

          Center(
            child: SpinWheelWidget(
              controller: wheelController,
              items: ['💰 100', '🎁 Gift', '❌ Try Again', '💎 500', '🎉 Jackpot!'],
              colors: [Colors.orange, Colors.green, Colors.blue, Colors.pink],
              showCenterButton: false,
              onResult: (index, label) {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('Result'),
                    content: Text('You got: $label'),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: _spin,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
            ),
            child: const Text('SPIN'),
          ),
        ],
      ),
    );
  }
}
