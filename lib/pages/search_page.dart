import 'package:flutter/material.dart';
import '../../widgets/product_card.dart';
import 'product/product_detail_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> searchResults = [];

  void _performSearch(String query) {
    final allProducts = [
      {
        'title': 'iPhone 13',
        'price': 999.99,
        'image': 'https://dummyjson.com/image/i/products/1/1.jpg',
      },
      {
        'title': 'MacBook Pro',
        'price': 1999.99,
        'image': 'https://dummyjson.com/image/i/products/6/1.png',
      },
    ];

    setState(() {
      searchResults = allProducts.where((p) {
        final title = p['title']?.toString().toLowerCase() ?? '';
        return title.contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search products...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () => _performSearch(_searchController.text),
                ),
              ),
              onSubmitted: _performSearch,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: searchResults.isEmpty
                  ? const Center(child: Text('No results'))
                  : ListView.builder(
                      itemCount: searchResults.length,
                      itemBuilder: (context, index) {
                        final product = searchResults[index];
                        return ProductCard(
  title: product['title'],
  price: "\$${product['price']}", 
  imageUrl: product['thumbnail'],
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    ProductDetailPage(product: product),
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
