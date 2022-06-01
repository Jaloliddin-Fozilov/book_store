import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/profile_page_screen.dart';
import '../screens/sign_screen.dart';

import '../providers/author_provider.dart';
import '../providers/auth.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final author = Provider.of<AuthorProvider>(context).list[0];
    return Consumer<Auth>(
      builder: (ctx, authdata, child) {
        return authdata.isAuth
            ? ProfileScreen(authorId: author.id)
            : FutureBuilder(
                future: authdata.autoLogin(),
                builder: (c, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return ProfileScreen(authorId: author.id);
                  } else {
                    return const SignScreen();
                  }
                },
              );
      },
    );
  }
}
