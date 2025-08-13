import 'package:flutter/material.dart';
import 'pages/home/home_page.dart';
import 'pages/messages/messages_page.dart';
import 'pages/profile/profile_page.dart';
import 'pages/categories/all_categories_page.dart';
import 'widgets/bottom_nav_item.dart';
import 'data/dummy_data.dart';

class AppShell extends StatefulWidget {
  const AppShell({Key? key}) : super(key: key);

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _currentIndex = 0;

  late final Map<String, List<Map<String, dynamic>>> categoryData;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    categoryData = {
      "Mobiles": mobilesList,
      "Bikes": bikesList,
      "Properties": propertiesList,
    };

    _pages = [
      const HomePage(),
      AllCategoriesPage(), 
      MessagesPage(),
      const ProfilePage(),
    ];
  }

  void _onTabSelected(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            BottomNavItem(
              icon: Icons.home,
              label: "Home",
              isActive: _currentIndex == 0,
              onTap: () => _onTabSelected(0),
            ),
            BottomNavItem(
              icon: Icons.category,
              label: "Categories",
              isActive: _currentIndex == 1,
              onTap: () => _onTabSelected(1),
              categoryData: categoryData,
            ),
            BottomNavItem(
              icon: Icons.chat,
              label: "Messages",
              isActive: _currentIndex == 2,
              onTap: () => _onTabSelected(2),
            ),
            BottomNavItem(
              icon: Icons.person,
              label: "Profile",
              isActive: _currentIndex == 3,
              onTap: () => _onTabSelected(3),
            ),
          ],
        ),
      ),
    );
  }
}
