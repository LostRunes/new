import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Account"),
            subtitle: const Text("Manage your account details"),
            onTap: () {
              
              Navigator.pushNamed(context, '/editProfile');
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text("Notifications"),
            subtitle: const Text("Notification preferences"),
            onTap: () {
              Navigator.pushNamed(context, '/notifications');
            },
          ),
          ListTile(
            leading: const Icon(Icons.dark_mode),
            title: const Text("Dark Mode"),
            trailing: Switch(value: false, onChanged: (_) {}),
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text("Help & Support"),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
