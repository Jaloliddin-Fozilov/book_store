import 'package:flutter/material.dart';

class CartModel with ChangeNotifier {
  final String id;
  final String title;
  final String imageUrl;
  final double price;
  final int quantity;

  CartModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.quantity,
  });
}
