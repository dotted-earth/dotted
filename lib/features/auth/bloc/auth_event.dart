part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {
  const AuthEvent();
}

final class AuthWithGoogleRequest extends AuthEvent {
  const AuthWithGoogleRequest();
}

final class AuthSignOutRequest extends AuthEvent {
  const AuthSignOutRequest();
}
