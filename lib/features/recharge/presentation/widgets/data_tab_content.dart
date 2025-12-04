import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recharge_max/common/widgets/app_button.dart';
import 'package:recharge_max/core/ui/colors.dart';
import 'package:recharge_max/common/widgets/app_input.dart';
import 'package:recharge_max/core/utils/phone_number_formatter.dart';
import 'package:recharge_max/core/utils/currency_formatter.dart';
import 'package:recharge_max/core/utils/form_validator.dart';
import 'package:recharge_max/common/widgets/custom_dropdown.dart';
import 'quick_amount_selector.dart';
import 'entries_info_banner.dart';
import 'network_provider_selector.dart';
import 'payment_method_selector.dart';

/// Data tab content for recharge screen.
///
/// Displays form fields for data recharge including network provider,
/// data package selection, phone number, and payment method.
/// Manages its own state for data-specific selections.
class DataTabContent extends StatefulWidget {
  final Function(String)? onPaymentMethodSelected;

  const DataTabContent({
    Key? key,
    this.onPaymentMethodSelected,
  }) : super(key: key);

  @override
  State<DataTabContent> createState() => _DataTabContentState();
}

class _DataTabContentState extends State<DataTabContent> {
  String? _selectedProvider;
  String? _selectedDataPackage;
  late TextEditingController _phoneController;
  late TextEditingController _amountController;

  final List<String> _dataPackages = [
    '500MB - ₦100',
    '1GB - ₦200',
    '2GB - ₦400',
    '5GB - ₦1000',
    '10GB - ₦2000',
  ];

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
    _amountController = TextEditingController();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.colorWhite,
                borderRadius: BorderRadius.circular(14),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionLabel('Select Network Provider'),
                  SizedBox(height: 12.h),
                  NetworkProviderSelector(
                    selectedProvider: _selectedProvider,
                    onProviderSelected: (provider) {
                      setState(() => _selectedProvider = provider);
                    },
                  ),
                  SizedBox(height: 24.h),
                  _buildSectionLabel('Select Data Package'),
                  SizedBox(height: 12.h),
                  CustomDropDown(
                    selectedItem: _selectedDataPackage,
                    dropDownList: _dataPackages,
                    hintText: 'Choose a data package',
                    onValueChanged: (value) {
                      setState(() {
                        _selectedDataPackage = value;
                        // Extract amount from package (e.g., "1GB - ₦200" -> "200")
                        final amount = value.split('₦').last.trim();
                        _amountController.text = amount;
                      });
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
                  _buildSectionLabel('Data Price'),
                  SizedBox(height: 12.h),
                  AppTextField(
                    controller: _amountController,
                    hint: 'Data Amount ₦',
                    keyboardType: TextInputType.number,
                    enabled: false,
                    inputFormatters: [
                      AmountInputFormatter(locale: 'en_NG', symbol: '₦'),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) return null;
                      final cleaned = value.replaceAll(RegExp(r'[^0-9]'), '');
                      if (cleaned.isEmpty) return 'Please enter an amount';
                      final amount = double.tryParse(cleaned);
                      if (amount == null) return 'Invalid amount';
                      if (amount < 200) return 'Minimum amount is ₦200';
                      if (amount > 100000) return 'Maximum amount is ₦100,000';
                      return null;
                    },
                    removeBottomSpace: true,
                  ),
                  SizedBox(height: 20.h),
                  EntriesInfoBanner(),
                ],
              ),
            ),
            SizedBox(height: 24.h),

            if(_selectedProvider!=null && _selectedDataPackage!=null && _phoneController.text.isNotEmpty)
            Container(
              decoration: BoxDecoration(
                color: AppColors.colorWhite,
                borderRadius: BorderRadius.circular(14),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: PaymentMethodSelector(
                onMethodSelected: widget.onPaymentMethodSelected ?? (_) {},
              ),
            ),
            SizedBox(height: 30.h),
            AppButton.fill(
              context: context,
              size: Size(double.infinity, 54.h),
              text: 'Recharge Now',
              backgroundColor: AppColors.colorPrimary,
              textColor: AppColors.colorWhite,
              disabled: _selectedProvider==null || _phoneController.text.isEmpty || _selectedDataPackage==null,
              onPressed: () {},
            ),
          ],
        ),
      ),
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
}
