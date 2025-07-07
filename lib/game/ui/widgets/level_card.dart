import 'package:flutter/material.dart';
import 'package:time_loop/game/ui/widgets/stars_display.dart';

class LevelCard extends StatelessWidget {
  final int level;
  final bool locked;
  final int stars;
  final VoidCallback onTap;

  const LevelCard({
    super.key,
    required this.level,
    required this.locked,
    required this.stars,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: locked ? null : onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: locked ? Colors.grey.shade800 : Colors.blueGrey.shade900,
          border: Border.all(
            color: locked ? Colors.grey : Colors.cyanAccent,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: locked ? Colors.transparent : Colors.cyan.withOpacity(0.3),
              blurRadius: 10,
              spreadRadius: 2,
            )
          ],
        ),
        child: Stack(
          children: [
            if (!locked)
              Positioned(
                top: 10,
                right: 10,
                child: StarsDisplay(stars: stars, size: 20),
              ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '$level',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: locked ? Colors.grey : Colors.cyanAccent,
                    ),
                  ),
                  if (locked)
                    const Icon(Icons.lock, color: Colors.grey, size: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
