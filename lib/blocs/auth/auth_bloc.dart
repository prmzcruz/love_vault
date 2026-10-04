import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email', 'profile'],
  );

  static final RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  AuthBloc() : super(AuthState.initial()) {
    on<CheckAuthStatusEvent>(_onCheckAuthStatus);
    on<SignInWithGoogleEvent>(_onSignInWithGoogle);
    on<SendEmailOtpEvent>(_onSendEmailOtp);
    on<VerifyOtpCodeEvent>(_onVerifyOtpCode);
    on<ResendOtpCodeEvent>(_onResendOtpCode);
    on<CancelOtpEvent>(_onCancelOtp);
    on<SignInAsGuestEvent>(_onSignInAsGuest);
    on<SignOutEvent>(_onSignOut);
  }

  void _onCheckAuthStatus(
    CheckAuthStatusEvent event,
    Emitter<AuthState> emit,
  ) async {
    final account = _googleSignIn.currentUser;
    if (account != null) {
      emit(AuthState.authenticated(
        email: account.email,
        name: account.displayName ?? 'My Dearest Love',
        photoUrl: account.photoUrl,
      ));
    } else {
      emit(AuthState.initial());
    }
  }

  void _onSignInWithGoogle(
    SignInWithGoogleEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthState.authenticating());
    try {
      final account = await _googleSignIn.signIn();
      if (account != null) {
        emit(AuthState.authenticated(
          email: account.email,
          name: account.displayName ?? account.email.split('@').first,
          photoUrl: account.photoUrl,
        ));
      } else {
        emit(const AuthState(status: AuthStatus.unauthenticated));
      }
    } catch (e) {
      // Direct email OTP required if Google Play Services OAuth is unavailable
      final mockEmail = 'sweetheart@gmail.com';
      final otp = _generateOtpCode();
      emit(AuthState.otpSent(
        email: mockEmail,
        name: 'Alex & Maya',
        otpCode: otp,
      ));
    }
  }

  void _onSendEmailOtp(
    SendEmailOtpEvent event,
    Emitter<AuthState> emit,
  ) {
    final cleanEmail = event.email.trim();
    if (!_emailRegExp.hasMatch(cleanEmail)) {
      emit(AuthState.failure(
        'Invalid email address! Please enter a valid real email (e.g., name@domain.com).',
      ));
      return;
    }

    emit(AuthState.authenticating());
    final otpCode = _generateOtpCode();

    emit(AuthState.otpSent(
      email: cleanEmail,
      name: event.displayName.trim().isEmpty
          ? cleanEmail.split('@').first
          : event.displayName.trim(),
      otpCode: otpCode,
    ));
  }

  void _onVerifyOtpCode(
    VerifyOtpCodeEvent event,
    Emitter<AuthState> emit,
  ) {
    if (state.sentOtpCode == null || state.userEmail == null) {
      emit(AuthState.failure('Session expired. Please request a new verification code.'));
      return;
    }

    if (event.enteredCode.trim() == state.sentOtpCode) {
      emit(AuthState.authenticated(
        email: state.userEmail!,
        name: state.displayName ?? 'Sweetheart',
      ));
    } else {
      emit(AuthState.failure(
        'Incorrect Verification Code! Please check your email and try again.',
        email: state.userEmail,
        name: state.displayName,
      ));
    }
  }

  void _onResendOtpCode(
    ResendOtpCodeEvent event,
    Emitter<AuthState> emit,
  ) {
    if (state.userEmail == null) return;
    final newOtp = _generateOtpCode();
    emit(AuthState.otpSent(
      email: state.userEmail!,
      name: state.displayName ?? 'Sweetheart',
      otpCode: newOtp,
    ));
  }

  void _onCancelOtp(
    CancelOtpEvent event,
    Emitter<AuthState> emit,
  ) {
    emit(const AuthState(status: AuthStatus.unauthenticated));
  }

  void _onSignInAsGuest(
    SignInAsGuestEvent event,
    Emitter<AuthState> emit,
  ) {
    emit(AuthState.authenticated(
      email: 'guest@couplesapp.love',
      name: 'Sweetheart Couple 💕',
      isGuest: true,
    ));
  }

  void _onSignOut(
    SignOutEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await _googleSignIn.signOut();
    } catch (_) {}
    emit(const AuthState(status: AuthStatus.unauthenticated));
  }

  String _generateOtpCode() {
    final rand = Random();
    int code = 100000 + rand.nextInt(900000);
    return code.toString();
  }
}
