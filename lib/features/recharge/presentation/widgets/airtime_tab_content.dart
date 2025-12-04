import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recharge_max/core/ui/colors.dart';
import 'package:recharge_max/common/widgets/app_input.dart';
import 'package:recharge_max/core/utils/phone_number_formatter.dart';
import 'package:recharge_max/core/utils/currency_formatter.dart';
import 'package:recharge_max/core/utils/form_validator.dart';
import 'package:flutter/services.dart';
import 'quick_amount_selector.dart';
import 'entries_info_banner.dart';
import 'network_provider_selector.dart';
import 'payment_method_selector.dart';

/// Airtime tab content for recharge screen.
///
/// Displays form fields for airtime recharge including network provider,
/// phone number, amount selection, and payment method.
class AirtimeTabContent extends StatelessWidget {
  final String? selectedProvider;
  final Function(String)? onProviderSelected;
  final TextEditingController phoneController;
  final TextEditingController amountController;
  final int? selectedAmount;
  final Function(int)? onAmountSelected;
  final Function(String)? onPaymentMethodSelected;

  const AirtimeTabContent({
    Key? key,
    this.selectedProvider,
    this.onProviderSelected,
    required this.phoneController,
    required this.amountController,
    this.selectedAmount,
    this.onAmountSelected,
    this.onPaymentMethodSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionLabel('Select Network Provider'),
          SizedBox(height: 12.h),
          NetworkProviderSelector(
            selectedProvider: selectedProvider,
            onProviderSelected: onProviderSelected ?? (_) {},
          ),
          SizedBox(height: 24.h),
          _buildSectionLabel('Phone Number'),
          SizedBox(height: 8.h),
          AppTextField(
            controller: phoneController,
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
            selectedAmount: selectedAmount,
            onAmountSelected: onAmountSelected ?? (_) {},
          ),
          SizedBox(height: 12.h),
          AppTextField(
            controller: amountController,
            hint: 'or enter amount ₦',
            keyboardType: TextInputType.number,
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
            onMethodSelected: onPaymentMethodSelected ?? (_) {},
          ),
        ],
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
