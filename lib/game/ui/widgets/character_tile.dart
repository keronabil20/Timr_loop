import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:time_loop/game/state/shop_state.dart';

class CharacterTile extends StatelessWidget {
  final CharacterItem character;
  final bool isOwned;
  final bool isSelected;
  final VoidCallback onSelect;
  final VoidCallback onBuy;

  const CharacterTile({
    super.key,
    required this.character,
    required this.isOwned,
    required this.isSelected,
    required this.onSelect,
    required this.onBuy,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: isSelected ? Colors.blueAccent.withOpacity(0.2) : null,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Character image/icon
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(30),
                image: character.imageUrl != null
                    ? DecorationImage(
                        image: NetworkImage(character.imageUrl!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: character.imageUrl == null
                  ? const Icon(Icons.person, size: 40, color: Colors.white)
                  : null,
            ),
            const SizedBox(width: 16),

            // Character info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    character.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    character.description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                ],
              ),
            ),

            // Action button
            if (isOwned)
              isSelected
                  ? const Text('Selected',
                      style: TextStyle(color: Colors.green))
                  : ElevatedButton(
                      onPressed: onSelect,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      child: const Text('Select'),
                    )
            else
              ElevatedButton(
                onPressed: onBuy,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                ),
                child: Text('${character.price} Coins'),
              ),
          ],
        ),
      ),
    );
  }
}

class CharacterItem extends ShopItem {
  final String? imageUrl;

  CharacterItem({
    required super.id,
    required super.name,
    required super.description,
    required super.price,
    this.imageUrl,
    required super.imagePath,
  });
}
