import 'package:flutter/material.dart';

import '../providers/book_provider.dart';

class BookItemTabs extends StatelessWidget {
  final String title;
  final String imageUrl;
  final int rating;
  final int views;

  const BookItemTabs({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.rating,
    required this.views,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              imageUrl,
              width: 120,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 100,
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Row(
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        size: 18,
                        color: Color(0xFF6e57d8),
                      ),
                      Text(
                        rating.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Color(0xFF6e57d8),
                        ),
                      ),
                    ],
                  ),
                  const SafeArea(child: SizedBox(width: 20)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xFFdbd4fd),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.remove_red_eye,
                          size: 18,
                          color: Color(0xFF6e57d8),
                        ),
                        Text(
                          views.toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color(0xFF6e57d8),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
