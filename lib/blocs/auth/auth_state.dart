import 'package:equatable/equatable.dart';

enum AuthStatus {
  initial,
  authenticating,
  otpSent,
  authenticated,
  unauthenticated,
  failure
}

class AuthState extends Equatable {
  final AuthStatus status;
  final String? userEmail;
  final String? displayName;
  final String? photoUrl;
  final bool isGuest;
  final String? sentOtpCode;
  final String? errorMessage;

  const AuthState({
    required this.status,
    this.userEmail,
    this.displayName,
    this.photoUrl,
    this.isGuest = false,
    this.sentOtpCode,
    this.errorMessage,
  });

  factory AuthState.initial() {
    return const AuthState(
      status: AuthStatus.unauthenticated,
      isGuest: false,
    );
  }

  factory AuthState.authenticated({
    required String email,
    required String name,
    String? photoUrl,
    bool isGuest = false,
  }) {
    return AuthState(
      status: AuthStatus.authenticated,
      userEmail: email,
      displayName: name,
      photoUrl: photoUrl,
      isGuest: isGuest,
    );
  }

  factory AuthState.otpSent({
    required String email,
    required String name,
    required String otpCode,
  }) {
    return AuthState(
      status: AuthStatus.otpSent,
      userEmail: email,
      displayName: name,
      sentOtpCode: otpCode,
    );
  }

  factory AuthState.authenticating() {
    return const AuthState(status: AuthStatus.authenticating);
  }

  factory AuthState.failure(String message, {String? email, String? name}) {
    return AuthState(
      status: AuthStatus.failure,
      userEmail: email,
      displayName: name,
      errorMessage: message,
    );
  }

  AuthState copyWith({
    AuthStatus? status,
    String? userEmail,
    String? displayName,
    String? photoUrl,
    bool? isGuest,
    String? sentOtpCode,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      userEmail: userEmail ?? this.userEmail,
      displayName: displayName ?? this.displayName,
      photoUrl: photoUrl ?? this.photoUrl,
      isGuest: isGuest ?? this.isGuest,
      sentOtpCode: sentOtpCode ?? this.sentOtpCode,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        userEmail,
        displayName,
        photoUrl,
        isGuest,
        sentOtpCode,
        errorMessage,
      ];
}
