import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './edit_product_screen.dart';

import '../providers/book_provider.dart';
import '../providers/auth.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  static const routName = '/dashboard';

  void _notifyUserAboutDelete(BuildContext context, Function() removeItem) {
    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: const Text("Ishonchingiz komilmi?"),
          content: const Text("Kitob o'chirilmoqda!"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                "BEKOR QILSH",
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                removeItem();
                Navigator.of(context).pop();
              },
              child: const Text("O'CHIRISH"),
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).errorColor,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final books = Provider.of<BookProvider>(context).authorBook(
        Provider.of<Auth>(context, listen: false).userId.toString());
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pushNamed('/edit-product'),
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 10),
        itemCount: books.length,
        itemBuilder: (ctx, index) {
          final book = books[index];
          return Column(
            children: [
              ListTile(
                leading: Image.network(
                  book.imageUrl,
                  width: 50,
                  height: 70,
                  fit: BoxFit.cover,
                ),
                title: Text(book.title),
                subtitle:
                    Text('💲${book.price}/⭐️${book.rating}/👁‍🗨${book.views}'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        _notifyUserAboutDelete(context, () async {
                          try {
                            await Provider.of<BookProvider>(context,
                                    listen: false)
                                .deleteProduct(book.id);
                          } catch (e) {
                            scaffoldMessenger.showSnackBar(
                                SnackBar(content: Text(e.toString())));
                          }
                        });
                      },
                      icon: Icon(
                        Icons.delete,
                        color: Theme.of(context).errorColor,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          EditProductScreen.routName,
                          arguments: book.id,
                        );
                      },
                      icon: const Icon(
                        Icons.edit,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
            ],
          );
        },
      ),
    );
  }
}
