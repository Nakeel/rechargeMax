import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recharge_max/core/ui/colors.dart';
import 'package:recharge_max/common/widgets/app_button.dart';
import 'package:recharge_max/common/widgets/simple_app_bar.dart';
import 'package:recharge_max/features/recharge/presentation/widgets/airtime_data_tabs.dart';
import 'package:recharge_max/features/recharge/presentation/widgets/airtime_tab_content.dart';
import 'package:recharge_max/features/recharge/presentation/widgets/data_tab_content.dart';

class RechargeScreen extends StatefulWidget {
  const RechargeScreen({Key? key}) : super(key: key);

  @override
  State<RechargeScreen> createState() => _RechargeScreenState();
}

class _RechargeScreenState extends State<RechargeScreen> {
  int _selectedTab = 0; // 0: Airtime, 1: Data
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grey250,
      appBar: SimpleAppBar(
        showBackButton: false,
        title: 'Recharge',
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.history,
                color: AppColors.colorPrimary,
                size: 24.sp,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: AirtimeDataTabsWidget(
              selectedTab: _selectedTab,
              onTabChanged: _handleTabChange,
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: _handlePageChange,
              children: [
                AirtimeTabContent(),
                DataTabContent(),
              ],
            ),
          ),

        ],
      ),
    );
  }

  void _handleTabChange(int index) {
    setState(() => _selectedTab = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _handlePageChange(int index) {
    if (_selectedTab != index) {
      setState(() => _selectedTab = index);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
