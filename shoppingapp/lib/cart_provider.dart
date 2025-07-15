import 'package:flutter/material.dart';
import 'productlist.dart';

class CartProvider extends ChangeNotifier {
  final Map<Product, int> _cart = {};

  Map<Product, int> get cart => _cart;

  void addToCart(Product product) {
    if (_cart.containsKey(product)) {
      _cart[product] = _cart[product]! + 1;
    } else {
      _cart[product] = 1;
    }
    notifyListeners();
  }

  void removeFromCart(Product product) {
    if (_cart.containsKey(product)) {
      if (_cart[product]! > 1) {
        _cart[product] = _cart[product]! - 1;
      } else {
        _cart.remove(product);
      }
      notifyListeners();
    }
  }

  void setProductQuantity(Product product, int quantity) {
    if (quantity > 0) {
      _cart[product] = quantity;
    } else {
      _cart.remove(product);
    }
    notifyListeners();
  }

  int getQuantity(Product product) {
    return _cart[product] ?? 0;
  }

  bool isInCart(Product product) {
    return _cart.containsKey(product);
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }
}
