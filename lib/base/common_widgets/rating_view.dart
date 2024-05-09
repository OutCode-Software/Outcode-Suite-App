import 'package:flutter/material.dart';

class RatingView extends StatelessWidget {
  const RatingView({
    required this.rating,
    this.size = 24.0,
    this.color = Colors.amber,
    this.filledIcon = Icons.star,
    this.unfilledIcon = Icons.star_border,
    super.key,
  });
  final int rating;
  final double size;
  final Color color;
  final IconData filledIcon;
  final IconData unfilledIcon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < rating) {
          return Icon(
            filledIcon,
            size: size,
            color: color,
          );
        } else {
          return Icon(
            unfilledIcon,
            size: size,
            color: color,
          );
        }
      }),
    );
  }
}
