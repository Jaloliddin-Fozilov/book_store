import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/profile_page_screen.dart';
import '../screens/sign_screen.dart';

import '../providers/auth.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Auth>(
      builder: (ctx, authdata, child) {
        return authdata.isAuth
            ? const ProfileScreen()
            : FutureBuilder(
                future: authdata.autoLogin(),
                builder: (c, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const ProfileScreen();
                  } else {
                    return const SignScreen();
                  }
                },
              );
      },
    );
  }
}
