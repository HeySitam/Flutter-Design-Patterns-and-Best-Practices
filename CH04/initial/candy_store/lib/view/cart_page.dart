import 'dart:developer';

import 'package:candy_store/view/cart_list_item_view.dart';
import 'package:candy_store/viewmodel/cart_view_model_provider.dart';
import 'package:candy_store/viewmodel/cart_viewmodel.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late final CartViewModel _cartViewModel;

  @override
  void initState() {
    super.initState();
    _cartViewModel = CartViewModelProvider.read(context);
    _cartViewModel.addListener(_onCartViewModelStateChanged);
  }

  void _onCartViewModelStateChanged(){
    if(_cartViewModel.state.error != null){
      _cartViewModel.clearError();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_cartViewModel.state.error.toString()))
      );
    }
  }

  @override
  void dispose() {
    _cartViewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cartNotifier = CartViewModelProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: ListenableBuilder(
        listenable: _cartViewModel,
        builder: (context, _) {
          log("Is Processing : ${_cartViewModel.state.isProcessing}");
          log("CartVM Items Length : ${_cartViewModel.state.items.length}");
          if(_cartViewModel.state.isProcessing) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 60),
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  itemCount: _cartViewModel.state.items.length,
                  itemBuilder: (context, index) {
                    final item = _cartViewModel.state.items.values.toList()[index];
                    return CartListItemView(item: item);
                  },
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '${_cartViewModel.state.totalPrice} €',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
