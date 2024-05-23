part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {
  const AuthEvent();
}

final class AuthLoginWithGoogleRequested extends AuthEvent {
  const AuthLoginWithGoogleRequested();
}

final class AuthLoginWithAppleRequested extends AuthEvent {
  const AuthLoginWithAppleRequested();
}

final class AuthLogOutRequested extends AuthEvent {
  const AuthLogOutRequested();
}

final class AuthLoginFromSession extends AuthEvent {
  final User user;
  const AuthLoginFromSession({required this.user});
}
