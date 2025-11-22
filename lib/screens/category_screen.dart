import 'package:flutter/material.dart';
import '../data/dummy_foods.dart';
import '../widgets/food_card.dart';

class CategoryScreen extends StatelessWidget {
  final String category;
  const CategoryScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final items = dummyFoods.where((f) => f.category == category).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(category),
        backgroundColor: Colors.deepOrange,
      ),
      body: items.isEmpty
          ? const Center(child: Text('No items found'))
          : GridView.builder(
        padding: const EdgeInsets.all(4),
        itemCount: items.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (ctx, i) => FoodCard(food: items[i]),
      ),
    );
  }
}
