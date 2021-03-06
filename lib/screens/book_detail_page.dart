import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/author_provider.dart';
import '../providers/cart_provider.dart';
import '../providers/book_provider.dart';
import '../providers/auth.dart';

import '../widgets/my_search_delegate.dart';
import '../widgets/book_item.dart';

class BookDetailPage extends StatelessWidget {
  final String id;
  const BookDetailPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final book = Provider.of<BookProvider>(context).findById(id);
    Provider.of<BookProvider>(context).updateViews(book);
    final books = Provider.of<BookProvider>(context);
    Provider.of<AuthorProvider>(context).getAuthorsFromFirebase();
    final author = Provider.of<AuthorProvider>(context).findById(book.authorId);
    final cart = Provider.of<CartProvider>(context, listen: false);
    final auth = Provider.of<Auth>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.grey,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              size: 24,
              color: Colors.grey,
            ),
            onPressed: () {
              showSearch(
                context: context,
                delegate: MySearchDelegete(),
              );
            },
          ),
          const SizedBox(width: 5),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, top: 24),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 180,
                        width: 140,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.network(
                            book.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                        height: 180,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 150,
                              child: Text(
                                book.title,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 140,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.star,
                                        size: 20,
                                        color: Color(0xFF6e57d8),
                                      ),
                                      Text(
                                        book.rating.toString(),
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Color(0xFF6e57d8),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: const Color(0xFFdbd4fd),
                                    ),
                                    child: Row(
                                      children: [
                                        const Icon(
                                          Icons.remove_red_eye,
                                          size: 20,
                                          color: Color(0xFF6e57d8),
                                        ),
                                        Text(
                                          book.views.toString(),
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Color(0xFF6e57d8),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ElevatedButton(
                              onPressed: auth.isAuth
                                  ? () {
                                      cart.addToCart(
                                        book.id,
                                        book.title,
                                        book.imageUrl,
                                        book.price,
                                      );

                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              '${book.title} added to cart'),
                                          action: SnackBarAction(
                                            label: 'Go to cart',
                                            onPressed: () =>
                                                Navigator.of(context)
                                                    .pushNamed('/cart'),
                                          ),
                                        ),
                                      );
                                    }
                                  : () {
                                      Navigator.of(context).pushNamed('/');
                                    },
                              child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Text(
                                    'Buy for \$${book.price}',
                                    style: const TextStyle(fontSize: 16),
                                  )),
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 30),
                  Text(
                    book.description,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const Divider(height: 30),
                  Row(
                    children: [
                      Row(
                        children: [
                          SizedBox(
                            width: 60,
                            height: 60,
                            child: CircleAvatar(
                              backgroundImage: NetworkImage(author.imageUrl),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                author.name,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: author.name.length > 5 ? 14 : 18,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFdbd4fd),
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: const Text(
                                  'Author',
                                  style: TextStyle(
                                    color: Color(0xFF6e57d8),
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 50,
                              child: ListTile(
                                dense: true,
                                leading: const CircleAvatar(
                                  backgroundColor: Color(0xffdbd4fd),
                                  child: Icon(Icons.person_outline),
                                ),
                                title: Text(author.followers.toString()),
                                subtitle: const Text('Followers'),
                              ),
                            ),
                            SizedBox(
                              height: 50,
                              child: ListTile(
                                dense: true,
                                leading: const CircleAvatar(
                                  backgroundColor: Color(0xffdbd4fd),
                                  child: Icon(Icons.person_outline),
                                ),
                                title: Text(author.following.toString()),
                                subtitle: const Text('Following'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 24, right: 24, left: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Popular books',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        BookItem(
                          id: books.list[books.list.length - 3].id,
                          imageUrl: books.list[books.list.length - 3].imageUrl,
                          title: books.list[books.list.length - 3].title,
                          price: books.list[books.list.length - 3].price,
                          textColor: Colors.white,
                        ),
                        BookItem(
                          id: books.list[books.list.length - 2].id,
                          imageUrl: books.list[books.list.length - 2].imageUrl,
                          title: books.list[books.list.length - 2].title,
                          price: books.list[books.list.length - 2].price,
                          textColor: Colors.white,
                        ),
                        BookItem(
                          id: books.list[books.list.length - 1].id,
                          imageUrl: books.list[books.list.length - 1].imageUrl,
                          title: books.list[books.list.length - 1].title,
                          price: books.list[books.list.length - 1].price,
                          textColor: Colors.white,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
