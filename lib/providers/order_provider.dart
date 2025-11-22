import 'package:flutter/material.dart';
import '../models/food.dart';
import '../models/deal.dart';
import '../models/payment_method.dart';

class Order {
  final String id;
  final List<dynamic> items; // can be Food or Deal
  final double total;
  final PaymentMethod payment;
  final DateTime date;
  String status;

  Order({
    required this.id,
    required this.items,
    required this.total,
    required this.payment,
    required this.date,
    this.status = 'Preparing',
  });
}

class OrderProvider extends ChangeNotifier {
  final List<Order> _orders = [];

  List<Order> get orders => List.unmodifiable(_orders);

  Order? get latestOrder => _orders.isNotEmpty ? _orders.last : null;

  void placeOrder(List<dynamic> items, double total, PaymentMethod payment) {
    final newOrder = Order(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      items: List.from(items), // dynamic: Food or Deal
      total: total,
      payment: payment,
      date: DateTime.now(),
      status: 'Preparing',
    );

    _orders.add(newOrder);
    notifyListeners();
  }

  void updateOrderStatus(String orderId, String newStatus) {
    final index = _orders.indexWhere((o) => o.id == orderId);
    if (index != -1) {
      _orders[index].status = newStatus;
      notifyListeners();
    }
  }

  void clearOrders() {
    _orders.clear();
    notifyListeners();
  }
}
