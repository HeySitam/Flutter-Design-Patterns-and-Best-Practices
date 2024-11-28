import 'package:candy_store/cart_button.dart';
import 'package:candy_store/cart_page.dart';
import 'package:candy_store/notifiers/cart_notifier.dart';
import 'package:candy_store/products_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  CartNotifier cartNotifier = CartNotifier();

  @override
  void initState() {
    super.initState();
    cartNotifier.addListener((){
      setState(() {

      });
    });
  }

  @override
  void dispose() {
    cartNotifier.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        ProductsPage(
          onAddToCart: cartNotifier.addToCart,
        ),
        Positioned(
          right: 16,
          bottom: 16,
          child: GestureDetector(
            onTap: openCart,
            child: ListenableBuilder(
              listenable: cartNotifier,
              builder: (context, child) {
                final totalCount = cartNotifier.items.fold<int>(
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

  void openCart() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CartPage(
          cartNotifier: cartNotifier
        ),
      ),
    );
  }
}
