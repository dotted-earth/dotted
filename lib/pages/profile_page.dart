import 'package:flutter/material.dart';
import 'package:dotted/constants/supabase.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  String avatarUrl = '';

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  void fetchUserProfile() async {
    try {
      // TODO - put in global state
      final profile = await supabase
          .from("profiles")
          .select("username,full_name,avatar_url")
          .eq("id", supabase.auth.currentUser!.id)
          .single();

      userNameController.text = profile["username"] ?? "";
      fullNameController.text = profile['full_name'];
      setState(() {
        avatarUrl = profile["avatar_url"];
      });
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    const formControl = SizedBox(height: 20);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          CircleAvatar(
            backgroundColor: Colors.blue.shade200,
            radius: 60,
            child: Center(
              child: CircleAvatar(
                backgroundImage:
                    avatarUrl != '' ? NetworkImage(avatarUrl) : null,
                radius: 58,
              ),
            ),
          ),
          formControl,
          TextField(
            controller: userNameController,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), labelText: "Username"),
          ),
          formControl,
          TextField(
            controller: fullNameController,
            decoration: const InputDecoration(
                border: OutlineInputBorder(), labelText: "Name"),
          ),
          formControl,
          const Text("Travel Preferences"),
        ],
      ),
    );
  }
}
