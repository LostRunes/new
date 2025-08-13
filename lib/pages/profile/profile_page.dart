import 'package:flutter/material.dart';
import 'edit_profile_page.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(
                "https://via.placeholder.com/150x150.png?text=User",
              ),
            ),
            const SizedBox(height: 16),
            const Text("user", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const Text("user@gmail"),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const EditProfilePage()),
                );
              },
              child: const Text("Edit Profile"),
            ),
          ],
        ),
      ),
    );
  }
}
