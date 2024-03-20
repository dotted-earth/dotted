import 'package:dotted/constants/routes.dart';
import 'package:dotted/constants/supabase.dart';
import 'package:dotted/pages/home_page.dart';
import 'package:dotted/pages/login_page.dart';
import 'package:dotted/pages/onboarding_page.dart';
import 'package:dotted/utils/theme/theme.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Dotted",
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      initialRoute:
          supabase.auth.currentUser == null ? routes.login : routes.home,
      routes: {
        routes.login: (context) => const LoginPage(),
        routes.home: (context) => const HomePage(),
        routes.onboarding: (context) => const OnboardingPage(),
      },
    );
  }
}
