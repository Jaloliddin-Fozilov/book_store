import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/author_model.dart';

class AuthorProvider with ChangeNotifier {
  String? _authToken;
  String? _userId;
  void setParams(String? authToken, String? userId) {
    _authToken = authToken;
    _userId = userId;
  }

  List<AuthorModel> _list = [
    // AuthorModel(
    //   id: '1',
    //   name: 'Admin12',
    //   imageUrl:
    //       'https://images.unsplash.com/photo-1526656001029-20a71b17f7ba?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1074&q=80',
    //   email: 'test@gmail.com',
    //   followers: 465,
    //   following: 4,
    // ),
  ];
  List<AuthorModel> get list {
    return [..._list];
  }

  Future<void> getAuthorsFromFirebase() async {
    final url = Uri.parse(
        'https://book-store-marketplace-default-rtdb.firebaseio.com/authors.json?auth=$_authToken');
    try {
      final response = await http.get(url);
      if (jsonDecode(response.body) != null) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final List<AuthorModel> loadedAuthors = [];
        data.forEach(
          (authorId, authorData) {
            loadedAuthors.add(
              AuthorModel(
                id: authorData['id'],
                name: authorData['name'],
                imageUrl: authorData['imageUrl'],
                email: authorData['email'],
                followers: authorData['followers'],
                following: authorData['following'],
              ),
            );
          },
        );

        _list = loadedAuthors;
        notifyListeners();
      }
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<void> addAuthor(AuthorModel author) async {
    final url = Uri.parse(
        'https://book-store-marketplace-default-rtdb.firebaseio.com/authors.json?auth=$_authToken');

    try {
      final response = await http.post(
        url,
        body: jsonEncode(
          {
            'id': author.id,
            'name': author.name,
            'imageUrl': author.imageUrl,
            'email': author.email,
            'followers': author.followers,
            'following': author.following,
          },
        ),
      );
      print('add not working ${response.body}');
      final authorIdFromFirebase =
          (jsonDecode(response.body) as Map<String, dynamic>)['name'];
      final newAuthor = AuthorModel(
        id: authorIdFromFirebase,
        name: author.name,
        imageUrl: author.imageUrl,
        email: author.email,
        followers: author.followers,
        following: author.following,
      );
      _list.add(newAuthor);
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  AuthorModel findById(String id) {
    return _list.firstWhere((author) => author.id == id);
  }
}
