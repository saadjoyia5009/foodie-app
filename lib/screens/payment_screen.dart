import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/dummy_payments.dart';
import '../providers/cart_provider.dart';
import '../providers/order_provider.dart';
import 'order_tracking_screen.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? selectedId;

  void _confirmPayment() {
    final cart = Provider.of<CartProvider>(context, listen: false);
    final orderProv = Provider.of<OrderProvider>(context, listen: false);

    if (cart.items.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cart is empty. Please add some items.')),
      );
      return;
    }

    if (selectedId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a payment method.')),
      );
      return;
    }

    final selected = paymentMethods.firstWhere((p) => p.id == selectedId);


    orderProv.placeOrder(cart.items, cart.totalPrice, selected);
    cart.clearCart();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Payment successful with ${selected.name}!')),
    );

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const OrderTrackingScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payment')),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: paymentMethods.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (ctx, i) {
                final p = paymentMethods[i];
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                  leading: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.grey[100],
                    backgroundImage: NetworkImage(p.iconUrl),
                    onBackgroundImageError: (_, __) {},
                    child: p.iconUrl.isEmpty ? const Icon(Icons.payment, color: Colors.deepOrange) : null,
                  ),
                  title: Text(
                    p.name,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  trailing: Radio<String>(
                    value: p.id,
                    groupValue: selectedId,
                    activeColor: Colors.deepOrange,
                    onChanged: (v) => setState(() => selectedId = v),
                  ),
                  onTap: () => setState(() => selectedId = p.id),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            color: Colors.white,
            child: SafeArea(
              child: ElevatedButton(
                onPressed: _confirmPayment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepOrange,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text(
                  'Confirm Payment',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
