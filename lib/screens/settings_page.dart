import 'package:dotted/bloc/auth/auth_bloc.dart';
import 'package:dotted/utils/constants/supabase.dart';
import 'package:flutter/material.dart';
import 'package:dotted/utils/constants/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  List<bool> switchesOn = [false, false];

  void _onDeleteAccount() async {
    final bool isDelete = await showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            padding: const EdgeInsets.all(24),
            height: 200,
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                    "This action will delete your account and data. This action is irreversible."),
                const SizedBox(
                  height: 16,
                ),
                const Text("Are you sure you want to delete your account?"),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: const Text("Cancel")),
                    const SizedBox(
                      width: 24,
                    ),
                    FilledButton(
                        onPressed: () {
                          Navigator.of(context).pop(true);
                        },
                        child: const Text("Yes, I'm sure"))
                  ],
                )
              ],
            ),
          );
        });

    if (isDelete) {
      try {
        await supabase
            .from("profiles")
            .delete()
            .match({'id': supabase.auth.currentUser!.id});
        await supabase.rpc("delete_user");
        context.read<AuthBloc>().add(const AuthLogOutRequested());
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthInitial) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            routes.login,
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        if (state is AuthLoading && state.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Scaffold(
          appBar: AppBar(title: const Text("Settings")),
          body: ListView(children: [
            ListTile(
              title: const Text("Push Notifications"),
              trailing: Switch(
                value: switchesOn[0],
                onChanged: (value) {
                  setState(() {
                    switchesOn[0] = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text("Email Notifications"),
              trailing: Switch(
                value: switchesOn[1],
                onChanged: (value) {
                  setState(() {
                    switchesOn[1] = value;
                  });
                },
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.logout),
                  label: const Text("Sign out"),
                  onPressed: () {
                    context.read<AuthBloc>().add(const AuthLogOutRequested());
                  },
                )
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              "Danger Zone",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.red.shade700,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: _onDeleteAccount,
                  child: const Text("Delete Account"),
                ),
              ],
            )
          ]),
        );
      },
    );
  }
}
