import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/order_provider.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  static const routName = '/orders';

  @override
  Widget build(BuildContext context) {
    final order = Provider.of<OrderProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Orders'),
      ),
      body: ListView.builder(
        itemCount: order.list.length,
        itemBuilder: (ctx, index) {
          return ExpansionTile(
            title: Text(
              'ID: ${order.list[index].id} Date: ${order.list[index].date.year}-${order.list[index].date.month}-${order.list[index].date.day} Total price: ${order.list[index].totalPrice}',
            ),
            children: order.list[index].books.map(
              (book) {
                return ListTile(
                  leading: Image.network(book.imageUrl),
                  title: Text(book.title),
                  subtitle: Text(
                    'Quantity: ${book.quantity} \nPrice: ${book.price} \nTotal price: ${book.price * book.quantity}',
                  ),
                );
              },
            ).toList(),
          );
        },
      ),
    );
  }
}
