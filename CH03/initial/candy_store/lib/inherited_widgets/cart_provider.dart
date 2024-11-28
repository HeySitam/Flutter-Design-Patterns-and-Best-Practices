import 'package:candy_store/notifiers/cart_notifier.dart';
import 'package:flutter/material.dart';

class CartProvider extends InheritedWidget{
  final CartNotifier cartNotifier;
  CartProvider({required this.cartNotifier, required super.child});

  static CartNotifier of(BuildContext context){
    final cartProviderInstanceFromWidgetTree = context.dependOnInheritedWidgetOfExactType<CartProvider>();
    if(cartProviderInstanceFromWidgetTree != null) {
      return cartProviderInstanceFromWidgetTree.cartNotifier;
    } else {
      throw Exception("CartProvider Instance Not Found in Widget Tree!");
    }

  }

  @override
  bool updateShouldNotify(CartProvider oldWidget) {
    return cartNotifier != oldWidget.cartNotifier;
  }

}