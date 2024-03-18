import 'package:flutter/material.dart';
import 'package:touchdown/constants/routes.dart';
import 'package:touchdown/constants/supabase.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  List<bool> switchesOn = [false, false];

  void handleSignOut() async {
    try {
      await supabase.auth.signOut().then((_) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          routes.login,
          (route) => false,
        );
      });
    } catch (err) {}
  }

  @override
  Widget build(BuildContext context) {
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
              onPressed: handleSignOut,
            ),
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
              onPressed: () {},
              child: const Text("Delete Account"),
            ),
          ],
        )
      ]),
    );
  }
}
