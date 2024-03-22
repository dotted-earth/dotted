import 'package:dotted/features/login/bloc/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dotted/constants/routes.dart';
import 'package:lottie/lottie.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          Navigator.pushNamedAndRemoveUntil(
              context, routes.onboarding, (_) => false);
        }
        if (state is LoginFailure) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(title: Text(state.error)),
          );
        }
      },
      builder: (context, state) {
        final loginBloc = context.read<LoginBloc>();
        final isLoading = state is LoginLoading && state.isLoading;

        return Scaffold(
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Dotted",
                  style: TextStyle(fontSize: 48),
                ),
                Lottie.asset(
                  "assets/lottie/circle_and_arcs.json",
                ),
                const SizedBox(
                  height: 12,
                ),
                ElevatedButton.icon(
                  onPressed: isLoading
                      ? null
                      : () {
                          loginBloc.add(const LoginWithGoogleRequest());
                        },
                  label: const Text("Sign-in with Google"),
                  icon: isLoading
                      ? const CircularProgressIndicator.adaptive()
                      : const Icon(Icons.login),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
