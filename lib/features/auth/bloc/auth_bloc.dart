import 'package:bloc/bloc.dart';
import 'package:dotted/constants/supabase.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginWithGoogleRequest>((event, emit) async {
      emit(AuthLoading(true));

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

      try {
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

          emit(AuthSuccess());
        }
      } catch (err) {
        emit(AuthFailure(err.toString()));
      }

      emit(AuthLoading(false));
    });
  }
}
