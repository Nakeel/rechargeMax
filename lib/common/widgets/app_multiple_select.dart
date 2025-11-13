import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recharge_max/common/models/drop_down_model.dart';
import 'package:recharge_max/common/widgets/app_text.dart';
import 'package:recharge_max/core/ui/colors.dart';
import 'package:recharge_max/core/utils/size.dart';

class AppMultipleSelect extends StatefulWidget {
  const AppMultipleSelect({
    super.key,
    required this.label,
    required this.options,
    required this.onSelected,
  });

  final String label;
  final List<DropDownOption> options;
  final Function onSelected;

  @override
  State<AppMultipleSelect> createState() => _AppMultipleSelectState();
}

class _AppMultipleSelectState extends State<AppMultipleSelect> {
  String _searchText = '';
  List<DropDownOption> _selectedItems = [];
  bool _isExpanded = false;

  void _toggleDropdown() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void _toggleItem(DropDownOption item, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedItems = _selectedItems
            .where((element) => element.value != item.value)
            .toList();
      } else {
        _selectedItems.add(item);
      }
      widget.onSelected(_selectedItems);
    });
  }

  bool checkIfSelected(DropDownOption item) {
    return _selectedItems
        .where((element) => element.value == item.value)
        .isNotEmpty;
  }

  void _clearSearch() {
    setState(() {
      _searchText = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredItems = widget.options
        .where((item) =>
            item.label.toLowerCase().contains(_searchText.toLowerCase()))
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextView(
          text: widget.label,
          color: AppColors.colorBlack,
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
        ),
        S.h(8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GestureDetector(
              onTap: _toggleDropdown,
              child: Container(
                width: S.availableScreenWidth(context),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: _selectedItems.isEmpty
                      ? Colors.white
                      : AppColors.colorTextFieldFocus,
                  border: Border.all(
                    width: _selectedItems.isEmpty ? 1.w : 0,
                    color: _selectedItems.isEmpty
                        ? AppColors.colorTextFieldBorder
                        : AppColors.colorTextFieldFocus,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: S.availableScreenWidth(context) * 0.8,
                      child: Wrap(
                        children: _selectedItems.map((item) {
                          bool isSelected = checkIfSelected(item);

                          return GestureDetector(
                            onTap: () => _toggleItem(item, isSelected),
                            child: Chip(
                              onDeleted: () => _toggleItem(item, isSelected),
                              deleteIcon: SizedBox(
                                width: 20.w,
                                height: 20.h,
                                child: SvgPicture.asset(
                                  'assets/svg/cancel.svg',
                                  colorFilter: const ColorFilter.mode(
                                    AppColors.colorBlack,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                              label: Text(
                                item.label,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                ),
                              ),
                              backgroundColor: const Color(0XFFE4E6E8),
                              labelStyle: const TextStyle(
                                color: Color(0XFF646668),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    SvgPicture.asset(
                      'assets/svg/arrow_down.svg',
                      colorFilter: const ColorFilter.mode(
                        AppColors.colorBlack,
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 100),
              height: _isExpanded
                  ? widget.options.length > 4
                      ? 200
                      : (widget.options.length + 1) * 50.0
                  : 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _isExpanded
                      ? Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: TextField(
                            onChanged: (value) =>
                                setState(() => _searchText = value),
                            decoration: InputDecoration(
                              hintText: 'Search',
                              hintStyle: TextStyle(
                                fontSize: 14.sp,
                              ),
                              suffixIcon: _searchText.isNotEmpty
                                  ? IconButton(
                                      icon: const Icon(Icons.clear),
                                      onPressed: _clearSearch,
                                    )
                                  : null,
                            ),
                          ),
                        )
                      : const SizedBox.shrink(),
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: filteredItems.length,
                      itemBuilder: (context, index) {
                        final item = filteredItems[index];
                        bool isSelected = checkIfSelected(item);
                        return GestureDetector(
                          onTap: () => _toggleItem(item, isSelected),
                          child: Container(
                            color: Colors.transparent,
                            height: 50,
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(item.label),
                                if (isSelected)
                                  Icon(
                                    Icons.check_circle_outline_sharp,
                                    size: 20,
                                    color: Theme.of(context).primaryColor,
                                  ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
