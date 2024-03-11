import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: "https://mpombjrojblraufobsoo.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im1wb21ianJvamJscmF1Zm9ic29vIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTAwNzcxODgsImV4cCI6MjAyNTY1MzE4OH0.DrOfh4Q5SzvhZH35fie7vgeUwb3kC8rSQJEZwpMNdXg",
  );

  runApp(const MainApp());
}

final supabase = Supabase.instance.client;

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? _userId;

  @override
  void initState() {
    super.initState();
    supabase.auth.onAuthStateChange.listen((data) {
      setState(() {
        _userId = data.session?.user.id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_userId ?? 'Not signed in'),
            SizedBox(
              height: 12,
            ),
            ElevatedButton(
                onPressed: () async {
                  /// Web Client ID that you registered with Google Cloud.
                  const webClientId =
                      '351644549750-u10n35gkg77igip6n4dk7r44vcba2s6q.apps.googleusercontent.com';

                  /// iOS Client ID that you registered with Google Cloud.
                  const iosClientId =
                      '351644549750-h1t54of515hibhp53q9f5iheurcjhpao.apps.googleusercontent.com';

                  // Google sign in on Android will work without providing the Android
                  // Client ID registered on Google Cloud.

                  final GoogleSignIn googleSignIn = GoogleSignIn(
                    clientId: iosClientId,
                    serverClientId: webClientId,
                  );
                  final googleUser = await googleSignIn.signIn();
                  final googleAuth = await googleUser!.authentication;
                  final accessToken = googleAuth.accessToken;
                  final idToken = googleAuth.idToken;

                  if (accessToken == null) {
                    throw 'No Access Token found.';
                  }
                  if (idToken == null) {
                    throw 'No ID Token found.';
                  }

                  await supabase.auth.signInWithIdToken(
                    provider: OAuthProvider.google,
                    idToken: idToken,
                    accessToken: accessToken,
                  );
                },
                child: const Text("Sign-in with Google"))
          ],
        ),
      ),
    );
  }
}
