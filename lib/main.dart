import 'package:flutter/material.dart';


import 'pages/home/home_page.dart';
import 'pages/location_picker_page.dart';
import 'pages/profile/profile_page.dart';
import 'pages/profile/edit_profile_page.dart';
import 'pages/search_page.dart';
import 'pages/notifications_page.dart';
import 'pages/messages/chat_thread_page.dart';
import 'pages/add_listing_page.dart';
import 'pages/settings_page.dart';
import 'pages/categories/all_categories_page.dart';
import 'pages/categories/category_page.dart';
import 'package:alexo/app_shell.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    
    final Map<String, List<Map<String, dynamic>>> categoryData = {
      "Mobiles": [
        {"name": "iPhone 14", "price": 1200, "image": "https://via.placeholder.com/150"},
        {"name": "Samsung S23", "price": 999, "image": "https://via.placeholder.com/150"},
      ],
      "Bikes": [
        {"name": "Honda 125", "price": 1500, "image": "https://via.placeholder.com/150"},
        {"name": "Yamaha YBR", "price": 1800, "image": "https://via.placeholder.com/150"},
      ],
    };

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Alexo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/' : (_) => const AppShell(),
        '/locationPicker': (_) => const LocationPickerPage(),
        '/profile': (_) => const ProfilePage(),
        '/editProfile': (_) => const EditProfilePage(),
        '/search': (_) => const SearchPage(),
        '/notifications': (_) => const NotificationsPage(),

       
        '/chatThread': (_) => const ChatThreadPage(name: "John Doe"),

        '/addListing': (_) => const AddListingPage(),
        '/settings': (_) => const SettingsPage(),

       
        '/allCategories': (_) => AllCategoriesPage(),

       
        '/category': (_) => CategoryPage(
              title: "Mobiles",
              products: categoryData["Mobiles"] ?? [],
            ),
      },
    );
  }
}
