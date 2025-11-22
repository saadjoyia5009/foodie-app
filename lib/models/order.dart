import 'food_item.dart';
import 'payment_method.dart';

class Order {
  final String id;
  final List<FoodItem> items;
  final double totalAmount;
  final PaymentMethod paymentMethod;
  String status; // mutable so provider can update

  Order({
    required this.id,
    required this.items,
    required this.totalAmount,
    required this.paymentMethod,
    required this.status,
  });
}
