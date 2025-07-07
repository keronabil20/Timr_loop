import 'package:flutter/material.dart';
import 'package:time_loop/game/state/player_progress.dart';
import 'package:time_loop/game/ui/widgets/level_card.dart';
import 'package:provider/provider.dart';

class LevelSelectScreen extends StatelessWidget {
  const LevelSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Level'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => Navigator.pushNamed(context, '/tutorial'),
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [Color(0xFF1b262c), Color(0xFF0f4c75)],
            center: Alignment.topRight,
            radius: 1.5,
          ),
        ),
        child: Consumer<PlayerProgress>(
          builder: (context, progress, child) {
            return GridView.builder(
              padding: const EdgeInsets.only(
                  top: 100, left: 20, right: 20, bottom: 20),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                childAspectRatio: 1.0,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              itemCount: 15,
              itemBuilder: (context, index) {
                final level = index + 1;
                return LevelCard(
                  level: level,
                  locked: !progress.unlockedLevels.contains(level),
                  stars: progress.levelStars[level] ?? 0,
                  onTap: () {
                    if (progress.unlockedLevels.contains(level)) {
                      Navigator.pushNamed(
                        context,
                        '/game',
                        arguments: level,
                      );
                    }
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
