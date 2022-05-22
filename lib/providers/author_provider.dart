import 'package:flutter/material.dart';

import '../models/author_model.dart';

class AuthorProvider with ChangeNotifier {
  List<AuthorModel> _list = [
    AuthorModel(
      id: '1',
      name: 'Admin12',
      imageUrl:
          'https://images.unsplash.com/photo-1526656001029-20a71b17f7ba?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1074&q=80',
      email: 'test@gmail.com',
      followers: 465,
      following: 4,
    ),
  ];
  List<AuthorModel> get list {
    return [..._list];
  }

  AuthorModel findById(String id) {
    return _list.firstWhere((author) => author.id == id);
  }
}
