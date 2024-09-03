import 'package:flutter/material.dart';

class StarRating extends StatelessWidget {
  final double rating;

  final double starSize;
  final Color filledStarColor;
  final Color unfilledStarColor;

  const StarRating({
    super.key,
    required this.rating,
    this.starSize = 24.0,
    this.filledStarColor = Colors.amber,
    this.unfilledStarColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < rating.floor()) {
          return Icon(Icons.star, size: starSize, color: filledStarColor);
        } else if (index < rating) {
          return Icon(Icons.star_half, size: starSize, color: filledStarColor);
        } else {
          return Icon(Icons.star_border,
              size: starSize, color: unfilledStarColor);
        }
      }),
    );
  }
}
