import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recharge_max/core/ui/colors.dart';
import 'package:recharge_max/features/recharge/presentation/widgets/payment_method_selector.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({Key? key}) : super(key: key);

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedDateFilter = 'Yesterday';

  final List<Map<String, dynamic>> _transactions = [
    {
      'provider': 'Airtel',
      'icon': 'assets/svg/airtel.svg',
      'action': 'You recharge',
      'package': '1GB daily @1000',
      'phone': 'e.g 08023456789',
      'amount': '₦1000',
      'date': 'Yesterday',
    },
    {
      'provider': 'Airtel',
      'icon': 'assets/svg/airtel.svg',
      'action': 'You recharge',
      'package': '1GB daily @1000',
      'phone': 'e.g 08023456789',
      'amount': '₦1000',
      'date': 'Yesterday',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Search Field
                    _buildSearchField(),

                    SizedBox(height: 20.h),

                    // Date Filter
                    _buildDateFilter(),

                    SizedBox(height: 16.h),

                    // Transactions List
                    _buildTransactionsList(),

                    SizedBox(height: 24.h),

                    // Payment Method Section
                    PaymentMethodSelector(
                      onMethodSelected: (method) {
                        // Handle payment method selection
                      },
                    ),

                    SizedBox(height: 24.h),

                    // Recharge Now Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.colorPrimary,
                          padding: EdgeInsets.symmetric(vertical: 14.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        child: Text(
                          'Recharge Now',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 32.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Icon(
          Icons.arrow_back,
          color: AppColors.colorBlack,
          size: 24.sp,
        ),
      ),
      title: Text(
        'All Transactions',
        style: TextStyle(
          color: AppColors.colorBlack,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: false,
      actions: [
        Padding(
          padding: EdgeInsets.only(right: 16.w),
          child: GestureDetector(
            onTap: () {},
            child: Icon(
              Icons.history,
              color: AppColors.colorBlack,
              size: 24.sp,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: 'Search transaction',
        hintStyle: TextStyle(
          color: AppColors.descTextGrey,
          fontSize: 14.sp,
        ),
        prefixIcon: Icon(
          Icons.search,
          color: AppColors.descTextGrey,
          size: 20.sp,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: AppColors.naturalGrey,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: AppColors.naturalGrey,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: AppColors.colorPrimary,
            width: 1,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 12.h),
      ),
    );
  }

  Widget _buildDateFilter() {
    return Row(
      children: [
        Icon(
          Icons.expand_more,
          color: AppColors.colorBlack,
          size: 20.sp,
        ),
        SizedBox(width: 8.w),
        Text(
          _selectedDateFilter,
          style: TextStyle(
            color: AppColors.colorBlack,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildTransactionsList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: _transactions.map((transaction) {
        return Padding(
          padding: EdgeInsets.only(bottom: 16.h),
          child: Row(
            children: [
              // Provider Icon
              Container(
                width: 48.w,
                height: 48.w,
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    transaction['icon'],
                    width: 32.w,
                    height: 32.w,
                  ),
                ),
              ),

              SizedBox(width: 12.w),

              // Transaction Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transaction['action'],
                      style: TextStyle(
                        color: AppColors.colorBlack,
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      transaction['package'],
                      style: TextStyle(
                        color: AppColors.descTextGrey,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      transaction['phone'],
                      style: TextStyle(
                        color: AppColors.descTextGrey,
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(width: 12.w),

              // Amount
              Text(
                transaction['amount'],
                style: TextStyle(
                  color: AppColors.colorBlack,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
