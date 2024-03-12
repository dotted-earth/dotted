import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:touchdown/main.dart';
import 'package:touchdown/ui/ApplicationToolbar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    supabase.auth.onAuthStateChange.listen((data) {
      if (data.event == AuthChangeEvent.signedIn) {
        Navigator.pushNamedAndRemoveUntil(context, "/homepage", (_) => false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const ApplicationToolbar(),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 12,
            ),
            ElevatedButton.icon(
              onPressed: () async {
                setState(() {
                  _isLoading = true;
                });

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
                if (googleUser != null) {
                  final googleAuth = await googleUser.authentication;
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
                }

                setState(() {
                  _isLoading = false;
                });
              },
              label: const Text("Sign-in with Google"),
              icon: _isLoading
                  ? const CircularProgressIndicator.adaptive()
                  : const Icon(Icons.login),
            ),
          ],
        ),
      ),
    );
  }
}
