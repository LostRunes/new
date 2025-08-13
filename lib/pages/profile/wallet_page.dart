import 'package:flutter/material.dart';

class WalletPage extends StatelessWidget {
  const WalletPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My Wallet"),
        backgroundColor: Colors.blue,
      ),
      body: const Center(
        child: Text(
          "Your earnings will appear here.",
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
