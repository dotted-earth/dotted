import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:touchdown/constants/routes.dart';
import 'package:touchdown/constants/supabase.dart';
import 'package:touchdown/pages/home_page.dart';
import 'package:touchdown/pages/login_page.dart';
import 'package:touchdown/pages/onboarding_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: "https://mpombjrojblraufobsoo.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1wb21ianJvamJscmF1Zm9ic29vIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTAwNzcxODgsImV4cCI6MjAyNTY1MzE4OH0.DrOfh4Q5SzvhZH35fie7vgeUwb3kC8rSQJEZwpMNdXg",
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
