import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:recharge_max/common/widgets/app_text.dart';
import 'package:recharge_max/core/ui/colors.dart';

import 'custom_checkbox.dart';

class MultiSelectOptionWidget<T> extends StatefulWidget {
  final String title;
  final List<T> items;
  final List<T> initiallySelectedItems;
  final ValueChanged<List<T>> onSelectionChanged;
  final double? maxHeight;

  const MultiSelectOptionWidget({
    Key? key,
    required this.title,
    required this.items,
    required this.initiallySelectedItems,
    required this.onSelectionChanged, this.maxHeight,
  }) : super(key: key);

  @override
  _MultiSelectOptionWidgetState<T> createState() => _MultiSelectOptionWidgetState<T>();
}

class _MultiSelectOptionWidgetState<T> extends State<MultiSelectOptionWidget<T>> {
  late List<T> _selectedItems;

  @override
  void initState() {
    super.initState();
    _selectedItems = List<T>.from(widget.initiallySelectedItems);
  }

  bool _isSelected(T item) => _selectedItems.contains(item);

  void _toggleSelection(T item) {
    setState(() {
      if (_selectedItems.contains(item)) {
        _selectedItems.remove(item);
      } else {
        _selectedItems.add(item);
      }
    });

    widget.onSelectionChanged(_selectedItems);
  }

  void _resetSelection() {
    setState(() {
        _selectedItems = [];
    });
    widget.onSelectionChanged([]);
  }

  @override
  Widget build(BuildContext context) {
    Size size  = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: AppColors.colorTextFieldBorder,
          ),
        ),
        const SizedBox(height: 8),

        // Scrollable list with max height
        ConstrainedBox(
          constraints:  BoxConstraints(
            maxHeight: widget.maxHeight ?? size.height * .2,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: List.generate(widget.items.length, (index) {
                final item = widget.items[index];
                final isSelected = _isSelected(item);
                final data = item as dynamic;

                return GestureDetector(
                  onTap: () => _toggleSelection(item),
                  child: Row(
                    children: [
                      CustomCheckbox(
                        value: isSelected,
                        onChanged: (_) => _toggleSelection(item),
                        borderSide: BorderSide(
                          color: isSelected ? AppColors.colorPrimary : AppColors.hintGrey,
                          width: 1,
                        ),
                        activeColor: Colors.green,
                        checkColor: Colors.white,
                      ),
                      Expanded(
                        child: TextView(
                          text: '${item.toString()} ${data.totalItem!=null?'(${data.totalItem ?? ''})' : ''}',
                          fontSize: 14,
                          fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                          color: AppColors.colorBlack,
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
