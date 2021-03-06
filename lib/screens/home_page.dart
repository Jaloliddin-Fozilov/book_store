import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './home_tab.dart';
import './books_page.dart';
import 'profile.dart';

import '../providers/auth.dart';

import '../widgets/app_drawer.dart';
import '../widgets/my_search_delegate.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  static const routName = '/';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List _pages = [
    const HomeTab(),
    const BooksPage(),
    const Profile(),
  ];
  int _currentIndex = 0;

  void changeTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context);
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
        centerTitle: true,
        title: const Text('Book Store'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              size: 32,
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
        elevation: 0,
      ),
      drawer: const AppDrawer(),
      body: auth.isAuth ? _pages[_currentIndex] : _pages[2],
      bottomNavigationBar: SizedBox(
        height: 70,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.shifting,
            unselectedItemColor: Colors.grey,
            currentIndex: _currentIndex,
            onTap: changeTab,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'Home',
                backgroundColor: Colors.deepPurple,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.library_books,
                ),
                label: 'Books',
                backgroundColor: Colors.deepPurple,
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                ),
                label: 'Profile',
                backgroundColor: Colors.deepPurple,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
