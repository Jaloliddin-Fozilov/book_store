import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/book_model.dart';
import '../services/http_expection.dart';

class BookProvider with ChangeNotifier {
  List<BookModel> _list = [];

  String? _authToken;
  String? _userId;

  void setParams(String? authToken, String? userId) {
    _authToken = authToken;
    _userId = userId;
  }

  List<BookModel> get list {
    return [..._list];
  }

  Future<void> getProductsFromFirebase([bool filterByUser = false]) async {
    final filterString =
        filterByUser ? 'orderBy="authorId"&equalTo="$_userId"' : '';
    final url = Uri.parse(
        'https://book-store-marketplace-default-rtdb.firebaseio.com/products.json?auth=$_authToken&$filterString');
    try {
      final response = await http.get(url);
      if (jsonDecode(response.body) != null) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        final List<BookModel> loadedProducts = [];
        data.forEach(
          (productId, productData) {
            loadedProducts.add(
              BookModel(
                id: productId,
                title: productData['title'],
                description: productData['description'],
                price: double.parse(productData['price'].toString()),
                imageUrl: productData['imageUrl'],
                authorId: productData['authorId'],
                rating: int.parse(productData['rating']),
              ),
            );
          },
        );

        _list = loadedProducts;
        notifyListeners();
      }
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  Future<void> addProduct(BookModel book) async {
    final url = Uri.parse(
        'https://book-store-marketplace-default-rtdb.firebaseio.com/products.json?auth=$_authToken');

    try {
      print(jsonEncode(
        {
          'title': book.title,
          'description': book.description,
          'price': book.price,
          'imageUrl': book.imageUrl,
          'authorId': book.authorId,
          'rating': book.rating,
        },
      ));
      final response = await http.post(
        url,
        body: jsonEncode(
          {
            'title': book.title,
            'description': book.description,
            'price': book.price,
            'imageUrl': book.imageUrl,
            'authorId': book.authorId,
            'rating': book.rating,
          },
        ),
      );
      print('${response.body} 2222222222222');
      final name = (jsonDecode(response.body) as Map<String, dynamic>)['name'];
      final newProduct = BookModel(
        id: name,
        title: book.title,
        description: book.description,
        price: book.price,
        imageUrl: book.imageUrl,
        authorId: book.authorId,
        rating: book.rating,
      );
      _list.add(newProduct);
      notifyListeners();
    } catch (error) {
      print(error);
      rethrow;
    }
  }

  Future<void> updateProduct(BookModel updatedProduct) async {
    final productIndex =
        _list.indexWhere((books) => books.id == updatedProduct.id);
    if (productIndex >= 0) {
      final url = Uri.parse(
          'https://book-store-marketplace-default-rtdb.firebaseio.com/products/${updatedProduct.id}.json?auth=$_authToken');
      try {
        await http.patch(
          url,
          body: jsonEncode(
            {
              'title': updatedProduct.title,
              'description': updatedProduct.description,
              'price': updatedProduct.price,
              'imageUrl': updatedProduct.imageUrl,
              'rating': updatedProduct.rating,
            },
          ),
        );

        _list[productIndex] = updatedProduct;
        notifyListeners();
      } catch (e) {
        rethrow;
      }
    }
  }

  Future<void> deleteProduct(String id) async {
    final url = Uri.parse(
        'https://book-store-marketplace-default-rtdb.firebaseio.com/products/$id.json?auth=$_authToken');
    try {
      var deletingProduct = _list.firstWhere((books) => books.id == id);
      final productIndex = _list.indexWhere((books) => books.id == id);
      _list.removeWhere((books) => books.id == id);
      notifyListeners();

      final respone = await http.delete(url);
      if (respone.statusCode >= 400) {
        _list.insert(productIndex, deletingProduct);
        notifyListeners();
        throw HttpExpection('Kechirasiz, mahsulot o\'chirishda xatolik');
      }
    } catch (e) {
      rethrow;
    }
  }

  List<BookModel> get bestRatingList {
    return _list.where((book) => book.rating >= 4).toList();
  }

  List<BookModel> get popularBooksList {
    return _list.where((book) => book.views >= 100).toList();
  }

  BookModel findById(String productId) {
    return _list.firstWhere(
      (books) => books.id == productId,
    );
  }

  List<BookModel> authorBook(String authorId) {
    return _list.where((book) => book.authorId == authorId).toList();
  }
}
