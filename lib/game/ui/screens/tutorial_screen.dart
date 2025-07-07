import 'package:flutter/material.dart';
import 'package:time_loop/game/ui/widgets/futuristic_button.dart';

class TutorialScreen extends StatelessWidget {
  const TutorialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tutorial'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0f3057), Color(0xFF00587a)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: PageView(
            children: [
              _buildTutorialPage(
                title: 'Time Loop Mechanics',
                content:
                    'Each time you fail, a ghost of your previous attempt is created. These ghosts repeat your actions and can help you solve puzzles.',
                image: 'ghost_mechanics',
              ),
              _buildTutorialPage(
                title: 'Solving Puzzles',
                content:
                    'Use your ghosts to activate switches, distract enemies, and hold doors open. Plan your actions across multiple time loops.',
                image: 'puzzle_solving',
              ),
              _buildTutorialPage(
                title: 'Avoiding Hazards',
                content:
                    'Watch out for temporal traps! Some hazards can only be avoided by coordinating with your past selves.',
                image: 'hazards',
              ),
              _buildTutorialPage(
                title: 'Character Abilities',
                content:
                    'Unlock special abilities like time slow, phase shift, and temporal echo to overcome difficult challenges.',
                image: 'abilities',
                showButton: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTutorialPage({
    required String title,
    required String content,
    required String image,
    bool showButton = false,
  }) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black26,
              ),
              child: Center(
                child: Image.asset(
                  'assets/images/tutorial/$image.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Text(
            title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.cyanAccent,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            content,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white70,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          if (showButton) const SizedBox(height: 20),
        ],
      ),
    );
  }
}
