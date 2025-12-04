import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recharge_max/core/ui/app_theme.dart';
import 'package:recharge_max/core/ui/colors.dart';
import 'package:recharge_max/core/ui/assets.dart';
import 'package:recharge_max/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:recharge_max/features/auth/presentation/widgets/numeric_keypad.dart';
import 'package:recharge_max/common/widgets/app_button.dart';
import 'package:recharge_max/core/utils/phone_number_formatter.dart';

class PhoneEntryScreen extends StatefulWidget {
  const PhoneEntryScreen({super.key});

  @override
  State<PhoneEntryScreen> createState() => _PhoneEntryScreenState();
}

class _PhoneEntryScreenState extends State<PhoneEntryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorPrimary,
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is! PhoneEntryState) {
            return const SizedBox();
          }

          return Stack(
            children: [
              Image.asset(Assets.logoBg, fit: BoxFit.cover,),
              SafeArea(
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 50.h),
                        _buildLogo(),
                        SizedBox(height: 20.h),
                        _buildHeader(),
                        SizedBox(height: 30.h),
                        _buildPhoneInput(context, state),
                        SizedBox(height: 16.h),
                        _buildSendOtpButton(context, state),
                        SizedBox(height: 22.h),
                        _buildTermsText(),
                        SizedBox(height: 32.h),
                      ],
                    ),
                    Expanded(
                      child: _buildKeypad(context),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildLogo() {
    return SvgPicture.asset(
      Assets.logoSvg,
      width: 100.w,
      height: 100.w,
      colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Text(
          'Enter your phone number',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
            fontFamily: AppTheme.roboto
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          "We'll send you a verification code",
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneInput(BuildContext context, PhoneEntryState state) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: SvgPicture.asset(
                    'assets/svg/ngnFlag.svg',
                    width: 24.w,
                    height: 24.w,
                  ),
                ),
                Text(
                  '+234',
                  style: TextStyle(
                    color: AppColors.black200,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(width: 8.w),
                Container(
                  width: 1.w,
                  height: 24.h,
                  color: AppColors.hintGrey,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text(
                      state.phoneNumber.isEmpty
                          ? 'Phone number'
                          : PhoneNumberFormatter.formatPhoneNumberForDisplay(state.phoneNumber),
                      style: TextStyle(
                        color: state.phoneNumber.isEmpty
                            ? AppColors.lightGrey
                            : Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            height: 56.h,
          ),
          if (state.error != null)
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Text(
                state.error!,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSendOtpButton(BuildContext context, PhoneEntryState state) {
    final isValid = state.phoneNumber.length == 10;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: AppButton.fill(
        context: context,
        text: 'Send OTP',
        size: Size(double.infinity, 56.h),
        disabled: !isValid || state.isLoading,
        loading: state.isLoading,
        backgroundColor: Colors.white,
        textColor: AppColors.colorPrimary,
        onPressed: isValid && !state.isLoading
            ? () {
                context.read<AuthBloc>().add(
                      SendOtpEvent(phoneNumber: state.phoneNumber),
                    );
              }
            : null,
      ),
    );
  }

  Widget _buildTermsText() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          text: 'By continuing, you agree to our ',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
          ),
          children: [
            TextSpan(
              text: 'Terms of Service',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                // decoration: TextDecoration.underline,
              ),
            ),
            TextSpan(
              text: ' and ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Privacy Policy',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.w700,
                // decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKeypad(BuildContext context) {
    return NumericKeypad(
      onNumberPressed: (number) {
        context.read<AuthBloc>().add(
              KeypadInputEvent(input: number),
            );
      },
      onDecimal: () {
        // Decimal not used for phone numbers, but kept for consistency
      },
      onBackspace: () {
        context.read<AuthBloc>().add(KeypadBackspaceEvent());
      },
    );
  }
}
