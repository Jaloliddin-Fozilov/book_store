import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';
import '../providers/order_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  static const routName = '/cart';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    final order = Provider.of<OrderProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Cart'),
        actions: [
          IconButton(
            onPressed: () => cart.removeItems(),
            icon: const Icon(
              Icons.clear_all,
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (ctx, index) {
                final cartItem = cart.items.values.toList()[index];
                return ListTile(
                  leading: SizedBox(
                    width: 30,
                    height: 80,
                    child: Image.network(
                      cartItem.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                  title: Text(
                    cartItem.title,
                  ),
                  subtitle: Text(
                    'Total price: \$${cartItem.price * cartItem.quantity}, Quantity: ${cartItem.quantity}',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () => cart
                            .removeSingleItem(cart.items.keys.toList()[index]),
                        icon: const Icon(
                          Icons.remove,
                          color: Colors.black,
                        ),
                        splashRadius: 20,
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.grey[100],
                        ),
                        child: Text(
                          cartItem.quantity.toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () => cart.addToCart(
                          cart.items.keys.toList()[index],
                          cartItem.title,
                          cartItem.imageUrl,
                          cartItem.price,
                        ),
                        icon: const Icon(
                          Icons.add,
                          color: Colors.black,
                        ),
                        splashRadius: 20,
                      ),
                      IconButton(
                        onPressed: () =>
                            cart.removeItem(cart.items.keys.toList()[index]),
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                        splashRadius: 20,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          BottomAppBar(
            color: Theme.of(context).primaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Total price',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '\$${cart.totalPrice}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: cart.items.values.isNotEmpty
                      ? () {
                          order.addToOrder(
                            cart.items.values.toList(),
                            cart.totalPrice,
                          );
                          cart.removeItems();
                          Navigator.of(context).pushNamed('/orders');
                        }
                      : null,
                  child: Text(
                    'Buy',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
