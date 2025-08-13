import 'package:flutter/material.dart';
import 'category_page.dart';
import '../../data/dummy_data.dart';

class CategoriesPage extends StatelessWidget {
  final List<Map<String, dynamic>> categories = [
    {"name": "Mobiles", "icon": Icons.phone_android, "products": mobilesList},
    {"name": "Bikes", "icon": Icons.pedal_bike, "products": bikesList},
    {"name": "Properties", "icon": Icons.home, "products": propertiesList},
  ];

  CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Categories")),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final cat = categories[index];
          return ListTile(
            leading: Icon(cat["icon"], color: Colors.blue),
            title: Text(cat["name"]),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CategoryPage(
                    title: cat["name"],
                    products: cat["products"],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
