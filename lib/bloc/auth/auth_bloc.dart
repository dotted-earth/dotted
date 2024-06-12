import 'dart:convert';
import 'dart:io';
import 'package:dotted/models/user_profile_model.dart';
import 'package:dotted/utils/constants/routes.dart';
import 'package:dotted/utils/constants/supabase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import "package:crypto/crypto.dart";

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial(isLoading: false)) {
    on<AuthLoginWithGoogleRequested>(_onAuthWithGoogleRequest);
    on<AuthLoginWithAppleRequested>(_onAuthWithAppleRequest);
    on<AuthLogOutRequested>(_onAuthSignOutRequest);
    on<AuthLoginFromSession>(_onAuthLoginFromSession);
  }

  Future<void> _goToOnboardOrHomepage(
      User user, Emitter<AuthState> emit) async {
    var userProfile = await supabase
        .from("profiles")
        .select('*')
        .eq("id", user.id)
        .maybeSingle()
        .then(
          (result) => result == null ? null : UserProfileModel.fromMap(result),
        );

    if (userProfile != null) {
      emit(
        AuthSuccess(
          user: userProfile,
          navigateToPage:
              userProfile.hasOnBoarded ? routes.home : routes.onboarding,
          isLoading: false,
        ),
      );
      return;
    }

    final newUserProfile = UserProfileModel(
      id: user.id,
      hasOnBoarded: false,
      isEmailVerified: user.userMetadata?['email_verified'] ?? false,
      fullName: user.userMetadata?['full_name'] ?? '',
      username: user.userMetadata?['name'] ?? '',
      avatarUrl: user.userMetadata?['avatar_url'] ?? '',
    );

    try {
      final res = await supabase.from("profiles").insert({
        'id': newUserProfile.id,
        'username': newUserProfile.username,
        'full_name': newUserProfile.fullName,
        'avatar_url': newUserProfile.avatarUrl,
        'is_email_verified': newUserProfile.isEmailVerified,
        'has_on_boarded': newUserProfile.hasOnBoarded
      });

      if (res != null) {
        userProfile = UserProfileModel.fromMap(res);
      }
    } catch (e) {
      print("$e");
    }

    emit(
      AuthSuccess(
        user: userProfile,
        navigateToPage: routes.onboarding,
        isLoading: false,
      ),
    );
  }

  Future<void> _onAuthWithGoogleRequest(
      AuthLoginWithGoogleRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading(isLoading: true));

    const webClientId =
        '351644549750-u10n35gkg77igip6n4dk7r44vcba2s6q.apps.googleusercontent.com';
    const iosClientId =
        '351644549750-h1t54of515hibhp53q9f5iheurcjhpao.apps.googleusercontent.com';

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

        final authUser = await supabase.auth.signInWithIdToken(
          provider: OAuthProvider.google,
          idToken: idToken,
          accessToken: accessToken,
        );

        final user = authUser.user!;

        await _goToOnboardOrHomepage(user, emit);
      }
    } on AuthException catch (err) {
      emit(AuthFailure(error: err.message, isLoading: false));
    } catch (err) {
      emit(AuthFailure(error: err.toString(), isLoading: false));
    }
  }

  Future<void> _onAuthWithAppleRequest(
      AuthLoginWithAppleRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading(isLoading: true));
    try {
      if (Platform.isIOS) {
        final rawNonce = supabase.auth.generateRawNonce();
        final hashedNonce = sha256.convert(utf8.encode(rawNonce)).toString();

        final credential = await SignInWithApple.getAppleIDCredential(scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ], nonce: hashedNonce);

        if (credential.identityToken != null) {
          final response = await supabase.auth.signInWithIdToken(
            provider: OAuthProvider.apple,
            idToken: credential.identityToken!,
            nonce: rawNonce,
          );

          if (response.user != null) {
            await _goToOnboardOrHomepage(response.user!, emit);
          }
        }

        return;
      } else {
        await supabase.auth.signInWithOAuth(OAuthProvider.apple,
            redirectTo: "earth.dotted.app://login-callback");
      }
    } on AuthException catch (err) {
      emit(AuthFailure(error: err.message, isLoading: false));
    } catch (err) {
      emit(AuthFailure(error: err.toString(), isLoading: false));
    }
  }

  Future<void> _onAuthSignOutRequest(
      AuthLogOutRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading(isLoading: true));
    try {
      await supabase.auth.signOut();
      emit(AuthInitial(isLoading: false));
    } catch (err) {
      emit(AuthFailure(error: err.toString(), isLoading: false));
    }
    emit(AuthLoading(isLoading: false));
  }

  Future<void> _onAuthLoginFromSession(
      AuthLoginFromSession event, Emitter<AuthState> emit) async {
    await _goToOnboardOrHomepage(event.user, emit);
  }
}
