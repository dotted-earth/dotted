import 'package:dotted/app.dart';
import 'package:dotted/utils/constants/env.dart';
import 'package:dotted/bloc/auth/auth_bloc.dart';
import 'package:dotted/utils/constants/routes.dart';
import 'package:dotted/utils/constants/supabase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_config/flutter_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterConfig.loadEnvVariables();
  await Supabase.initialize(
    url: Env.supabaseURL,
    anonKey: Env.supabaseAnon,
  );

  Future<String> getInitialRoute() async {
    if (supabase.auth.currentUser != null) {
      final userProfile = await supabase
          .from("profiles")
          .select("has_on_boarded")
          .eq("id", supabase.auth.currentUser!.id)
          .single();
      if (userProfile['has_on_boarded']) {
        return routes.home;
      } else {
        return routes.onboarding;
      }
    }

    return routes.login;
  }

  final initialRoute = await getInitialRoute();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthBloc()),
      ],
      child: App(initialRoute: initialRoute),
    ),
  );
}
