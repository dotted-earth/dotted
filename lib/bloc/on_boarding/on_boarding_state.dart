part of 'on_boarding_bloc.dart';

@immutable
sealed class OnBoardingState {}

final class OnBoardingInitial extends OnBoardingState {}

final class OnBoardingLoading extends OnBoardingState {}

final class OnBoardingSuccess extends OnBoardingState {
  final List<PreferenceItemModel> recreations;
  final List<PreferenceItemModel> diets;
  final List<PreferenceItemModel> cuisines;
  final List<PreferenceItemModel> foodAllergies;

  OnBoardingSuccess({
    required this.recreations,
    required this.diets,
    required this.cuisines,
    required this.foodAllergies,
  });
}

final class OnBoardingFailure extends OnBoardingState {
  final String error;

  OnBoardingFailure(this.error);
}

final class OnBoardedFinished extends OnBoardingState {}
