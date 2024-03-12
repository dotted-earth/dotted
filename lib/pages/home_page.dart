import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:touchdown/main.dart';
import 'package:touchdown/pages/login_page.dart';
import 'package:touchdown/ui/ApplicationToolbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    supabase.auth.onAuthStateChange.listen((data) {
      if (data.event == AuthChangeEvent.signedOut) {
        Navigator.pushNamedAndRemoveUntil(context, "/login", (_) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: ApplicationToolbar(),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () async {
                  await supabase.auth.signOut();
                },
                child: const Text("Sign out"),
              )
            ],
          ),
        ));
  }
}
