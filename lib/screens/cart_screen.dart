import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../models/deal.dart';
import '../models/food.dart';
import 'payment_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final items = cart.items;

    return Scaffold(
      appBar: AppBar(title: const Text('Your Cart')),
      body: items.isEmpty
          ? const Center(child: Text('Cart is empty'))
          : Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (ctx, i) {
                final f = items[i];

                // Determine type and get appropriate data
                final image = f is Deal ? f.imageUrl : f.image;
                final name = f is Deal ? f.title : f.name;
                final price = f is Deal ? f.discount : f.price;

                return ListTile(
                  leading: Image.network(
                    image,
                    width: 56,
                    height: 56,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 56,
                      height: 56,
                      color: Colors.grey,
                    ),
                  ),
                  title: Text(name),
                  subtitle: Text('Rs ${price.toStringAsFixed(0)}'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => cart.removeItem(f),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    Text('Rs ${cart.totalPrice.toStringAsFixed(0)}',
                        style: const TextStyle(fontSize: 18)),
                  ],
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => const PaymentScreen()),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepOrange,
                      padding: const EdgeInsets.symmetric(vertical: 14)),
                  child: const SizedBox(
                    width: double.infinity,
                    child: Center(child: Text('Proceed to Payment')),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
