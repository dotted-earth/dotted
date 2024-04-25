import 'package:dotted/bloc/auth/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:icons_plus/icons_plus.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          Navigator.pushNamedAndRemoveUntil(
              context, state.navigateToPage, (_) => false);
        }
        if (state is AuthFailure) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(title: Text(state.error)),
          );
        }
      },
      builder: (context, state) {
        final loginBloc = context.read<AuthBloc>();
        final isLoading = state is AuthLoading && state.isLoading;

        return Scaffold(
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Dotted",
                  style: TextStyle(fontSize: 48),
                ),
                Transform.scale(
                  scale: 1.5,
                  child: Lottie.asset(
                    "assets/lottie/circle_and_arcs.json",
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                ElevatedButton.icon(
                  onPressed: isLoading
                      ? null
                      : () {
                          loginBloc.add(const AuthLoginWithGoogleRequested());
                        },
                  label: const Text("Sign-in with Google"),
                  icon: isLoading
                      ? const CircularProgressIndicator.adaptive()
                      : Brand(Brands.google),
                ),
                SizedBox(height: 12),
                ElevatedButton.icon(
                  onPressed: isLoading
                      ? null
                      : () {
                          loginBloc.add(const AuthLoginWithAppleRequested());
                        },
                  label: const Text("Sign-in with Apple"),
                  icon: isLoading
                      ? const CircularProgressIndicator.adaptive()
                      : Brand(Brands.apple_logo),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
