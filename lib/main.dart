import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import './providers/book_provider.dart';
import './providers/author_provider.dart';
import './providers/cart_provider.dart';
import './providers/order_provider.dart';

import './screens/home_page.dart';
import './screens/cart_screen.dart';
import './screens/orders_screen.dart';
import './screens/edit_profile_screen.dart';
import './screens/dashboard_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => BookProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthorProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => OrderProvider(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Book Store',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          fontFamily: GoogleFonts.montserrat().fontFamily,
          scaffoldBackgroundColor: Colors.white,
        ),
        initialRoute: '/',
        routes: {
          HomePage.routName: (ctx) => const HomePage(),
          CartScreen.routName: (ctx) => const CartScreen(),
          OrdersScreen.routName: (ctx) => const OrdersScreen(),
          EditProfileScreen.routName: (ctx) => const EditProfileScreen(),
          DashboardScreen.routName: (ctx) => const DashboardScreen(),
        },
      ),
    );
  }
}
