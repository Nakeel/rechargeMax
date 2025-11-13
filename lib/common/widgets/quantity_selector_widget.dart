import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:recharge_max/common/widgets/app_button.dart';
import 'package:recharge_max/core/ui/colors.dart';

import 'app_text.dart';

class QuantitySelectorWidget extends StatefulWidget {
  final int initialQuantity;
  final Function(int) onQuantityChanged;
  final double iconSize;

  const QuantitySelectorWidget({
    super.key,
    this.initialQuantity = 1,
    required this.onQuantityChanged,
    this.iconSize = 20,
  });

  @override
  _QuantitySelectorWidgetState createState() => _QuantitySelectorWidgetState();
}

class _QuantitySelectorWidgetState extends State<QuantitySelectorWidget> {
  // Controller for the TextField to manage its text
  late TextEditingController _quantityController;
  // FocusNode to detect when the TextField gains or loses focus
  late FocusNode _focusNode;
  // Internal state to hold the current quantity value
  int _quantity = 0;

  @override
  void initState() {
    super.initState();
    _quantity = widget.initialQuantity;
    // Initialize controller with the initial quantity
    _quantityController = TextEditingController(text: _quantity.toString());
    _focusNode = FocusNode();

    // Add a listener to the focus node to handle changes when the TextField loses focus
    _focusNode.addListener(_onFocusChanged);
  }

  @override
  void didUpdateWidget(covariant QuantitySelectorWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // If the parent widget updates the initialQuantity, update our internal state and controller
    if (widget.initialQuantity != oldWidget.initialQuantity) {
      _quantity = widget.initialQuantity;
      // Only update controller text if it's different to avoid unnecessary rebuilds
      if (_quantityController.text != _quantity.toString()) {
        _quantityController.text = _quantity.toString();
      }
    }
  }

  // Callback when the TextField's focus state changes
  void _onFocusChanged() {
    if (!_focusNode.hasFocus) {
      // If the TextField has lost focus, validate and update the quantity
      _updateQuantityFromController();
    }
  }

  // Parses the text from the controller and updates the quantity state
  void _updateQuantityFromController() {
    final input = int.tryParse(_quantityController.text.trim());
    if (input != null && input > 0) {
      // If the input is a valid positive number and different from current quantity
      if (input != _quantity) {
        setState(() {
          _quantity = input;
          widget.onQuantityChanged(_quantity); // Notify parent of the change
        });
      }
    } else {
      // If input is invalid (null, 0, or non-numeric), revert to a default valid quantity (e.g., 1)
      // This ensures the quantity never becomes 0 or an invalid number
      if (_quantityController.text.isEmpty || input == 0) {
        setState(() {
          _quantity = 1; // Minimum quantity is 1
          _quantityController.text =
              _quantity.toString(); // Update controller to reflect the change
          widget.onQuantityChanged(_quantity); // Notify parent
        });
      } else {
        // If it's an invalid non-empty string (e.g., "abc"), revert controller text to the last valid quantity
        _quantityController.text = _quantity.toString();
      }
    }
  }

  // Method to increment quantity
  void _increaseQuantity() {
    setState(() {
      _quantity++;
      _quantityController.text =
          _quantity.toString(); // Keep controller text in sync
      widget.onQuantityChanged(_quantity); // Notify parent
    });
  }

  // Method to decrement quantity
  void _decreaseQuantity() {
    if (_quantity > 1) {
      // Ensure quantity does not go below 1
      setState(() {
        _quantity--;
        _quantityController.text =
            _quantity.toString(); // Keep controller text in sync
        widget.onQuantityChanged(_quantity); // Notify parent
      });
    }
  }

  @override
  void dispose() {
    // Dispose controllers and focus nodes to prevent memory leaks
    _quantityController.dispose();
    _focusNode
        .removeListener(_onFocusChanged); // Remove listener before disposing
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize:
            MainAxisSize.min, // Ensure the row only takes necessary space
        children: [
          IconButton(
            onPressed: _quantity <= 1
                ? null
                : _decreaseQuantity, // Disable button if quantity is 1
            icon: Icon(
              Icons.remove_circle_outline_outlined,
              size: widget.iconSize,
              color: _quantity <= 1 ? AppColors.dividerGrey : Colors.black,
            ),
            padding: EdgeInsets.zero,
          ),
          // Replaced the GestureDetector and Text with a TextField
          SizedBox(
            width:
                40, // Fixed width for the TextField, adjust as needed for larger numbers
            child: TextField(
              controller: _quantityController,
              focusNode: _focusNode,
              textAlign: TextAlign.center, // Center the text horizontally
              keyboardType: TextInputType.number, // Show numeric keyboard
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly, // Allow only digits
              ],
              onChanged: (text) {
                // Immediately update quantity as user types valid numbers
                final input = int.tryParse(text);
                if (input != null && input > 0) {
                  if (input != _quantity) {
                    setState(() {
                      _quantity = input;
                      widget.onQuantityChanged(_quantity);
                    });
                  }
                }
                // If input is empty or invalid, we don't immediately set _quantity to 1.
                // We let _onFocusChanged handle the final validation when the user blurs the field.
                // This provides a better user experience, allowing temporary empty states.
              },
              decoration: InputDecoration(
                isDense: true, // Reduces the vertical height of the input field
                contentPadding: EdgeInsets.zero, // Removes internal padding
                filled: true,
                fillColor:
                    Colors.transparent, // Makes the background transparent
                border: InputBorder.none, // No border when not focused
                enabledBorder:
                    InputBorder.none, // No border when enabled but not focused
                focusedBorder: const UnderlineInputBorder(
                  // Underline border when focused
                  borderSide: BorderSide(
                      color: AppColors.colorPrimary,
                      width: 1.0), // Customize color and thickness
                ),
                hintText: '1', // Optional hint text for an empty field
                hintStyle: TextStyle(color: AppColors.dividerGrey),
              ),
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.black100,
              ),
            ),
          ),
          IconButton(
            onPressed: _increaseQuantity,
            icon: Icon(
              Icons.add_circle_outline_outlined,
              size: widget.iconSize,
              color: Colors.black,
            ),
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }
}
