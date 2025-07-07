import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:time_loop/game/core/timeloop_game.dart';
import 'package:time_loop/game/state/player_progress.dart';
import 'package:time_loop/game/ui/screens/game_complete_screen.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatefulWidget {
  final int level;

  const GameScreen({super.key, required this.level});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late TimeLoopGame game;

  @override
  void initState() {
    super.initState();
    final progress = Provider.of<PlayerProgress>(context, listen: false);
    game = TimeLoopGame(
      level: widget.level,
      character: progress.selectedCharacter,
      abilities: progress.unlockedAbilities,
      progress: progress,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (!game.isPaused) {
          game.togglePause();
        }
        return false; // Prevent exiting the screen
      },
      child: Scaffold(
        body: GameWidget(
          game: game,
          overlayBuilderMap: {
            'PauseMenu': (context, gameRef) =>
                PauseMenu(game: gameRef as TimeLoopGame),
            'GameComplete': (context, gameRef) => GameCompleteScreen(
                  level: widget.level,
                ),
          },
        ),
      ),
    );
  }
}

class PauseMenu extends StatelessWidget {
  final TimeLoopGame game;

  const PauseMenu({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.black.withOpacity(0.7),
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'PAUSED',
                style: TextStyle(
                  fontSize: 36,
                  color: Colors.cyanAccent,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  game.togglePause();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: const Text('RESUME', style: TextStyle(fontSize: 20)),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  // Recreate the game instance
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GameScreen(level: game.level),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: const Text('RESTART', style: TextStyle(fontSize: 20)),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  game.resumeEngine();
                  Navigator.popUntil(
                      context, ModalRoute.withName('/level_select'));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                ),
                child: const Text('QUIT', style: TextStyle(fontSize: 20)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
