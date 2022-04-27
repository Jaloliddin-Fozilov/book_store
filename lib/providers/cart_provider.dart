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
    _items.forEach(
      (key, cartModel) {
        total += cartModel.price * cartModel.quantity;
      },
    );
    return total;
  }

  void addToCart(
    String productId,
    String title,
    String image,
    double price,
  ) {
    if (_items.containsKey(productId)) {
      // mahsulot bo'lsa + 1 bo'lish kerak
      _items.update(
        productId,
        (currentProduct) => CartModel(
            id: currentProduct.id,
            title: currentProduct.title,
            quantity: currentProduct.quantity + 1,
            price: currentProduct.price,
            imageUrl: currentProduct.imageUrl),
      );
    } else {
      // cartga qo'shish kerak
      _items.putIfAbsent(
        productId,
        () => CartModel(
          id: UniqueKey().toString(),
          title: title,
          quantity: 1,
          price: price,
          imageUrl: image,
        ),
      );
    }
    notifyListeners();
  }

  void removeSingleItem(String productId, {bool isCartButton = false}) {
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
    } else if (isCartButton) {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void clearItems() {
    _items.clear();
    notifyListeners();
  }
}
