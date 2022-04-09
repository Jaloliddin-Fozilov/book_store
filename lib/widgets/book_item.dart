import 'package:flutter/material.dart';

class BookItem extends StatelessWidget {
  const BookItem({
    Key? key,
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.price,
  }) : super(key: key);

  final String id;
  final String imageUrl;
  final String title;
  final double price;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              imageUrl,
              width: 100,
              height: 130,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            title,
          ),
          const SizedBox(
            height: 5,
          ),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: const Color(0xFFd4ccfa),
            ),
            child: Text(
              '\$$price',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
