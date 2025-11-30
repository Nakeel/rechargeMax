import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NumericKeypad extends StatelessWidget {
  final VoidCallback onDecimal;
  final VoidCallback onBackspace;
  final Function(String) onNumberPressed;

  const NumericKeypad({
    Key? key,
    required this.onDecimal,
    required this.onBackspace,
    required this.onNumberPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 45.w, ),
      child: GridView.count(
        crossAxisCount: 3,
        crossAxisSpacing: 75.w,
        mainAxisSpacing: 15.h,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        childAspectRatio: 1.0,
        children: [
          _KeypadButton(
            number: '1',
            onPressed: () => onNumberPressed('1'),
          ),
          _KeypadButton(
            number: '2',
            onPressed: () => onNumberPressed('2'),
          ),
          _KeypadButton(
            number: '3',
            onPressed: () => onNumberPressed('3'),
          ),
          _KeypadButton(
            number: '4',
            onPressed: () => onNumberPressed('4'),
          ),
          _KeypadButton(
            number: '5',
            onPressed: () => onNumberPressed('5'),
          ),
          _KeypadButton(
            number: '6',
            onPressed: () => onNumberPressed('6'),
          ),
          _KeypadButton(
            number: '7',
            onPressed: () => onNumberPressed('7'),
          ),
          _KeypadButton(
            number: '8',
            onPressed: () => onNumberPressed('8'),
          ),
          _KeypadButton(
            number: '9',
            onPressed: () => onNumberPressed('9'),
          ),
          _KeypadButton(
            number: ',',
            onPressed: onDecimal,
          ),
          _KeypadButton(
            number: '0',
            onPressed: () => onNumberPressed('0'),
          ),
          _KeypadButton(
            isBackspace: true,
            onPressed: onBackspace,
          ),
        ],
      ),
    );
  }
}

class _KeypadButton extends StatelessWidget {
  final String? number;
  final bool isBackspace;
  final VoidCallback onPressed;

  const _KeypadButton({
    this.number,
    this.isBackspace = false,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          color: const Color(0xFF187AD0),
          shape: BoxShape.circle,
        ),
        child: InkWell(
          onTap: onPressed,
          customBorder: CircleBorder(),
          splashColor: Colors.white.withValues(alpha: 0.3),
          highlightColor: Colors.white.withValues(alpha: 0.2),
          child: Center(
            child: isBackspace
                ? Icon(
                    Icons.backspace_outlined,
                    color: Colors.white,
                    size: 24.sp,
                  )
                : Text(
                    number ?? '',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
