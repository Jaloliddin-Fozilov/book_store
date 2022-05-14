import 'package:flutter/material.dart';

import '../models/cart_model.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartModel> _items = {};

  Map<String, CartModel> get items {
    return {..._items};
  }

  int itemsCount() {
    return _items.length;
  }

  double get totalPrice {
    var total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  int quantityProduct(String productId) {
    final isProductAdded = _items.containsKey(productId);
    if (!isProductAdded) {
      return 0;
    } else {
      return _items[productId]!.quantity;
    }
  }

  void addToCart(
    String productId,
    String title,
    String imageUrl,
    double price,
  ) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (currentProduct) => CartModel(
          id: currentProduct.id,
          title: currentProduct.title,
          quantity: currentProduct.quantity + 1,
          price: currentProduct.price,
          imageUrl: currentProduct.imageUrl,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartModel(
          id: UniqueKey().toString(),
          title: title,
          quantity: 1,
          price: price,
          imageUrl: imageUrl,
        ),
      );
    }
    notifyListeners();
  }

  void removeSingleItem(String productId) {
    if (!_items.containsKey(productId)) {
      return;
    }
    if (_items[productId]!.quantity > 1) {
      _items.update(
        productId,
        (currentProduct) => CartModel(
          id: currentProduct.id,
          title: currentProduct.title,
          quantity: currentProduct.quantity - 1,
          price: currentProduct.price,
          imageUrl: currentProduct.imageUrl,
        ),
      );
      notifyListeners();
    }
  }

  void removeItem(String productId) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeItems() {
    _items.clear();
    notifyListeners();
  }
}
