import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cart_item.dart';
import 'cart_provider.dart';
import 'cart_screen.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  final List<Map<String, dynamic>> products = const [
    {'id': '1', 'name': 'Laptop', 'price': 999.99},
    {'id': '2', 'name': 'Phone', 'price': 699.99},
    {'id': '3', 'name': 'Headphones', 'price': 199.99},
    {'id': '4', 'name': 'Mouse', 'price': 29.99},
    {'id': '5', 'name': 'Keyboard', 'price': 79.99},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartScreen(),
                    ),
                  );
                },
              ),
              Consumer<CartProvider>(
                builder: (context, cart, child) {
                  return cart.itemCount > 0
                      ? Positioned(
                          right: 8,
                          top: 8,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              '${cart.itemCount}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        )
                      : Container();
                },
              ),
            ],
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              leading: const Icon(Icons.shopping_bag, size: 40),
              title: Text(product['name']),
              subtitle: Text('\$${product['price']}'),
              trailing: ElevatedButton(
                onPressed: () {
                  final cart = Provider.of<CartProvider>(context, listen: false);
                  cart.addItem(
                    CartItem(
                      id: product['id'],
                      name: product['name'],
                      price: product['price'],
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${product['name']} added to cart'),
                      duration: const Duration(seconds: 1),
                    ),
                  );
                },
                child: const Text('Add'),
              ),
            ),
          );
        },
      ),
    );
  }
}