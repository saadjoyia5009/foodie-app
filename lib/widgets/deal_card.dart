import 'package:flutter/material.dart';
import '../models/deal.dart';

class DealCard extends StatelessWidget {
  final Deal deal;
  final VoidCallback? onAddToCart; // ✅ optional callback

  const DealCard({super.key, required this.deal, this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(12),
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            deal.imageUrl,
            height: 160,
            width: double.infinity,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(height: 160, color: Colors.grey),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(deal.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 6),
                      Text(deal.description),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Text('-${deal.discount.toInt()}%', style: const TextStyle(color: Colors.deepOrange, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    if (onAddToCart != null)
                      ElevatedButton(
                        onPressed: onAddToCart,
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.deepOrange),
                        child: const Text("Add to Cart"),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
