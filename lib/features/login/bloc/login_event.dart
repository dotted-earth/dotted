part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {
  const LoginEvent();
}

final class LoginWithGoogleRequest extends LoginEvent {
  const LoginWithGoogleRequest();
}
