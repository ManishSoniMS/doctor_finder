import 'package:flutter/material.dart';

class RatingStars extends StatelessWidget {
  const RatingStars({super.key, required this.rating});
  final int rating;
  @override
  Widget build(BuildContext context) {
    String stars = '';

    for (int i = 0; i < rating; i++) {
      stars += '⭐';
    }

    stars = stars.trim();
    return Text(stars, style: TextStyle(fontSize: 14.0));
  }
}
