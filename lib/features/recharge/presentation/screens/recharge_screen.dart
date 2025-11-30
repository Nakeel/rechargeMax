import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recharge_max/core/ui/colors.dart';
import 'package:recharge_max/features/recharge/presentation/widgets/network_provider_selector.dart';
import 'package:recharge_max/features/recharge/presentation/widgets/payment_method_selector.dart';

class RechargeScreen extends StatefulWidget {
  const RechargeScreen({Key? key}) : super(key: key);

  @override
  State<RechargeScreen> createState() => _RechargeScreenState();
}

class _RechargeScreenState extends State<RechargeScreen> {
  int _selectedTab = 0; // 0: Airtime, 1: Data
  String? _selectedProvider;
  int? _selectedAmount;
  String _customAmount = '';
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  final List<int> _quickAmounts = [200, 500, 1000, 5000];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Airtime/Data Tabs
              _buildTabs(),

              SizedBox(height: 24.h),

              // Network Provider Selection
              Text(
                'Select Network Provider',
                style: TextStyle(
                  color: AppColors.colorBlack,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 12.h),
              NetworkProviderSelector(
                selectedProvider: _selectedProvider,
                onProviderSelected: (provider) {
                  setState(() {
                    _selectedProvider = provider;
                  });
                },
              ),

              SizedBox(height: 24.h),

              // Phone Number Input
              Text(
                'Phone Number',
                style: TextStyle(
                  color: AppColors.colorBlack,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8.h),
              _buildPhoneInput(),

              SizedBox(height: 24.h),

              // Amount Selection
              Text(
                'Select Amount',
                style: TextStyle(
                  color: AppColors.colorBlack,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 12.h),
              _buildAmountButtons(),

              SizedBox(height: 12.h),

              // Custom Amount Input
              _buildCustomAmountInput(),

              SizedBox(height: 12.h),
              Text(
                'Minimum amount: ₦200',
                style: TextStyle(
                  color: AppColors.descTextGrey,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),

              SizedBox(height: 20.h),

              // Entries Info (only on second variant)
              _buildEntriesInfo(),

              SizedBox(height: 24.h),

              // Payment Method
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
            ],
          ),
        ),
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
        'Recharge',
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

  Widget _buildTabs() {
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _selectedTab = 0),
            child: Column(
              children: [
                Text(
                  'Airtime',
                  style: TextStyle(
                    color: _selectedTab == 0
                        ? AppColors.colorPrimary
                        : AppColors.descTextGrey,
                    fontSize: 14.sp,
                    fontWeight:
                        _selectedTab == 0 ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
                SizedBox(height: 8.h),
                Container(
                  height: 3.h,
                  decoration: BoxDecoration(
                    color: _selectedTab == 0
                        ? AppColors.colorPrimary
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 24.w),
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _selectedTab = 1),
            child: Column(
              children: [
                Text(
                  'Data',
                  style: TextStyle(
                    color: _selectedTab == 1
                        ? AppColors.colorPrimary
                        : AppColors.descTextGrey,
                    fontSize: 14.sp,
                    fontWeight:
                        _selectedTab == 1 ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
                SizedBox(height: 8.h),
                Container(
                  height: 3.h,
                  decoration: BoxDecoration(
                    color: _selectedTab == 1
                        ? AppColors.colorPrimary
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneInput() {
    return TextField(
      controller: _phoneController,
      decoration: InputDecoration(
        hintText: 'e.g 08023456789',
        hintStyle: TextStyle(
          color: AppColors.descTextGrey,
          fontSize: 14.sp,
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
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      ),
    );
  }

  Widget _buildAmountButtons() {
    return Wrap(
      spacing: 12.w,
      runSpacing: 12.h,
      children: _quickAmounts.map((amount) {
        final isSelected = _selectedAmount == amount;
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedAmount = amount;
              _amountController.text = amount.toString();
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.colorPrimary.withOpacity(0.1) : Colors.white,
              border: Border.all(
                color: isSelected ? AppColors.colorPrimary : AppColors.naturalGrey,
                width: isSelected ? 2 : 1,
              ),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Text(
              '₦$amount',
              style: TextStyle(
                color: isSelected ? AppColors.colorPrimary : AppColors.colorBlack,
                fontSize: 13.sp,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCustomAmountInput() {
    return TextField(
      controller: _amountController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: 'or enter amount ₦',
        hintStyle: TextStyle(
          color: AppColors.descTextGrey,
          fontSize: 14.sp,
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
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      ),
    );
  }

  Widget _buildEntriesInfo() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.colorPrimary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        "You'll earn 2 entries into today's draw, pls a spin on the price wheel!",
        style: TextStyle(
          color: AppColors.colorPrimary,
          fontSize: 12.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _amountController.dispose();
    super.dispose();
  }
}
