import 'package:flutter/material.dart';
import 'cart_item.dart';

class CartProvider extends ChangeNotifier {
  final List<CartItem> _items = [];
  List<CartItem> get items => _items;
  void addItem(CartItem item) {
    int index = _items.indexWhere((i) => i.id == item.id);
    if (index != -1) {
      _items[index].quantity++;
    } else {
      _items.add(item);
    }
    notifyListeners();
  }

  // Remove item from cart
  void removeItem(String id) {
    _items.removeWhere((item) => item.id == id);
    notifyListeners();
  }
  void clearCart() {
    _items.clear();
    notifyListeners();
  }
  double getTotalPrice() {
    double total = 0;
    for (var item in _items) {
      total += item.price * item.quantity;
    }
    return total;
  }
  double getDiscount() {
    double total = getTotalPrice();
    if (total > 50) {
      return total * 0.1; // 10% discount
    }
    return 0;
  }
  double getFinalPrice() {
    return getTotalPrice() - getDiscount();
  }
  int get itemCount => _items.length;
}