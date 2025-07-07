import 'package:flutter/material.dart';

class StarsDisplay extends StatelessWidget {
  final int stars;
  final double size;

  const StarsDisplay({
    super.key,
    required this.stars,
    this.size = 30,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (index) {
        return Icon(
          index < stars ? Icons.star : Icons.star_border,
          color: index < stars ? Colors.amber : Colors.white54,
          size: size,
        );
      }),
    );
  }
}
