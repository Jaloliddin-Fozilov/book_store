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
        itemCount: order.items.length,
        itemBuilder: (ctx, index) {
          return ExpansionTile(
            title: Text(
              'Date: ${order.items[index].date.year}-${order.items[index].date.month}-${order.items[index].date.day} Total price: ${order.items[index].totalPrice}',
            ),
            children: order.items[index].books.map(
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
