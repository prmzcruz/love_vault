import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class CheckAuthStatusEvent extends AuthEvent {
  const CheckAuthStatusEvent();
}

class SignInWithGoogleEvent extends AuthEvent {
  const SignInWithGoogleEvent();
}

class SendEmailOtpEvent extends AuthEvent {
  final String email;
  final String displayName;

  const SendEmailOtpEvent({
    required this.email,
    required this.displayName,
  });

  @override
  List<Object?> get props => [email, displayName];
}

class VerifyOtpCodeEvent extends AuthEvent {
  final String enteredCode;

  const VerifyOtpCodeEvent(this.enteredCode);

  @override
  List<Object?> get props => [enteredCode];
}

class ResendOtpCodeEvent extends AuthEvent {
  const ResendOtpCodeEvent();
}

class CancelOtpEvent extends AuthEvent {
  const CancelOtpEvent();
}

class SignInAsGuestEvent extends AuthEvent {
  const SignInAsGuestEvent();
}

class SignOutEvent extends AuthEvent {
  const SignOutEvent();
}
