import 'package:flutter/material.dart';

import './home_tab.dart';

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
  final List _pages = [
    HomeTab(),
    HomeTab(),
  ];
  int _currentIndex = 0;

  void changeTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
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
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        type: BottomNavigationBarType.shifting,
        currentIndex: _currentIndex,
        onTap: changeTab,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
        ],
      ),
    );
  }
}
