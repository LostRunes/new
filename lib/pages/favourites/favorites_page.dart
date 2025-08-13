import 'package:flutter/material.dart';
import '../../widgets/product_card.dart';
import '../product/product_detail_page.dart';

class FavoritesPage extends StatelessWidget {
  final List<Map<String, dynamic>> favoriteProducts = [
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

  FavoritesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: favoriteProducts.isEmpty
          ? const Center(child: Text('No favorites yet'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: favoriteProducts.length,
              itemBuilder: (context, index) {
                final product = favoriteProducts[index];
                return ProductCard(
                  title: product['title'],
                  price: "\$${product['price']}",
                  imageUrl: product['image'],
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
    );
  }
}
