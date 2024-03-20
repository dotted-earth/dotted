import 'package:dotted/app.dart';
import 'package:dotted/env/env.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: Env.supabaseURL,
    anonKey: Env.supabaseAnon,
  );

  runApp(const App());
}
