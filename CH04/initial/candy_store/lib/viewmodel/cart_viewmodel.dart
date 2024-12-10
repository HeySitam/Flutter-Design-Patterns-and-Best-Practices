import 'package:candy_store/model/cart_list_item.dart';
import 'package:candy_store/model/cart_model.dart';
import 'package:candy_store/model/product_list_item.dart';
import 'package:candy_store/viewmodel/cart_state.dart';
import 'package:flutter/foundation.dart';

class CartViewModel extends ChangeNotifier {
  final CartModel _cartModel = CartModel();
  CartViewModel() {
    _cartModel.cartInfoStream.listen((cartInfo) {
      // _items.clear();
      // _totalItems = cartInfo.totalItems;
      // _totalPrice = cartInfo.totalPrice;
      // cartInfo.items.forEach((key, value){
      //   _items[key] = value;
      // });
      _state = _state.copyWith(
        items: cartInfo.items,
        totalPrice: cartInfo.totalPrice,
        totalItems: cartInfo.totalItems
      );
      notifyListeners();
    });
  }

  CartState _state = CartState(
      items: {},
      totalPrice: 0,
      totalItems: 0
  );
  // final Map<String, CartListItem> _items = {};
  // double _totalPrice = 0;
  // int _totalItems = 0;

  CartState get state => _state;

  // List<CartListItem> get items => _items.values.toList();
  //
  // double get totalPrice => _totalPrice;
  //
  // int get totalItems => _totalItems;

  Future<void> addToCart(ProductListItem item) async {
  // _cartModel.addToCart(item);
    try {
      _state = _state.copyWith(isProcessing: true);
      notifyListeners();
      await _cartModel.addToCart(item);
      _state = _state.copyWith(isProcessing: false);
    } on Exception catch (ex) {
      _state = _state.copyWith(error: ex);
    }
    notifyListeners();
  }

  Future<void> removeFromCart(CartListItem item) async {
    try {
      _state = _state.copyWith(isProcessing: true);
      notifyListeners();
      await _cartModel.removeFromCart(item);
      _state = _state.copyWith(isProcessing: false);
    } on Exception catch (ex) {
      _state = _state.copyWith(error: ex);
    }
    notifyListeners();
  }

  void clearError() {
    _state = _state.copyWith(error: null);
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _cartModel.dispose();
  }
}
