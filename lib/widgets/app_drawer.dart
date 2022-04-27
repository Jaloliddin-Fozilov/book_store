import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text('Menu'),
        ),
        body: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {},
            ),
            const Divider(
              height: 0,
            ),
            ListTile(
              leading: const Icon(Icons.shopping_cart_outlined),
              title: const Text('Cart'),
              onTap: () {},
            ),
            const Divider(
              height: 0,
            ),
            ListTile(
              leading: const Icon(Icons.list_alt),
              title: const Text('Orders'),
              onTap: () {},
            ),
            const Divider(
              height: 0,
            ),
          ],
        ),
      ),
    );
  }
}
