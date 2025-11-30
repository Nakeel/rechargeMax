import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:recharge_max/core/router/route_name.dart';
import 'package:recharge_max/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:recharge_max/features/auth/presentation/screens/phone_entry_screen.dart';
import 'package:recharge_max/features/auth/presentation/screens/otp_verification_screen.dart';

class AuthFlowScreen extends StatelessWidget {
  const AuthFlowScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc()..add(InitializeAuthEvent()),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccessState) {
            context.go(AppRoutes.homeRoute);
          }
        },
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is PhoneEntryState) {
              return const PhoneEntryScreen();
            } else if (state is OtpVerificationState) {
              return OtpVerificationScreen(
                phoneNumber: state.phoneNumber,
              );
            } else if (state is AuthSuccessState) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
