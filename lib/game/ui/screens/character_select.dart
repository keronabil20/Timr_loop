import 'package:flutter/material.dart';
import 'package:time_loop/game/state/player_progress.dart';
import 'package:time_loop/game/state/shop_state.dart';
import 'package:provider/provider.dart';

class CharacterSelectScreen extends StatelessWidget {
  const CharacterSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final progress = Provider.of<PlayerProgress>(context);
    final shop = Provider.of<ShopState>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Character'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1a1a2e), Color(0xFF16213e)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 100),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(20),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemCount: shop.characters.length,
                itemBuilder: (context, index) {
                  final character = shop.characters[index];
                  final isOwned =
                      progress.unlockedCharacters.contains(character.id);
                  final isSelected = progress.selectedCharacter == character.id;
                  return null;
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              color: Colors.black54,
              child: Row(
                children: [
                  const Icon(Icons.monetization_on,
                      color: Colors.amber, size: 28),
                  const SizedBox(width: 8),
                  Text(
                    '${progress.coins}',
                    style: const TextStyle(fontSize: 24, color: Colors.white),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () => Navigator.pushNamed(context, '/shop'),
                    child: const Text(
                      'GET MORE CHARACTERS',
                      style: TextStyle(color: Colors.cyanAccent),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
