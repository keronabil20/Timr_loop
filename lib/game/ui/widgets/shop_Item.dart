import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:time_loop/game/state/shop_state.dart';

class ShopItemTile extends StatelessWidget {
  final ShopItem item;
  final bool isOwned;
  final VoidCallback onBuy;

  const ShopItemTile({
    super.key,
    required this.item,
    required this.isOwned,
    required this.onBuy,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Item icon
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(item.icon, size: 30, color: Colors.white),
            ),
            const SizedBox(width: 16),

            // Item info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.description,
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
              const Icon(Icons.check_circle, color: Colors.green, size: 30)
            else
              ElevatedButton(
                onPressed: onBuy,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                ),
                child: Text('${item.price} Coins'),
              ),
          ],
        ),
      ),
    );
  }
}
