import 'package:flutter/material.dart';
import 'package:time_loop/game/state/player_progress.dart';
import 'package:time_loop/game/ui/widgets/futuristic_button.dart';
import 'package:provider/provider.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final progress = Provider.of<PlayerProgress>(context);

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0f3057), Color(0xFF00587a)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              const Text(
                'TIMELOOP QUEST',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyanAccent,
                  fontFamily: 'FuturisticFont',
                  shadows: [
                    Shadow(
                      blurRadius: 10,
                      color: Colors.blueAccent,
                      offset: Offset(0, 0),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Escape the temporal maze',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                ),
              ),
              const Spacer(),
              FuturisticButton(
                title: 'PLAY',
                icon: Icons.play_arrow,
                onPressed: () => Navigator.pushNamed(context, '/level_select'),
              ),
              const SizedBox(height: 20),
              FuturisticButton(
                title: 'CHARACTERS',
                icon: Icons.person,
                onPressed: () =>
                    Navigator.pushNamed(context, '/character_select'),
              ),
              const SizedBox(height: 20),
              FuturisticButton(
                title: 'SHOP',
                icon: Icons.shopping_cart,
                onPressed: () => Navigator.pushNamed(context, '/shop'),
              ),
              const SizedBox(height: 20),
              FuturisticButton(
                title: 'SETTINGS',
                icon: Icons.settings,
                onPressed: () => Navigator.pushNamed(context, '/settings'),
              ),
              const SizedBox(height: 20),
              FuturisticButton(
                title: 'TUTORIAL',
                icon: Icons.school,
                onPressed: () => Navigator.pushNamed(context, '/tutorial'),
              ),
              const Spacer(flex: 3),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.monetization_on, color: Colors.amber),
                  const SizedBox(width: 8),
                  Text(
                    '${progress.coins}',
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
