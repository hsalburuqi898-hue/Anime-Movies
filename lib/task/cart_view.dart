
import 'package:flutter/material.dart';

class CartView extends StatelessWidget {
  final List<Map<String, dynamic>> cartItems;

  const CartView({Key? key, required this.cartItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Cart")),
      body: cartItems.isEmpty
          ? const Center(child: Text("Your cart is empty"))
          : ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final product = cartItems[index];
                
                // Handle potential null values with fallbacks
                final imageUrl = product['image'] as String? ?? '';
                final title = product['title'] as String? ?? 'Unknown Product';
                final price = product['price']?.toString() ?? '0.00';
                
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: imageUrl.isNotEmpty
                        ? Image.network(imageUrl, width: 50, height: 50, fit: BoxFit.cover)
                        : const Icon(Icons.image, size: 50),
                    title: Text(title),
                    subtitle: Text("\$$price"),
                  ),
                );
              },
            ),
    );
  }
}