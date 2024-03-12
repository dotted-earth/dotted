import 'package:flutter/material.dart';
import 'package:touchdown/ui/ApplicationToolbar.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: ApplicationToolbar(),
      body: Center(
        child: Column(
          children: [Text("Onboarding Page")],
        ),
      ),
    );
  }
}
