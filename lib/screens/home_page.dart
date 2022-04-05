import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/book_item_tabs.dart';

import '../providers/book_provider.dart';

import '../widgets/app_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  static const routName = '/';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final book = Provider.of<BookProvider>(context);
    final popularBooks = Provider.of<BookProvider>(context).popularBooksList;
    final bestRating = Provider.of<BookProvider>(context).bestRatingList;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: _scaffoldKey,
      endDrawerEnableOpenDragGesture: false,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.grid_view_rounded,
            size: 32,
          ),
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              size: 32,
            ),
            onPressed: () {},
          ),
          const SizedBox(width: 5),
        ],
        elevation: 0,
      ),
      drawer: const AppDrawer(),
      body: Column(
        children: [
          Container(
            height: 350,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(50),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 18, right: 5, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'What do \nyou want to Read?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(50),
                        ),
                      ),
                      child: DefaultTabController(
                        length: 3,
                        child: Scaffold(
                          backgroundColor: Theme.of(context).primaryColor,
                          appBar: AppBar(
                            flexibleSpace: const TabBar(
                              automaticIndicatorColorAdjustment: false,
                              isScrollable: true,
                              labelPadding: EdgeInsets.only(right: 10),
                              tabs: [
                                Tab(child: Text('Best Rating')),
                                Tab(child: Text('Popular')),
                                Tab(child: Text('All books')),
                              ],
                            ),
                            elevation: 0,
                            automaticallyImplyLeading: false,
                          ),
                          body: TabBarView(
                            children: [
                              GridView.builder(
                                scrollDirection: Axis.horizontal,
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                  mainAxisExtent: 250,
                                  maxCrossAxisExtent: 230,
                                  childAspectRatio: 1,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                ),
                                itemCount: bestRating.length,
                                itemBuilder: (ctx, index) {
                                  return BookItemTabs(
                                    title: bestRating[index].title,
                                    imageUrl: bestRating[index].imageUrl,
                                    rating: bestRating[index].rating,
                                    views: bestRating[index].views,
                                  );
                                },
                              ),
                              GridView.builder(
                                scrollDirection: Axis.horizontal,
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                  mainAxisExtent: 250,
                                  maxCrossAxisExtent: 230,
                                  childAspectRatio: 1,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                ),
                                itemCount: popularBooks.length,
                                itemBuilder: (ctx, index) {
                                  return BookItemTabs(
                                    title: popularBooks[index].title,
                                    imageUrl: popularBooks[index].imageUrl,
                                    rating: popularBooks[index].rating,
                                    views: popularBooks[index].views,
                                  );
                                },
                              ),
                              GridView.builder(
                                scrollDirection: Axis.horizontal,
                                gridDelegate:
                                    const SliverGridDelegateWithMaxCrossAxisExtent(
                                  mainAxisExtent: 250,
                                  maxCrossAxisExtent: 230,
                                  childAspectRatio: 1,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                ),
                                itemCount: book.list.length,
                                itemBuilder: (ctx, index) {
                                  return BookItemTabs(
                                    title: book.list[index].title,
                                    imageUrl: book.list[index].imageUrl,
                                    rating: book.list[index].rating,
                                    views: book.list[index].views,
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Center(
            child: Text('Hello World'),
          ),
        ],
      ),
    );
  }
}
