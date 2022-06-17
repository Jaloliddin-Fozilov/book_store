import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/book_provider.dart';

import '../widgets/home_tabs_block.dart';
import '../widgets/book_item.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<BookProvider>(context).getProductsFromFirebase();
    final book = Provider.of<BookProvider>(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const HomeTabsBlock(),
          Padding(
            padding: const EdgeInsets.only(left: 18, right: 18, top: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'New Releases',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    BookItem(
                      id: book.list[book.list.length - 3].id,
                      imageUrl: book.list[book.list.length - 3].imageUrl,
                      title: book.list[book.list.length - 3].title,
                      price: book.list[book.list.length - 3].price,
                    ),
                    BookItem(
                      id: book.list[book.list.length - 2].id,
                      imageUrl: book.list[book.list.length - 2].imageUrl,
                      title: book.list[book.list.length - 2].title,
                      price: book.list[book.list.length - 2].price,
                    ),
                    BookItem(
                      id: book.list[book.list.length - 1].id,
                      imageUrl: book.list[book.list.length - 1].imageUrl,
                      title: book.list[book.list.length - 1].title,
                      price: book.list[book.list.length - 1].price,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
