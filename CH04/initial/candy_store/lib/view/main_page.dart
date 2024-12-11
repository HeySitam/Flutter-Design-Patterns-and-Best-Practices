import 'package:candy_store/cubit/cart_cubit.dart';
import 'package:candy_store/view/cart_button.dart';
import 'package:candy_store/viewmodel/cart_state.dart';
import 'package:candy_store/view/cart_page.dart';
import 'package:candy_store/view/products_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late final CartCubit _cartCubit;

  @override
  void initState() {
    _cartCubit = context.read<CartCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        if(state.error != null) {
          _cartCubit.clearError();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Failed to perform this action'),
            ),
          );
        }
      },
      builder: (context, state) {
        return  Stack(
          children: [
            const ProductsPage(),
            Positioned(
              right: 16,
              bottom: 16,
              child: GestureDetector(
                onTap: openCart,
                child: CartButton(
                  count: state.totalItems,
                ),
              ),
            ),
            Visibility(
                visible: state.isProcessing,
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
