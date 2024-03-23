part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {
  const AuthEvent();
}

final class AuthLoginWithGoogleRequested extends AuthEvent {
  const AuthLoginWithGoogleRequested();
}

final class AuthLogOutRequested extends AuthEvent {
  const AuthLogOutRequested();
}
