import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AllCategoriesPage extends StatefulWidget {
  const AllCategoriesPage({Key? key}) : super(key: key);

  @override
  State<AllCategoriesPage> createState() => _AllCategoriesPageState();
}

class _AllCategoriesPageState extends State<AllCategoriesPage> {
  Map<String, List<Map<String, dynamic>>> categoryData = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCategories();
  }

  Future<void> fetchCategories() async {
    try {
      final response =
          await http.get(Uri.parse("https://fakestoreapi.com/products"));
      if (response.statusCode == 200) {
        List products = json.decode(response.body);

        Map<String, List<Map<String, dynamic>>> groupedData = {};
        for (var product in products) {
          String category = product["category"] ?? "Others";
          groupedData.putIfAbsent(category, () => []);
          groupedData[category]!.add({
            "name": product["title"] ?? "",
            "price": product["price"] ?? 0,
            "image": product["image"] ?? "https://via.placeholder.com/150",
          });
        }

        setState(() {
          categoryData = groupedData;
          isLoading = false;
        });
      } else {
        throw Exception("Failed to load data");
      }
    } catch (e) {
      debugPrint("Error fetching categories: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("All Categories"),
      ),
      body: ListView(
        children: categoryData.entries.map((entry) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(entry.key,
                    style:
                        const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: entry.value.length,
                  itemBuilder: (context, index) {
                    final product = entry.value[index];
                    return Container(
                      width: 160,
                      margin: const EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Image.network(
                              product["image"],
                              fit: BoxFit.cover,
                              width: double.infinity,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(product["name"],
                              maxLines: 1, overflow: TextOverflow.ellipsis),
                          Text("\$${product["price"]}"),
                        ],
                      ),
                    );
                  },
                ),
              )
            ],
          );
        }).toList(),
      ),
    );
  }
}
