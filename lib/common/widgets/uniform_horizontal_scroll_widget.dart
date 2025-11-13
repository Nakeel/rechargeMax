import 'package:flutter/material.dart';

class UniformHeightHorizontalList extends StatefulWidget {
  final List<Widget Function(ValueChanged<double> onHeightReported)> childrenBuilder;
  final EdgeInsetsGeometry? padding;
  final double spacing;

  const UniformHeightHorizontalList({
    super.key,
    required this.childrenBuilder,
    this.padding,
    this.spacing = 16.0,
  });

  @override
  State<UniformHeightHorizontalList> createState() => _UniformHeightHorizontalListState();
}

class _UniformHeightHorizontalListState extends State<UniformHeightHorizontalList> {
  double _maxHeight = 0;

  void _reportHeight(double height) {
    if (height > _maxHeight) {
      setState(() {
        _maxHeight = height;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.childrenBuilder.map((builder) {
      return SizedBox(
        height: _maxHeight > 0 ? _maxHeight : null,
        child: builder(_reportHeight),
      );
    }).toList();

    return SizedBox(
      height: _maxHeight == 0 ? 300 : _maxHeight + 20, // Fallback height
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 20),
        itemBuilder: (_, index) => items[index],
        separatorBuilder: (_, __) => SizedBox(width: widget.spacing),
        itemCount: items.length,
      ),
    );
  }
}
