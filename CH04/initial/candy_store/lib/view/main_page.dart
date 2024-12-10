import 'package:candy_store/view/cart_button.dart';
import 'package:candy_store/viewmodel/cart_view_model_provider.dart';
import 'package:candy_store/view/cart_page.dart';
import 'package:candy_store/view/products_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    final cartVM = CartViewModelProvider.of(context);
    return ListenableBuilder(
      listenable: cartVM,
      builder: (context, _) {
        return  Stack(
          children: [
            const ProductsPage(),
            Positioned(
              right: 16,
              bottom: 16,
              child: GestureDetector(
                onTap: openCart,
                child: CartButton(
                  count: cartVM.state.totalItems,
                ),
              ),
            ),
            Visibility(
                visible: cartVM.state.isProcessing,
                child: Center(child: CircularProgressIndicator()))
          ],
        );
      },
    );
  }

  void openCart() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const CartPage(),
      ),
    );
  }
}
