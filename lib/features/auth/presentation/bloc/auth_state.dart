part of 'auth_bloc.dart';

sealed class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class PhoneEntryState extends AuthState {
  final String phoneNumber;
  final bool isLoading;
  final String? error;

  const PhoneEntryState({
    required this.phoneNumber,
    this.isLoading = false,
    this.error,
  });

  PhoneEntryState copyWith({
    String? phoneNumber,
    bool? isLoading,
    String? error,
  }) {
    return PhoneEntryState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class OtpSentState extends AuthState {
  final String phoneNumber;
  final int remainingSeconds;

  const OtpSentState({
    required this.phoneNumber,
    this.remainingSeconds = 60,
  });

  OtpSentState copyWith({
    String? phoneNumber,
    int? remainingSeconds,
  }) {
    return OtpSentState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
    );
  }
}

class OtpVerificationState extends AuthState {
  final String phoneNumber;
  final String otpInput;
  final bool isLoading;
  final String? error;
  final int remainingSeconds;

  const OtpVerificationState({
    required this.phoneNumber,
    this.otpInput = '',
    this.isLoading = false,
    this.error,
    this.remainingSeconds = 60,
  });

  OtpVerificationState copyWith({
    String? phoneNumber,
    String? otpInput,
    bool? isLoading,
    String? error,
    int? remainingSeconds,
  }) {
    return OtpVerificationState(
      phoneNumber: phoneNumber ?? this.phoneNumber,
      otpInput: otpInput ?? this.otpInput,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
    );
  }
}

class AuthSuccessState extends AuthState {
  final String phoneNumber;

  const AuthSuccessState({required this.phoneNumber});
}

class AuthErrorState extends AuthState {
  final String message;

  const AuthErrorState({required this.message});
}
