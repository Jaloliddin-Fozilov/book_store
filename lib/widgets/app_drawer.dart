import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
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
              onTap: () => Navigator.of(context).pushNamed('/'),
            ),
            const Divider(
              height: 0,
            ),
            auth.isAuth
                ? ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Dashboard'),
                    onTap: () => Navigator.of(context).pushNamed('/dashboard'),
                  )
                : const SizedBox(),
            auth.isAuth
                ? const Divider(
                    height: 0,
                  )
                : const SizedBox(),
            ListTile(
              leading: const Icon(Icons.shopping_cart_outlined),
              title: const Text('Cart'),
              onTap: () => Navigator.of(context).pushNamed('/cart'),
            ),
            const Divider(
              height: 0,
            ),
            ListTile(
              leading: const Icon(Icons.list_alt),
              title: const Text('Orders'),
              onTap: () => Navigator.of(context).pushNamed('/orders'),
            ),
            const Divider(
              height: 0,
            ),
            auth.isAuth
                ? ListTile(
                    leading: const Icon(Icons.exit_to_app),
                    title: const Text('Exit'),
                    onTap: () => auth.logout(),
                  )
                : const SizedBox(),
            auth.isAuth
                ? const Divider(
                    height: 0,
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
