import 'package:flutter/material.dart';

import '../models/book_model.dart';

class BookProvider with ChangeNotifier {
  List<BookModel> _list = [
    BookModel(
      id: '1',
      title: 'The Wonderful Adventures of Phra the Phoenician',
      description:
          'Imagine you fall asleep today and wake up in three hundred years! That\'s the story of Phra, the Phoenician, who has a rare gift of death-like sleep which makes him almost immortal. A reader gets introduced to Phra, a traveling Phoenician warrior, as he saves a slave girl, falls in love with her, and decides to bring her back home to Britannia. From there starts his incredible life journey through different eras of British history, ending up in the Elizabethan age. Each of his long periods of sleep relates to an invasion. For the first time, it happens during Caesar\'s invasion of Britain. ',
      price: 12.0,
      imageUrl: 'https://www.free-ebooks.net/2d_covers/large/1647006254.jpg',
      authorId: '1',
      rating: 4,
      views: 134,
    ),
    BookModel(
      id: '2',
      title: 'The Black Star: A School Story for Boys',
      description:
          'Salmon\'s House, to which division of Deepwater College Jack Symonds and his study-mates belonged, was famous for its exclusive set of youngsters—a band who had clubbed together for their own advancement, and the confusion of everybody else, and had named themselves the Crees. It amounted in the long run to a sort of secret society; it had its president, but no one outside its numbers knew who he was. It was never known for certain who the members were, either; and that gave a delightful uncertainty to everything connected with it.',
      price: 18.0,
      imageUrl: 'https://www.free-ebooks.net/2d_covers/large/1648126509.jpg',
      authorId: '1',
      rating: 5,
      views: 100,
    ),
    BookModel(
      id: '3',
      title:
          'Programming Fundamentals - A Modular Structured Approach using C++',
      description:
          'This textbook on Programming Fundamentals is structured around a modular approach using C++.  It mostly covers Modular/Sturctured college course. ',
      price: 10.0,
      imageUrl: 'https://www.free-ebooks.net/2d_covers/large/1396835971.jpg',
      authorId: '1',
      rating: 3,
      views: 40,
    ),
  ];
  List<BookModel> get list {
    return [..._list];
  }
}
