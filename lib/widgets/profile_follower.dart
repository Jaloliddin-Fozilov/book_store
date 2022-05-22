import 'package:flutter/material.dart';

class ProfileFollower extends StatelessWidget {
  const ProfileFollower({
    Key? key,
    required this.text,
    required this.number,
  }) : super(key: key);

  final String text;
  final int number;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.purple[900],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.people,
            color: Colors.white,
          ),
          Text(
            text,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
          Text(
            number.toString(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
