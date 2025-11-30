import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  Timer? _resendTimer;
  int _remainingSeconds = 60;

  AuthBloc() : super(const AuthInitial()) {
    on<InitializeAuthEvent>(_onInitialize);
    on<SendOtpEvent>(_onSendOtp);
    on<VerifyOtpEvent>(_onVerifyOtp);
    on<ResendOtpEvent>(_onResendOtp);
    on<ChangePhoneNumberEvent>(_onChangePhoneNumber);
    on<KeypadInputEvent>(_onKeypadInput);
    on<KeypadBackspaceEvent>(_onKeypadBackspace);
    on<KeypadClearEvent>(_onKeypadClear);
    on<TimerTickEvent>(_onTimerTick);
  }

  Future<void> _onInitialize(
    InitializeAuthEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(const PhoneEntryState(phoneNumber: ''));
  }

  Future<void> _onSendOtp(
    SendOtpEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(PhoneEntryState(phoneNumber: event.phoneNumber, isLoading: true));

    try {
      // TODO: Call API to send OTP
      await Future.delayed(const Duration(seconds: 1));

      _remainingSeconds = 60;
      _startResendTimer();

      emit(OtpSentState(phoneNumber: event.phoneNumber));
      emit(OtpVerificationState(
        phoneNumber: event.phoneNumber,
        remainingSeconds: _remainingSeconds,
      ));
    } catch (e) {
      emit(PhoneEntryState(
        phoneNumber: event.phoneNumber,
        error: 'Failed to send OTP. Please try again.',
      ));
    }
  }

  Future<void> _onVerifyOtp(
    VerifyOtpEvent event,
    Emitter<AuthState> emit,
  ) async {
    if (state is OtpVerificationState) {
      final currentState = state as OtpVerificationState;
      emit(currentState.copyWith(isLoading: true));

      try {
        // TODO: Call API to verify OTP
        await Future.delayed(const Duration(seconds: 1));

        _resendTimer?.cancel();
        emit(AuthSuccessState(phoneNumber: event.phoneNumber));
      } catch (e) {
        emit(currentState.copyWith(
          isLoading: false,
          error: 'Invalid OTP. Please try again.',
        ));
      }
    }
  }

  Future<void> _onResendOtp(
    ResendOtpEvent event,
    Emitter<AuthState> emit,
  ) async {
    _resendTimer?.cancel();
    _remainingSeconds = 60;

    try {
      // TODO: Call API to resend OTP
      await Future.delayed(const Duration(seconds: 1));

      if (state is OtpVerificationState) {
        final currentState = state as OtpVerificationState;
        emit(currentState.copyWith(otpInput: '', error: null));
        _startResendTimer();
      }
    } catch (e) {
      // Show error
    }
  }

  Future<void> _onChangePhoneNumber(
    ChangePhoneNumberEvent event,
    Emitter<AuthState> emit,
  ) async {
    _resendTimer?.cancel();
    emit(const PhoneEntryState(phoneNumber: ''));
  }

  Future<void> _onKeypadInput(
    KeypadInputEvent event,
    Emitter<AuthState> emit,
  ) async {
    if (state is PhoneEntryState) {
      final currentState = state as PhoneEntryState;
      final newPhone = currentState.phoneNumber + event.input;
      if (newPhone.length <= 10) {
        emit(currentState.copyWith(phoneNumber: newPhone, error: null));
      }
    } else if (state is OtpVerificationState) {
      final currentState = state as OtpVerificationState;
      final newOtp = currentState.otpInput + event.input;
      if (newOtp.length <= 6) {
        emit(currentState.copyWith(otpInput: newOtp, error: null));
      }
    }
  }

  Future<void> _onKeypadBackspace(
    KeypadBackspaceEvent event,
    Emitter<AuthState> emit,
  ) async {
    if (state is PhoneEntryState) {
      final currentState = state as PhoneEntryState;
      final newPhone = currentState.phoneNumber.isNotEmpty
          ? currentState.phoneNumber.substring(
              0, currentState.phoneNumber.length - 1)
          : '';
      emit(currentState.copyWith(phoneNumber: newPhone));
    } else if (state is OtpVerificationState) {
      final currentState = state as OtpVerificationState;
      final newOtp = currentState.otpInput.isNotEmpty
          ? currentState.otpInput.substring(0, currentState.otpInput.length - 1)
          : '';
      emit(currentState.copyWith(otpInput: newOtp));
    }
  }

  Future<void> _onKeypadClear(
    KeypadClearEvent event,
    Emitter<AuthState> emit,
  ) async {
    if (state is PhoneEntryState) {
      final currentState = state as PhoneEntryState;
      emit(currentState.copyWith(phoneNumber: ''));
    } else if (state is OtpVerificationState) {
      final currentState = state as OtpVerificationState;
      emit(currentState.copyWith(otpInput: ''));
    }
  }

  void _startResendTimer() {
    _resendTimer?.cancel();
    _resendTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _remainingSeconds--;

      if (_remainingSeconds <= 0) {
        timer.cancel();
      } else {
        add(TimerTickEvent(remainingSeconds: _remainingSeconds));
      }
    });
  }

  Future<void> _onTimerTick(
    TimerTickEvent event,
    Emitter<AuthState> emit,
  ) async {
    if (state is OtpVerificationState) {
      final currentState = state as OtpVerificationState;
      emit(currentState.copyWith(remainingSeconds: event.remainingSeconds));
    }
  }

  @override
  Future<void> close() {
    _resendTimer?.cancel();
    return super.close();
  }
}
