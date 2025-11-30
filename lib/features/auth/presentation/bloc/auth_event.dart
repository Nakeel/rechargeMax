part of 'auth_bloc.dart';

sealed class AuthEvent {}

class InitializeAuthEvent extends AuthEvent {}

class SendOtpEvent extends AuthEvent {
  final String phoneNumber;

  SendOtpEvent({required this.phoneNumber});
}

class VerifyOtpEvent extends AuthEvent {
  final String otp;
  final String phoneNumber;

  VerifyOtpEvent({
    required this.otp,
    required this.phoneNumber,
  });
}

class ResendOtpEvent extends AuthEvent {
  final String phoneNumber;

  ResendOtpEvent({required this.phoneNumber});
}

class ChangePhoneNumberEvent extends AuthEvent {}

class KeypadInputEvent extends AuthEvent {
  final String input;

  KeypadInputEvent({required this.input});
}

class KeypadBackspaceEvent extends AuthEvent {}

class KeypadClearEvent extends AuthEvent {}

class TimerTickEvent extends AuthEvent {
  final int remainingSeconds;

  TimerTickEvent({required this.remainingSeconds});
}
