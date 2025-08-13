import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../widgets/category_tile.dart';
import '../../widgets/product_card.dart';


import '../categories/category_page.dart';


import '../product/product_detail_page.dart';


import '../add_listing_page.dart';
import '../search_page.dart';
import '../notifications_page.dart';
import '../location_picker_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  final Map<String, List<Map<String, dynamic>>> _categoryProducts = {};
  bool _loading = true;

  
  final List<Map<String, String>> _categories = const [
    {"title": "smartphones", "imagePath": "assets/images/mobiles.png"},
    {"title": "laptops", "imagePath": "assets/images/electronics.png"},
    {"title": "fragrances", "imagePath": "assets/images/fashion.png"},
    {"title": "groceries", "imagePath": "assets/images/home.png"},
    {"title": "home-decoration", "imagePath": "assets/images/home_decor.png"},
    {"title": "skincare", "imagePath": "assets/images/skincare.png"},
  ];

  @override
  void initState() {
    super.initState();
    _fetchAll();
  }

  Future<void> _fetchAll() async {
    try {
      for (final cat in _categories) {
        final slug = cat['title']!;
        final url = Uri.parse('https://dummyjson.com/products/category/$slug');
        final res = await http.get(url);
        if (res.statusCode == 200) {
          final body = json.decode(res.body);
          final List products = body['products'] ?? [];

          
          final mapped = products.map<Map<String, dynamic>>((p) {
            return {
              'id': p['id'],
              'name': p['title'],
              'price': p['price'],
              'image': p['thumbnail'],
              'description': p['description'],
            };
          }).toList();

          _categoryProducts[slug] = mapped;
        } else {
          _categoryProducts[slug] = [];
        }
      }
    } catch (_) {
     
      for (final cat in _categories) {
        _categoryProducts[cat['title']!] = [];
      }
    }

    if (mounted) {
      setState(() => _loading = false);
    }
  }

  Widget _buildSection(String title, List<Map<String, dynamic>> items) {
    if (items.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              TextButton(
                onPressed: () {
                  
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CategoryPage(
                        title: title,
                        products: items,
                      ),
                    ),
                  );
                },
                child: const Text("See all"),
              ),
            ],
          ),
        ),

       
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final product = items[index];
              return Padding(
                padding: const EdgeInsets.only(right: 12),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductDetailPage(product: product),
                      ),
                    );
                  },
                  
                  child: ProductCard(
  title: product['name'] ?? '',
  price: "\$${product['price']}",
  imageUrl: product['image'] ?? '',
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProductDetailPage(product: product),
      ),
    );
  },
),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
          
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 8),
              child: Image.asset(
                "assets/images/alexo_logo.png",
                height: 28,
                errorBuilder: (_, __, ___) => const Icon(Icons.storefront),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const LocationPickerPage()),
                );
              },
              child: Row(
                children: const [
                  Icon(Icons.location_on, color: Color.fromARGB(255, 141, 125, 151)),
                  SizedBox(width: 4),
                  Text("Select Location"),
                  Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const SearchPage()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NotificationsPage()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_balance_wallet),
            onPressed: () {
             
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Wallet: balance ')),
              );
            },
          ),
        ],
      ),

      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: DropdownButtonFormField<String>(
                      decoration: const InputDecoration(
                        labelText: "Accessories",
                        border: OutlineInputBorder(),
                      ),
                      items: const [
                        DropdownMenuItem(value: "All", child: Text("All")),
                        DropdownMenuItem(
                            value: "Popular", child: Text("Popular")),
                        DropdownMenuItem(
                            value: "Latest", child: Text("Latest")),
                      ],
                      value: "All",
                      onChanged: (_) {},
                    ),
                  ),

                  
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      "Browse Categories",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                    height: 110,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _categories.length,
                      itemBuilder: (context, index) {
                        final cat = _categories[index];
                        final title = cat['title']!;
                        final imagePath = cat['imagePath']!;

                        return Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: CategoryTile(
                            title: _prettyTitle(title),
                            imagePath: imagePath,
                            onTap: () {
                              final items =
                                  _categoryProducts[title] ?? const [];
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => CategoryPage(
                                    title: _prettyTitle(title),
                                    products: items,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),

                  
                  ..._categories.map((cat) {
                    final key = cat['title']!;
                    final items = _categoryProducts[key] ?? const [];
                    return _buildSection(_prettyTitle(key), items);
                  }).toList(),
                ],
              ),
            ),

      
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const AddListingPage()));
        },
        child: const Icon(Icons.add, size: 32),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          // children: [
          //   IconButton(onPressed: () {}, icon: const Icon(Icons.home)),
          //   IconButton(onPressed: () {}, icon: const Icon(Icons.grid_view)),
          //   const SizedBox(width: 40), 
          //   IconButton(onPressed: () {}, icon: const Icon(Icons.message)),
          //   IconButton(onPressed: () {}, icon: const Icon(Icons.person)),
          //],
        ),
      ),
    );
  }

  String _prettyTitle(String slug) {
    
    return slug
        .split('-')
        .map((s) => s.isEmpty ? s : '${s[0].toUpperCase()}${s.substring(1)}')
        .join(' ');
  }
}
