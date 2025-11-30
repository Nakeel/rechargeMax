import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:recharge_max/core/router/route_name.dart';
import 'package:recharge_max/features/dashboard/presentation/widgets/bottom_nav_bar.dart';

class ShellLayout extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const ShellLayout({
    Key? key,
    required this.navigationShell,
  }) : super(key: key);

  @override
  State<ShellLayout> createState() => _ShellLayoutState();
}

class _ShellLayoutState extends State<ShellLayout> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.navigationShell.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: widget.navigationShell,
      bottomNavigationBar: BottomNavBar(
        selectedIndex: widget.navigationShell.currentIndex,
        onItemSelected: _onItemSelected,
      ),
    );
  }

  void _onItemSelected(int index) {
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }
}
