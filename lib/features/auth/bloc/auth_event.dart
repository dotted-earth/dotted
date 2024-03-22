part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {
  const AuthEvent();
}

final class LoginWithGoogleRequest extends AuthEvent {
  const LoginWithGoogleRequest();
}
