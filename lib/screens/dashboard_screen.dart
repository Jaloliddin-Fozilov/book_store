import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/book_provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  static const routName = '/dashboard';

  @override
  Widget build(BuildContext context) {
    final books = Provider.of<BookProvider>(context).authorBook('1');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Dashboard'),
        actions: [
          IconButton(
            onPressed: () {},
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
                      onPressed: () {},
                      icon: Icon(
                        Icons.delete,
                        color: Theme.of(context).errorColor,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
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
