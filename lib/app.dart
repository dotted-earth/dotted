import 'package:dotted/utils/constants/routes.dart';
import 'package:dotted/screens/login_page.dart';
import 'package:dotted/bloc/on_boarding/on_boarding_bloc.dart';
import 'package:dotted/screens/on_boarding_page.dart';
import 'package:dotted/providers/preferences_provider.dart';
import 'package:dotted/providers/user_provider.dart';
import 'package:dotted/repositories/preferences_repository.dart';
import 'package:dotted/repositories/user_repository.dart';
import 'package:dotted/screens/home_page.dart';
import 'package:dotted/utils/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatelessWidget {
  const App({super.key, required this.initialRoute});
  final String initialRoute;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Dotted",
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      initialRoute: initialRoute,
      routes: {
        routes.login: (context) => const LoginPage(),
        routes.home: (context) => const HomePage(),
        routes.onboarding: (context) => MultiRepositoryProvider(
              providers: [
                RepositoryProvider<PreferencesRepository>(
                  create: (context) => PreferencesRepository(
                    PreferencesProvider(),
                  ),
                ),
                RepositoryProvider<UserRepository>(
                  create: (context) => UserRepository(
                    UserProvider(),
                  ),
                )
              ],
              child: BlocProvider(
                create: (context) => OnBoardingBloc(
                  context.read<PreferencesRepository>(),
                  context.read<UserRepository>(),
                ),
                child: const OnBoardingPage(),
              ),
            ),
      },
    );
  }
}
