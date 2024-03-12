import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:touchdown/constants/routes.dart';
import 'package:touchdown/main.dart';

class ApplicationToolbar extends StatefulWidget implements PreferredSizeWidget {
  const ApplicationToolbar({super.key});

  @override
  State<ApplicationToolbar> createState() => _ApplicationToolbarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _ApplicationToolbarState extends State<ApplicationToolbar> {
  @override
  void initState() {
    super.initState();
    supabase.auth.onAuthStateChange.listen((data) async {
      if (data.event == AuthChangeEvent.signedOut) {
        try {
          if (mounted) {
            await Navigator.pushNamedAndRemoveUntil(
                context, routes.login, (_) => false);
          }
        } catch (err) {
          print(err);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: const Text(
          "Touchdown",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        actions: [
          PopupMenuButton(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  value: 0,
                  child: Row(
                    children: [
                      Text(
                        "Sign Out",
                      ),
                      Icon(Icons.logout)
                    ],
                  ),
                ),
              ];
            },
            onSelected: (value) async {
              if (value == 0) {
                try {
                  await supabase.auth.signOut();
                } catch (err) {
                  print(err);
                }
              }
            },
          )
        ]);
  }
}
