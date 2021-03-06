import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/author_provider.dart';

import '../widgets/profile_follower.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    required this.userId,
    Key? key,
  }) : super(key: key);
  final String userId;
  @override
  Widget build(BuildContext context) {
    Provider.of<AuthorProvider>(context).getAuthorsFromFirebase();
    final author = Provider.of<AuthorProvider>(context).findById(userId);
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(100),
                  bottomRight: Radius.circular(100),
                ),
              ),
            ),
            Positioned(
              top: 30,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(100),
                child: Image.network(
                  author.imageUrl,
                  width: 120,
                  height: 120,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 60, left: 60, right: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ListTile(
                leading: const Icon(
                  Icons.person,
                ),
                title: Text(author.name),
              ),
              ListTile(
                leading: const Icon(
                  Icons.mail,
                ),
                title: Text(author.email),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ProfileFollower(
                    text: 'Followers',
                    number: author.followers,
                  ),
                  ProfileFollower(
                    text: 'Following',
                    number: author.following,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: () =>
                          Navigator.of(context).pushNamed('/edit-profile'),
                      child: const Text('Edit Profile'),
                    ),
                    ElevatedButton(
                      onPressed: () =>
                          Navigator.of(context).pushNamed('/dashboard'),
                      child: const Text('Dashboard'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
