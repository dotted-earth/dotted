import 'package:dotted/features/user/models/preference_item_model.dart';
import 'package:dotted/features/user/repositories/preferences_repository.dart';
import 'package:dotted/features/user/repositories/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'on_boarding_event.dart';
part 'on_boarding_state.dart';

class OnBoardingBloc extends Bloc<OnBoardingEvent, OnBoardingState> {
  final UserRepository _userRepository;
  final PreferencesRepository _preferencesRepository;

  OnBoardingBloc(
    this._preferencesRepository,
    this._userRepository,
  ) : super(OnBoardingInitial()) {
    on<OnBoardedPreferencesDataRequested>(_onOnBoardedPreferencesDataRequested);
    on<OnBoardedFinishRequested>(_onBoardedFinishRequested);
  }

  void _onOnBoardedPreferencesDataRequested(
      OnBoardedPreferencesDataRequested event,
      Emitter<OnBoardingState> emit) async {
    emit(OnBoardingLoading());
    try {
      final recreations = await _preferencesRepository.getRecreations().then(
          (results) => results
              .map((data) => PreferenceItemModel.fromJson(data.toJson()))
              .toList());
      final diets = await _preferencesRepository.getDiets().then((results) =>
          results
              .map((data) => PreferenceItemModel.fromJson(data.toJson()))
              .toList());
      final cuisines = await _preferencesRepository.getCuisines().then(
          (results) => results
              .map((data) => PreferenceItemModel.fromJson(data.toJson()))
              .toList());
      final foodAllergies = await _preferencesRepository
          .getFoodAllergies()
          .then((results) => results
              .map((data) => PreferenceItemModel.fromJson(data.toJson()))
              .toList());

      emit(OnBoardingSuccess(
        recreations: recreations,
        diets: diets,
        cuisines: cuisines,
        foodAllergies: foodAllergies,
      ));
    } catch (err) {
      emit(OnBoardingFailure(err.toString()));
    }
  }

  void _onBoardedFinishRequested(
      OnBoardedFinishRequested event, Emitter<OnBoardingState> emit) {
    final userRecreations = event.userRecreations;
    final userDiets = event.userDiets;
    final userCuisines = event.userCuisines;
    final userFoodAllergies = event.userFoodAllergies;

    // TODO - update on boarding
  }
}
