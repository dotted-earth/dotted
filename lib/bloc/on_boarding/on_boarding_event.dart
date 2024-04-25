part of 'on_boarding_bloc.dart';

@immutable
sealed class OnBoardingEvent {}

final class OnBoardedPreferencesDataRequested extends OnBoardingEvent {}

final class OnBoardedFinishRequested extends OnBoardingEvent {
  final List<PreferenceItemModel> userRecreations;
  final List<PreferenceItemModel> userDiets;
  final List<PreferenceItemModel> userCuisines;
  final List<PreferenceItemModel> userFoodAllergies;

  OnBoardedFinishRequested({
    required this.userRecreations,
    required this.userDiets,
    required this.userCuisines,
    required this.userFoodAllergies,
  });
}
