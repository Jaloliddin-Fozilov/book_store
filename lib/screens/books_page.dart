import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/book_provider.dart';
import 'book_detail_page.dart';

class BooksPage extends StatelessWidget {
  const BooksPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final allBooks = Provider.of<BookProvider>(context).list;
    final topBooks = Provider.of<BookProvider>(context).bestRatingList;
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey[200],
            ),
            child: const TabBar(
              labelColor: Colors.black,
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              indicatorColor: Colors.transparent,
              unselectedLabelStyle: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
              tabs: [
                Tab(
                  child: Text('All'),
                ),
                Tab(
                  child: Text('Top rated'),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                ListView.builder(
                  itemCount: allBooks.length,
                  itemBuilder: (ctx, i) {
                    return InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              BookDetailPage(id: allBooks[i].id),
                        ),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(allBooks[i].imageUrl),
                        ),
                        title: Text(
                          allBooks[i].title,
                        ),
                        subtitle: Text('rating: ${allBooks[i].rating}'),
                        trailing: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          child: Text(
                            '\$${allBooks[i].price}',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                ListView.builder(
                  itemCount: topBooks.length,
                  itemBuilder: (ctx, i) {
                    return InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              BookDetailPage(id: topBooks[i].id),
                        ),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(topBooks[i].imageUrl),
                        ),
                        title: Text(
                          topBooks[i].title,
                        ),
                        subtitle: Text('rating: ${topBooks[i].rating}'),
                        trailing: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            borderRadius: const BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          child: Text(
                            '\$${topBooks[i].price}',
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
