import 'package:dotted/features/user/models/on_boarding_page_model.dart';
import 'package:dotted/features/user/widgets/on_boarding_page_presenter.dart';
import 'package:flutter/material.dart';
import 'package:dotted/constants/routes.dart';
import 'package:dotted/constants/supabase.dart';

class OnBoardingPage extends StatelessWidget {
  const OnBoardingPage({super.key});

  void finishOnboarding(context) async {
    try {
      await supabase
          .from("profiles")
          .update({"has_on_boarded": true})
          .eq("id", supabase.auth.currentUser!.id)
          .then((_) async => {
                await Navigator.pushNamedAndRemoveUntil(
                    context, routes.home, (_) => false)
              });
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OnBoardingPagePresenter(
          onFinish: () {
            finishOnboarding(context);
          },
          pages: [
            OnBoardingPageModel(
              title: 'Welcome to Dotted!',
              description:
                  "Before we can begin, we have to get your travel preferences in order to serve you",
              imageUrl: 'https://i.ibb.co/cJqsPSB/scooter.png',
            ),
            OnBoardingPageModel(
              title: 'Recreations',
              description: 'What kind of activities do you like?',
              imageUrl: 'https://cdn-icons-png.freepik.com/512/962/962431.png',
              dataKey: 'recreations',
            ),
            OnBoardingPageModel(
              title: 'Diets',
              description: 'What is your general diet?',
              imageUrl:
                  'https://cdn-icons-png.freepik.com/512/3775/3775187.png',
              dataKey: "diets",
            ),
            OnBoardingPageModel(
              title: 'Cuisines',
              description: 'What kind of foods do you like?',
              imageUrl:
                  'https://cdn-icons-png.freepik.com/512/11040/11040884.png',
              dataKey: "cuisines",
            ),
            OnBoardingPageModel(
              title: 'Food Allergies',
              description: 'Do you have any food allergies?',
              imageUrl:
                  'https://cdn-icons-png.freepik.com/512/5282/5282049.png',
              dataKey: "foodAllergies",
            ),
          ]),
    );
  }
}
