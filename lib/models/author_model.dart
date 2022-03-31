import 'package:flutter/material.dart';

class AuthorModel with ChangeNotifier {
  final String id;
  final String name;
  final String imageUrl;
  final int followers;
  final int following;

  AuthorModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.followers = 0,
    this.following = 0,
  });
}
