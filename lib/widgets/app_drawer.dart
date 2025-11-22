import 'package:flutter/material.dart';
import '../screens/profile_screen.dart';
import '../screens/deals_screen.dart';
import '../screens/cart_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(accountName: Text('User'), accountEmail: Text('user@example.com')),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () => Navigator.of(context).pop(),
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart),
              title: const Text('Cart'),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CartScreen())),
            ),
            ListTile(
              leading: const Icon(Icons.local_offer),
              title: const Text('Deals'),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DealsScreen())),
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileScreen())),
            ),
          ],
        ),
      ),
    );
  }
}
