import 'package:flutter/material.dart';
import '../models/food.dart';
import '../models/deal.dart';

class CartProvider extends ChangeNotifier {
  final List<dynamic> _items = []; // can store Food or Deal

  List<dynamic> get items => List.unmodifiable(_items);

  void addItem(dynamic item) {
    _items.add(item);
    notifyListeners();
  }

  void removeItem(dynamic item) {
    _items.removeWhere((i) {
      if (i is Food && item is Food) return i.id == item.id;
      if (i is Deal && item is Deal) return i.id == item.id;
      return false;
    });
    notifyListeners();
  }

  void removeAllOf(dynamic item) {
    _items.removeWhere((i) {
      if (i is Food && item is Food) return i.id == item.id;
      if (i is Deal && item is Deal) return i.id == item.id;
      return false;
    });
    notifyListeners();
  }

  double get totalPrice {
    double total = 0;
    for (var item in _items) {
      if (item is Food) total += item.price;
      if (item is Deal) total += item.discount; // or your deal price logic
    }
    return total;
  }

  int quantityOf(dynamic item) {
    return _items.where((i) {
      if (i is Food && item is Food) return i.id == item.id;
      if (i is Deal && item is Deal) return i.id == item.id;
      return false;
    }).length;
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
