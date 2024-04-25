import 'package:dotted/bloc/on_boarding/on_boarding_bloc.dart';
import 'package:dotted/models/on_boarding_page_model.dart';
import 'package:dotted/models/preference_item_model.dart';
import 'package:dotted/widgets/on_boarding_page_presenter.dart';
import 'package:dotted/utils/constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final Set<PreferenceItemModel> _userRecreations = {};
  final Set<PreferenceItemModel> _userDiets = {};
  final Set<PreferenceItemModel> _userCuisines = {};
  final Set<PreferenceItemModel> _userFoodAllergies = {};

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() {
    context.read<OnBoardingBloc>().add(OnBoardedPreferencesDataRequested());
  }

  void _toggleUserRecreation(PreferenceItemModel item) {
    if (_userRecreations.contains(item)) {
      _userRecreations.remove(item);
    } else {
      _userRecreations.add(item);
    }
    setState(() {});
  }

  void _toggleUserDiet(PreferenceItemModel item) {
    if (_userDiets.contains(item)) {
      _userDiets.remove(item);
    } else {
      _userDiets.add(item);
    }
    setState(() {});
  }

  void _toggleUserCuisine(PreferenceItemModel item) {
    if (_userCuisines.contains(item)) {
      _userCuisines.remove(item);
    } else {
      _userCuisines.add(item);
    }
    setState(() {});
  }

  void _toggleUserFoodAllergies(PreferenceItemModel item) {
    if (_userFoodAllergies.contains(item)) {
      _userFoodAllergies.remove(item);
    } else {
      _userFoodAllergies.add(item);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<OnBoardingBloc, OnBoardingState>(
        listener: (context, state) {
          if (state is OnBoardedFinished) {
            Navigator.pushNamedAndRemoveUntil(
                context, routes.home, (_) => false);
          }
          if (state is OnBoardingFailure) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
            fetchData();
          }
        },
        builder: (context, state) {
          if (state is OnBoardingLoading) {
            return const Scaffold(
                body: Center(
              child: CircularProgressIndicator(),
            ));
          }

          List<PreferenceItemModel> recreations = [];
          List<PreferenceItemModel> diets = [];
          List<PreferenceItemModel> cuisines = [];
          List<PreferenceItemModel> foodAllergies = [];

          if (state is OnBoardingSuccess) {
            recreations = state.recreations;
            diets = state.diets;
            cuisines = state.cuisines;
            foodAllergies = state.foodAllergies;
          }

          return OnBoardingPagePresenter(
              onFinish: () {
                context.read<OnBoardingBloc>().add(OnBoardedFinishRequested(
                      userRecreations: _userRecreations.toList(),
                      userDiets: _userDiets.toList(),
                      userCuisines: _userCuisines.toList(),
                      userFoodAllergies: _userFoodAllergies.toList(),
                    ));
              },
              pages: [
                OnBoardingPageModel(
                  title: 'Welcome to Dotted!',
                  description:
                      "Before we can begin, we have to get your travel preferences in order to serve you",
                  imageUrl: 'https://i.ibb.co/cJqsPSB/scooter.png',
                  preferences: [],
                  selectedPreferences: {},
                  onPreferenceSelected: (_) {},
                ),
                OnBoardingPageModel(
                  title: 'Recreations',
                  description: 'What kind of activities do you like?',
                  imageUrl:
                      'https://cdn-icons-png.freepik.com/512/962/962431.png',
                  preferences: recreations,
                  selectedPreferences: _userRecreations,
                  onPreferenceSelected: _toggleUserRecreation,
                ),
                OnBoardingPageModel(
                  title: 'Diets',
                  description: 'What is your general diet?',
                  imageUrl:
                      'https://cdn-icons-png.freepik.com/512/3775/3775187.png',
                  preferences: diets,
                  selectedPreferences: _userDiets,
                  onPreferenceSelected: _toggleUserDiet,
                ),
                OnBoardingPageModel(
                  title: 'Cuisines',
                  description: 'What kind of foods do you like?',
                  imageUrl:
                      'https://cdn-icons-png.freepik.com/512/11040/11040884.png',
                  preferences: cuisines,
                  selectedPreferences: _userCuisines,
                  onPreferenceSelected: _toggleUserCuisine,
                ),
                OnBoardingPageModel(
                  title: 'Food Allergies',
                  description: 'Do you have any food allergies?',
                  imageUrl:
                      'https://cdn-icons-png.freepik.com/512/5282/5282049.png',
                  preferences: foodAllergies,
                  selectedPreferences: _userFoodAllergies,
                  onPreferenceSelected: _toggleUserFoodAllergies,
                ),
              ]);
        },
      ),
    );
  }
}
