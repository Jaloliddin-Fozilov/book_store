import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/profile_page_screen.dart';
import '../screens/sign_screen.dart';

import '../providers/author_provider.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isLogin = false;

    final author = Provider.of<AuthorProvider>(context).list[0];
    return isLogin ? ProfileScreen(authorId: author.id) : SignScreen();
  }
}
