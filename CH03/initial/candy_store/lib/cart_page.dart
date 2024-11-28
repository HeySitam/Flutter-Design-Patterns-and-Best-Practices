import 'package:candy_store/cart_list_item_view.dart';
import 'package:candy_store/inherited_widgets/cart_provider.dart';
import 'package:candy_store/notifiers/cart_notifier.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {

  const CartPage({
    super.key,
  });

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late CartNotifier cartNotifier;

  void _updateCart(){
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // executes after build
      cartNotifier = CartProvider.of(context);
      cartNotifier.addListener(_updateCart);
    });
  }

  @override
  void didChangeDependencies() {
    cartNotifier = CartProvider.of(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    cartNotifier.removeListener(_updateCart);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: ListenableBuilder(
        listenable: cartNotifier,
        builder: (context, child) {
          final values = cartNotifier.items;
          final totalPrice = cartNotifier.items.fold<double>(0, (previous, element) => previous + element.product.price * element.quantity);
          return Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 60),
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  itemCount: values.length,
                  itemBuilder: (context, index) {
                    final item = values[index];
                    return CartListItemView(
                      item: item,
                      onRemoveFromCart: cartNotifier.removeFromCart,
                      onAddToCart: (item) => cartNotifier.addToCart(item.product),
                    );
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
                        '$totalPrice €',
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
        }
      ),
    );
  }
}
