import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notifications = [
      {"title": "New message from John", "time": "2m ago"},
      {"title": "Your listing has a new offer", "time": "1h ago"},
      {"title": "Price drop alert for iPhone 14", "time": "Yesterday"},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Notifications")),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notif = notifications[index];
          return ListTile(
            leading: const Icon(Icons.notifications),
            title: Text(notif["title"]!),
            subtitle: Text(notif["time"]!),
            onTap: () {
             
            },
          );
        },
      ),
    );
  }
}
