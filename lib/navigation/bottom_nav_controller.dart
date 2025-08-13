import 'package:flutter/material.dart';
import '../pages/home/home_page.dart';
import '../pages/messages/messages_page.dart';
import '../pages/profile/profile_page.dart';
import '../pages/add_listing_page.dart';
import '../pages/profile/wallet_page.dart'; 

class BottomNavController extends StatefulWidget {
  const BottomNavController({super.key});

  @override
  State<BottomNavController> createState() => _BottomNavControllerState();
}

class _BottomNavControllerState extends State<BottomNavController> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
     MessagesPage(),
    const SizedBox.shrink(), 
    const WalletPage(), 
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddListingPage()),
          );
        },
        backgroundColor: Colors.blue,
        child: const Icon(Icons.add, size: 32, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            if (index != 2) setState(() => _currentIndex = index);
          },
          type: BottomNavigationBarType.fixed,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.add, color: Colors.transparent), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.account_balance_wallet_outlined), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ""),
          ],
        ),
      ),
    );
  }
}
