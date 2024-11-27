import 'dart:developer';

import 'package:candy_store/cart_button.dart';
import 'package:candy_store/cart_list_item.dart';
import 'package:candy_store/cart_page.dart';
import 'package:candy_store/product_list_item.dart';
import 'package:candy_store/products_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<CartListItem> cartItems = [];

  // The Map key is the id of the CartListItem. We will use a Map data structure
  // because it is easier to manage the addition, removal & count of the items.
 // final Map<String, CartListItem> cartItemsMap = {};
  ValueNotifier<Map<String, CartListItem>> cartItemsMap = ValueNotifier({});

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        ProductsPage(
          onAddToCart: addToCart,
        ),
        Positioned(
          right: 16,
          bottom: 16,
          child: GestureDetector(
            onTap: openCart,
            child: ValueListenableBuilder(
              valueListenable: cartItemsMap,
              builder: (context, items, child) {
                final totalCount = items.values.fold<int>(
                  0,
                      (previousValue, element) => previousValue + element.quantity,
                );
                return CartButton(
                  count: totalCount,
                );
              }
            ),
          ),
        ),
      ],
    );
  }

  // TODO: Make this implementation more efficient via a Map
  void addToCart(ProductListItem item) {
    CartListItem? existingItem = cartItemsMap.value[item.id];
    if (existingItem != null) {
      existingItem = CartListItem(
        product: existingItem.product,
        quantity: existingItem.quantity + 1,
      );
      final newCartItemMap = Map<String, CartListItem>.from(cartItemsMap.value);
      newCartItemMap[item.id] = existingItem;
      cartItemsMap.value = newCartItemMap;
     // setState(() {});
    } else {
      setState(() {
        final cartItem = CartListItem(
          product: item,
          quantity: 1,
        );
        cartItemsMap.value[item.id] = cartItem;
      });
    }
  }

  void removeFromCart(CartListItem item) {
    CartListItem? existingItem = cartItemsMap.value[item.product.id];
    if (existingItem != null) {
      if (existingItem.quantity > 1) {
        existingItem = CartListItem(
          product: existingItem.product,
          quantity: existingItem.quantity - 1,
        );
        cartItemsMap.value[item.product.id] = existingItem;
        setState(() {});
      } else {
        cartItemsMap.value.remove(item.product.id);
        setState(() {});
      }
    }
  }

  void openCart() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CartPage(
          items: cartItemsMap,
          onAddToCart: (item) {
            addToCart(item.product);
          },
          onRemoveFromCart: removeFromCart,
        ),
      ),
    );
  }
}
