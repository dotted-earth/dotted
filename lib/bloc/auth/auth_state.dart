part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final UserProfileModel? user;
  final bool isLoading;

  const AuthState({this.user, required this.isLoading});

  AuthState copyWith(UserProfileModel? user, bool? isLoading) {
    return AuthState(
        user: user ?? this.user, isLoading: isLoading ?? this.isLoading);
  }

  @override
  List<Object?> get props => [user, isLoading];
}

final class AuthInitial extends AuthState {
  AuthInitial({required super.isLoading});
}

final class AuthSuccess extends AuthState {
  final String navigateToPage;

  AuthSuccess(
      {super.user, required this.navigateToPage, required super.isLoading});
}

final class AuthFailure extends AuthState {
  final String error;

  AuthFailure({required super.isLoading, required this.error});
}

final class AuthLoading extends AuthState {
  AuthLoading({required super.isLoading});
}
