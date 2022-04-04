import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                                Tab(child: Text('For You')),
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
                                itemCount: book.list.length,
                                itemBuilder: (ctx, index) {
                                  return Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: Colors.white,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          child: Image.network(
                                            book.list[index].imageUrl,
                                            width: 120,
                                            height: 150,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 100,
                                              child: Text(
                                                book.list[index].title,
                                                style: const TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Row(
                                                  children: [
                                                    const Icon(
                                                      Icons.star,
                                                      size: 18,
                                                      color: Color(0xFF6e57d8),
                                                    ),
                                                    Text(
                                                      book.list[index].rating
                                                          .toString(),
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                        color:
                                                            Color(0xFF6e57d8),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SafeArea(
                                                    child: SizedBox(width: 20)),
                                                Container(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color:
                                                        const Color(0xFFdbd4fd),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      const Icon(
                                                        Icons.view_module,
                                                        size: 18,
                                                        color:
                                                            Color(0xFF6e57d8),
                                                      ),
                                                      Text(
                                                        book.list[index].rating
                                                            .toString(),
                                                        style: const TextStyle(
                                                          fontSize: 16,
                                                          color:
                                                              Color(0xFF6e57d8),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              const Text('data1'),
                              const Text('data2'),
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
