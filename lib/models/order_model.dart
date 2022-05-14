import './cart_model.dart';

class OrderModel {
  final String id;
  final double totalPrice;
  final DateTime date;
  final List<CartModel> books;

  OrderModel({
    required this.id,
    required this.totalPrice,
    required this.date,
    required this.books,
  });
}
