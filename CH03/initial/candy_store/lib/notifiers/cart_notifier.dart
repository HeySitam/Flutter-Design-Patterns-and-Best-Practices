import 'package:candy_store/product_list_item.dart';
import 'package:flutter/material.dart';

import '../cart_list_item.dart';

class CartNotifier extends ChangeNotifier {
  final Map<String, CartListItem> _items = {};
  double _totalPrice = 0;
  int _totalItems = 0;
  List<CartListItem> get items => _items.values.toList();
  double get totalPrice => _totalPrice;
  int get totalItems => _totalItems;

  void addToCart(ProductListItem item) {
    CartListItem? existingItem = _items[item.id];
    if (existingItem != null) {
      existingItem = CartListItem(
        product: existingItem.product,
        quantity: existingItem.quantity + 1,
      );
      _items[item.id] = existingItem;
    } else {
      final cartItem = CartListItem(
        product: item,
        quantity: 1,
      );
      _items[item.id] = cartItem;
    }
    notifyListeners();
  }

  void removeFromCart(CartListItem item) {
    // Exactly the same logic as we had in MainPage
    CartListItem? existingItem = _items[item.product.id];
    if (existingItem != null) {
      if (existingItem.quantity > 1) {
        existingItem = CartListItem(
          product: existingItem.product,
          quantity: existingItem.quantity - 1,
        );
        _items[item.product.id] = existingItem;
      } else {
        _items.remove(item.product.id);
      }
      notifyListeners();
    }
  }
}