import 'package:flutter/material.dart';
import '../messages/chat_page.dart';

class MessagesPage extends StatelessWidget {
  const MessagesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Messages")),
      body: ListView(
        children: [
          ListTile(
            leading: const CircleAvatar(
              backgroundImage: NetworkImage(
                "https://i.pravatar.cc/150?img=3", // Bot avatar placeholder
              ),
            ),
            title: const Text("AI Bot"),
            subtitle: const Text("Your AI assistant"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const ChatPage(
                    name: "AI Bot",
                    avatar: "https://i.pravatar.cc/150?img=3",
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
