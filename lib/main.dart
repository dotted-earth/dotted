import 'package:dotted/env/env.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:dotted/constants/routes.dart';
import 'package:dotted/constants/supabase.dart';
import 'package:dotted/pages/home_page.dart';
import 'package:dotted/pages/login_page.dart';
import 'package:dotted/pages/onboarding_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: Env.supabaseURL,
    anonKey: Env.supabaseAnon,
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Dotted",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
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
