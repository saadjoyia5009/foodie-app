import 'package:flutter/material.dart';
import '../data/dummy_categories.dart';
import '../data/dummy_foods.dart';
import '../widgets/category_card.dart';
import '../widgets/food_card.dart';
import 'category_screen.dart';
import 'cart_screen.dart';
import 'deals_screen.dart';
import 'profile_screen.dart';
import '../widgets/bottom_nav_bar.dart';
import '../models/food.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  final _pages = const [null, CartScreen(), DealsScreen(), ProfileScreen()];

  final TextEditingController _searchController = TextEditingController();
  List<Food> filteredFoods = dummyFoods;

  void _onBottomTap(int idx) {
    if (idx == 0) {
      setState(() => _selectedIndex = 0);
    } else {
      final page = _pages[idx];
      if (page != null) {
        Navigator.push(context, MaterialPageRoute(builder: (_) => page));
      }
    }
  }

  void _searchFood(String query) {
    final results = dummyFoods.where((f) {
      final name = f.name.toLowerCase();
      return name.contains(query.toLowerCase());
    }).toList();
    setState(() {
      filteredFoods = results;
    });
  }

  @override
  Widget build(BuildContext context) {

    final List<Food> nonDrinkFoods = dummyFoods.where((f) => f.category.toLowerCase() != 'drinks').toList();


    final List<Food> popularFoods = <Food>[];
    for (var category in dummyCategories) {
      if (category.name.toLowerCase() == 'drinks') continue;
      final matches = nonDrinkFoods.where((f) => f.category == category.name).toList();
      if (matches.isNotEmpty) {
        popularFoods.add(matches.first);
      }
    }


    final List<Food> recommendedFoods = <Food>[];
    for (var category in dummyCategories) {
      if (category.name.toLowerCase() == 'drinks') continue;
      final remaining = nonDrinkFoods.where((f) => f.category == category.name && !popularFoods.contains(f)).toList();
      if (remaining.isNotEmpty) {
        recommendedFoods.add(remaining.first);
      }
    }

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black87,
        title: const Text(
          "Food Delivery",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.local_offer_outlined, color: Colors.deepOrange),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const DealsScreen()),
            ),
          ),
        ],
      ),
      drawer: const Drawer(child: ProfileScreen()),

      body: SafeArea(

        child: SingleChildScrollView(

          padding: const EdgeInsets.all(16),

          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Welcome Back,", style: TextStyle(fontSize: 16, color: Colors.grey)),
                      SizedBox(height: 10,),
                      Text("Find Your Favorite Food 🍔",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.deepOrange.shade100,
                    child: const Icon(Icons.person, color: Colors.deepOrange),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              TextField(
                controller: _searchController,
                onChanged: _searchFood,
                decoration: InputDecoration(
                  hintText: "Search your meal...",
                  prefixIcon: const Icon(Icons.search, color: Colors.deepOrange),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              if (_searchController.text.isEmpty) ...[
                const Text("Categories",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                SizedBox(
                  height: 110,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: dummyCategories.length,
                    itemBuilder: (ctx, i) {
                      final c = dummyCategories[i];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => CategoryScreen(category: c.name)),
                          );
                        },
                        child: CategoryCard(category: c),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Popular",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    TextButton(
                      onPressed: () {},
                      child: const Text("See All", style: TextStyle(color: Colors.deepOrange)),
                    ),
                  ],
                ),
                SizedBox(
                  height: 280,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: popularFoods.length,
                    itemBuilder: (ctx, i) {
                      final f = popularFoods[i];
                      return Container(
                        width: 200,
                        margin: const EdgeInsets.only(right: 14),
                        child: FoodCard(food: f),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),

                const Text("Recommended for You",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: recommendedFoods.length,
                  itemBuilder: (ctx, i) {
                    final f = recommendedFoods[i];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: FoodCard(food: f),
                    );
                  },
                ),
              ],


              if (_searchController.text.isNotEmpty) ...[
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredFoods.length > 5 ? 5 : filteredFoods.length,
                  itemBuilder: (ctx, i) {
                    final f = filteredFoods[i];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: FoodCard(food: f),
                    );
                  },
                ),
              ],
            ],
          ),
        ),
      ),

      bottomNavigationBar: BottomNavBar(onTap: _onBottomTap),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        child: const Icon(Icons.shopping_cart),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const CartScreen()),
        ),
      ),
    );
  }
}