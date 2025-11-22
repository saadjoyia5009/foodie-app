import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/order_provider.dart';
import 'home_screen.dart';

class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderProv = Provider.of<OrderProvider>(context);
    final order = orderProv.latestOrder;

    if (order == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Track Order')),
        body: const Center(child: Text('No recent order')),
      );
    }

    final statuses = ['Preparing', 'On the way', 'Delivered'];
    final currentIndex = statuses.indexOf(order.status);

    return Scaffold(
      appBar: AppBar(title: const Text('Track Order')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text('Order ID: ${order.id}', style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Text('Payment: ${order.payment.name}'),
            const SizedBox(height: 8),
            Text('Total: Rs ${order.total.toStringAsFixed(0)}'),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: statuses.length,
                itemBuilder: (ctx, i) {
                  final done = i <= currentIndex;
                  return ListTile(
                    leading: Icon(
                      done ? Icons.check_circle : Icons.timelapse,
                      color: done ? Colors.green : Colors.grey,
                    ),
                    title: Text(statuses[i]),
                    subtitle: done ? const Text('Completed') : null,
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const HomeScreen()),
                      (route) => false, // removes all previous routes
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text(
                'Done',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
