import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/dummy_deals.dart';
import '../widgets/deal_card.dart';
import '../providers/cart_provider.dart';

class DealsScreen extends StatelessWidget {
  const DealsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context, listen: false);

    void _addToCart(deal) {
      cart.addItem(deal);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("${deal.title} added to cart!"), duration: const Duration(seconds: 1)),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Today's Deals")),
      body: ListView.builder(
        itemCount: dummyDeals.length,
        itemBuilder: (ctx, i) => DealCard(
          deal: dummyDeals[i],
          onAddToCart: () => _addToCart(dummyDeals[i]),
        ),
      ),
    );
  }
}
