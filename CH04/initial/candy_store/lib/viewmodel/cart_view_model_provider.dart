import 'package:candy_store/viewmodel/cart_viewmodel.dart';
import 'package:flutter/material.dart';

class CartViewModelProvider extends InheritedWidget {
  final CartViewModel cartNotifier;

  const CartViewModelProvider({
    super.key,
    required this.cartNotifier,
    required Widget child,
  }) : super(child: child);

  static CartViewModel of(BuildContext context) {
    final provider = context.dependOnInheritedWidgetOfExactType<CartViewModelProvider>();

    if (provider == null) {
      throw 'No CartProvider found in context';
    }

    return provider.cartNotifier;
  }

  @override
  bool updateShouldNotify(CartViewModelProvider oldWidget) {
    return cartNotifier != oldWidget.cartNotifier;
  }
}
