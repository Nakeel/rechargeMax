import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:recharge_max/core/ui/colors.dart';

class CurrencyInputField extends StatefulWidget {
  final String currency;
  final String hint;
  final TextEditingController? controller;
  final Function(String value)? onChanged;
  final List<TextInputFormatter>? inputFormatters;
  final Function()? onTap;
  final String? Function(String? value)? validator;

  const CurrencyInputField(
      {super.key,
      required this.currency,
      required this.hint,
      this.controller,
      this.onChanged,
      this.onTap,
      this.validator,
      this.inputFormatters});

  @override
  State<CurrencyInputField> createState() => _CurrencyInputFieldState();
}

class _CurrencyInputFieldState extends State<CurrencyInputField> {
  late final TextEditingController _controller;
  late final ValueNotifier<String?> _errorTextNotifier;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _errorTextNotifier = ValueNotifier<String?>(null);

    _controller.addListener(() {
      final error = widget.validator?.call(_controller.text);
      _errorTextNotifier.value = error;
      widget.onChanged?.call(_controller.text);
    });
  }

  @override
  void dispose() {
    if (widget.controller == null) _controller.dispose();
    _errorTextNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<String?>(
      valueListenable: _errorTextNotifier,
      builder: (_, errorText, __) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                    color: errorText == null ? AppColors.grey150 : Colors.red),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 14),
                    decoration: const BoxDecoration(
                      color: AppColors.green100,
                      borderRadius:
                          BorderRadius.horizontal(left: Radius.circular(8)),
                    ),
                    child: Text(
                      widget.currency,
                      style: const TextStyle(
                        color: AppColors.deepGreen,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Expanded(
                    child: TextFormField(
                      controller: _controller,
                      onTap: widget.onTap,
                      inputFormatters: widget.inputFormatters,
                      decoration: InputDecoration(
                        hintText: widget.hint,
                        hintStyle:
                            const TextStyle(fontSize: 14, color: Colors.grey),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 14),
                        errorText: null, // disables default error rendering
                      ),
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      style: const TextStyle(color: Colors.black, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
            if (errorText != null)
              Padding(
                padding: const EdgeInsets.only(left: 8, top: 4),
                child: Text(
                  errorText,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              )
          ],
        );
      },
    );
  }
}
