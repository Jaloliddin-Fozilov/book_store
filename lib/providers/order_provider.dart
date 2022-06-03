import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/cart_model.dart';
import '/models/order_model.dart';

class OrderProvider with ChangeNotifier {
  List<OrderModel> _items = [];

  String? _authToken;
  String? _userId;

  void setParams(String? authToken, String? userId) {
    _authToken = authToken;
    _userId = userId;
  }

  List<OrderModel> get items {
    return [..._items];
  }

  Future<void> getOrdersFromFirebase() async {
    final url = Uri.parse(
        'https://book-store-marketplace-default-rtdb.firebaseio.com/orders/$_userId.json?auth=$_authToken');
    try {
      final response = await http.get(url);
      if (jsonDecode(response.body) == null) {
        return;
      }
      final data = jsonDecode(response.body) as Map<String, dynamic>;

      List<OrderModel> loadedOrders = [];

      data.forEach(
        (orderId, orderData) {
          loadedOrders.insert(
            0,
            OrderModel(
              id: orderId,
              totalPrice: double.parse(orderData['totalPrice']),
              date: DateTime.parse(orderData['date']),
              books: (orderData['products'] as List<dynamic>)
                  .map(
                    (product) => CartModel(
                      id: product['id'],
                      title: product['title'],
                      quantity: product['quantity'],
                      price: product['price'],
                      imageUrl: product['image'],
                    ),
                  )
                  .toList(),
            ),
          );
        },
      );
      _items = loadedOrders;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addToOrders(List<CartModel> products, double totalPrice) async {
    final url = Uri.parse(
        'https://book-store-marketplace-default-rtdb.firebaseio.com/orders/$_userId.json?auth=$_authToken');
    try {
      final response = await http.post(
        url,
        body: jsonEncode(
          {
            'totalPrice': totalPrice,
            'date': DateTime.now().toIso8601String(),
            'products': products
                .map(
                  (product) => {
                    'id': product.id,
                    'title': product.title,
                    'quantity': product.quantity,
                    'price': product.price,
                    'image': product.imageUrl,
                  },
                )
                .toList(),
          },
        ),
      );

      _items.insert(
        0,
        OrderModel(
          id: jsonDecode(response.body)['name'].toString(),
          totalPrice: totalPrice,
          date: DateTime.now(),
          books: products,
        ),
      );
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
