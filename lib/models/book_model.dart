import 'package:flutter/material.dart';

class BookModel with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final String authorId;
  final int rating;
  final int views;

  BookModel({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.authorId,
    required this.rating,
    this.views = 0,
  });
}
