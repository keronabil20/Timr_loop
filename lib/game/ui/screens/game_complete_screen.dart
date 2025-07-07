import 'package:flutter/material.dart';
import 'package:time_loop/game/state/player_progress.dart';
import 'package:time_loop/game/ui/widgets/futuristic_button.dart';
import 'package:time_loop/game/ui/widgets/stars_display.dart';
import 'package:provider/provider.dart';

class GameCompleteScreen extends StatelessWidget {
  final int level;

  const GameCompleteScreen({
    super.key,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    final progress = Provider.of<PlayerProgress>(context);

    progress.unlockedLevels.add(level + 1);
    progress.save();

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            colors: [Colors.indigo.shade900, Colors.black],
            center: Alignment.center,
            radius: 1.5,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'LEVEL COMPLETE!',
                style: TextStyle(
                  fontSize: 42,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyanAccent,
                  shadows: [
                    Shadow(
                      blurRadius: 10,
                      color: Colors.blueAccent,
                      offset: Offset(0, 0),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 40),
              const SizedBox(height: 50),
              FuturisticButton(
                title: 'NEXT LEVEL',
                icon: Icons.arrow_forward,
                onPressed: () {
                  Navigator.pushReplacementNamed(
                    context,
                    '/game',
                    arguments: level + 1,
                  );
                },
              ),
              const SizedBox(height: 20),
              FuturisticButton(
                title: 'LEVEL SELECT',
                icon: Icons.list,
                onPressed: () {
                  Navigator.popUntil(
                      context, ModalRoute.withName('/level_select'));
                },
              ),
              const SizedBox(height: 20),
              FuturisticButton(
                title: 'MAIN MENU',
                icon: Icons.home,
                onPressed: () {
                  Navigator.popUntil(context, ModalRoute.withName('/'));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
