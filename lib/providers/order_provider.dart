import 'package:flutter/material.dart';

import '../models/cart_model.dart';
import '../models/order_model.dart';

class OrderProvider with ChangeNotifier {
  List<OrderModel> _list = [];
  List<OrderModel> get list {
    return [..._list];
  }

  void addToOrder(List<CartModel> books, double totalPrice) {
    _list.insert(
      0,
      OrderModel(
        id: UniqueKey().toString(),
        totalPrice: totalPrice,
        date: DateTime.now(),
        books: books,
      ),
    );
    notifyListeners();
  }
}
