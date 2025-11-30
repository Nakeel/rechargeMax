import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:recharge_max/core/ui/app_theme.dart';
import 'package:recharge_max/core/ui/colors.dart';
import 'package:recharge_max/core/ui/assets.dart';
import 'package:recharge_max/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:recharge_max/features/auth/presentation/widgets/numeric_keypad.dart';
import 'package:recharge_max/features/auth/presentation/widgets/otp_input_field.dart';
import 'package:recharge_max/common/widgets/app_button.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String phoneNumber;

  const OtpVerificationScreen({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.colorPrimary,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is! OtpVerificationState) {
              return const SizedBox();
            }

            return Stack(
              children: [
                Image.asset(Assets.logoBg, fit: BoxFit.cover,),
                SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 50.h),
                    _buildLogo(),
                    SizedBox(height: 24.h),
                    _buildHeader(state),
                    SizedBox(height: 30.h),
                    _buildOtpInputFields(context, state),
                    SizedBox(height: 25.h),
                    _buildVerifyButton(context, state),
                    SizedBox(height: 16.h),
                    _buildResendSection(context, state),
                    SizedBox(height: 16.h),
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

  Widget _buildHeader(OtpVerificationState state) {
    return Column(
      children: [
        Text(
          'Enter OTP Code',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24.sp,
            fontFamily: AppTheme.roboto,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          'We sent a 6-digit code to +234 ${widget.phoneNumber}',
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildOtpInputFields(
    BuildContext context,
    OtpVerificationState state,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          6,
          (index) => OtpInputField(
            value: index < state.otpInput.length
                ? state.otpInput[index]
                : '',
          ),
        ),
      ),
    );
  }

  Widget _buildVerifyButton(
    BuildContext context,
    OtpVerificationState state,
  ) {
    final isValid = state.otpInput.length == 6;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: AppButton.fill(
        context: context,
        text: 'Verify OTP',
        size: Size(double.infinity, 56.h),
        disabled: !isValid || state.isLoading,
        loading: state.isLoading,
        backgroundColor: Colors.white,
        textColor: AppColors.colorPrimary,
        onPressed:  () {
                context.read<AuthBloc>().add(
                      VerifyOtpEvent(
                        otp: state.otpInput,
                        phoneNumber: state.phoneNumber,
                      ),
                    );
              },
      ),
    );
  }

  Widget _buildResendSection(
    BuildContext context,
    OtpVerificationState state,
  ) {
    return Column(
      children: [
        if (state.remainingSeconds > 0)
    RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: 'Resend in ',
        style: TextStyle(
          color: Colors.white,
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
        ),
        children: [
          TextSpan(
            text: '00:${state.remainingSeconds.toString().padLeft(2, '0')}',
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
              // decoration: TextDecoration.underline,
            ),
          ),

        ],
      ),
    )
        else
          GestureDetector(
            onTap: () {
              context.read<AuthBloc>().add(
                    ResendOtpEvent(phoneNumber: state.phoneNumber),
                  );
            },
            child: Text(
              'Resend OTP',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        // SizedBox(height: 12.h),
        TextButton(onPressed: (){
          context.read<AuthBloc>().add(ChangePhoneNumberEvent());
        }, child: Text(
          'Change phone number',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
          ),
        ),)
      ],
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
        // Decimal not used for OTP, but kept for consistency
      },
      onBackspace: () {
        context.read<AuthBloc>().add(KeypadBackspaceEvent());
      },
    );
  }
}
