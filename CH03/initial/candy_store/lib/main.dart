import 'package:candy_store/inherited_widgets/cart_provider.dart';
import 'package:candy_store/main_page.dart';
import 'package:candy_store/notifiers/cart_notifier.dart';
import 'package:flutter/material.dart';

// At this point, all of the code is in the `lib` folder and we will structure it in Part 3
void main() {
  runApp(
    CartProvider(
      cartNotifier: CartNotifier(),
      child: MaterialApp(
          title: 'Candy store',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.lime,
          ),
          home: const MainPage(),
        ),
    ),
  );
}
