import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recharge_max/core/ui/colors.dart';
import 'package:go_router/go_router.dart';
import 'package:recharge_max/common/widgets/app_input.dart';
import 'package:recharge_max/common/widgets/app_button.dart';
import 'package:recharge_max/core/utils/phone_number_formatter.dart';
import 'package:recharge_max/core/utils/currency_formatter.dart';
import 'package:recharge_max/core/utils/form_validator.dart';
import 'package:recharge_max/features/recharge/presentation/widgets/airtime_data_tabs.dart';
import 'package:recharge_max/features/recharge/presentation/widgets/quick_amount_selector.dart';
import 'package:recharge_max/features/recharge/presentation/widgets/entries_info_banner.dart';
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
              AirtimeDataTabsWidget(
                selectedTab: _selectedTab,
                onTabChanged: (tab) => setState(() => _selectedTab = tab),
              ),
              SizedBox(height: 24.h),
              _buildSectionLabel('Select Network Provider'),
              SizedBox(height: 12.h),
              NetworkProviderSelector(
                selectedProvider: _selectedProvider,
                onProviderSelected: (provider) {
                  setState(() => _selectedProvider = provider);
                },
              ),
              SizedBox(height: 24.h),
              _buildSectionLabel('Phone Number'),
              SizedBox(height: 8.h),
              AppTextField(
                controller: _phoneController,
                hint: 'e.g 08023456789',
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(11),
                ],
                validator: AppFormValidator.validatePhonenumber,
                removeBottomSpace: true,
              ),
              SizedBox(height: 24.h),
              _buildSectionLabel('Select Amount'),
              SizedBox(height: 12.h),
              QuickAmountSelector(
                selectedAmount: _selectedAmount,
                onAmountSelected: (amount) {
                  setState(() {
                    _selectedAmount = amount;
                    _amountController.text = amount.toString();
                  });
                },
              ),
              SizedBox(height: 12.h),
              AppTextField(
                controller: _amountController,
                hint: 'or enter amount ₦',
                keyboardType: TextInputType.number,
                inputFormatters: [
                  AmountInputFormatter(locale: 'en_NG', symbol: '₦'),
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return null;
                  }
                  // Clean the value for validation
                  final cleaned = value.replaceAll(RegExp(r'[^0-9]'), '');
                  if (cleaned.isEmpty) {
                    return 'Please enter an amount';
                  }
                  final amount = double.tryParse(cleaned);
                  if (amount == null) {
                    return 'Invalid amount';
                  }
                  if (amount < 200) {
                    return 'Minimum amount is ₦200';
                  }
                  if (amount > 100000) {
                    return 'Maximum amount is ₦100,000';
                  }
                  return null;
                },
                removeBottomSpace: true,
              ),
              SizedBox(height: 12.h),
              Text(
                'Amount: ₦200 - ₦100,000',
                style: TextStyle(
                  color: AppColors.descTextGrey,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 20.h),
              EntriesInfoBanner(),
              SizedBox(height: 24.h),
              PaymentMethodSelector(
                onMethodSelected: (method) {},
              ),
              SizedBox(height: 24.h),
              AppButton.fill(
                context: context,
                size: Size(double.infinity, 54.h),
                text: 'Recharge Now',
                onPressed: () {},
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
        onTap: () => context.pop(),
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

  Widget _buildSectionLabel(String label) {
    return Text(
      label,
      style: TextStyle(
        color: AppColors.colorBlack,
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
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
