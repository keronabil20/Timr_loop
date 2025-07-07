import 'package:flutter/material.dart';
import 'package:time_loop/game/state/player_progress.dart';
import 'package:time_loop/game/state/shop_state.dart';
import 'package:time_loop/game/ui/widgets/character_tile.dart';
import 'package:time_loop/game/ui/widgets/shop_Item.dart';
import 'package:provider/provider.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final progress = Provider.of<PlayerProgress>(context);
    final shop = Provider.of<ShopState>(context);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Time Shop'),
          backgroundColor: Colors.transparent,
          elevation: 0,
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.person), text: 'Characters'),
              Tab(icon: Icon(Icons.bolt), text: 'Abilities'),
              Tab(icon: Icon(Icons.palette), text: 'Skins'),
            ],
          ),
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
          child: TabBarView(
            children: [
              // Characters Tab
              ListView.builder(
                padding: const EdgeInsets.only(top: 100),
                itemCount: shop.characters.length,
                itemBuilder: (context, index) {
                  final character = shop.characters[index];
                  return null;
                },
              ),

              // Abilities Tab
              ListView.builder(
                padding: const EdgeInsets.only(top: 100),
                itemCount: shop.abilities.length,
                itemBuilder: (context, index) {
                  final ability = shop.abilities[index];
                  return ShopItemTile(
                    item: ability, // Pass the existing ability object
                    isOwned: progress.unlockedAbilities.contains(ability.id),
                    onBuy: () {
                      if (progress.coins >= ability.price &&
                          !progress.unlockedAbilities.contains(ability.id)) {
                        progress.coins -= ability.price;
                        progress.unlockedAbilities.add(ability.id);
                        progress.save();
                      }
                    },
                  );
                },
              ),

              // Skins Tab
              ListView.builder(
                padding: const EdgeInsets.only(top: 100),
                itemCount: shop.skins.length,
                itemBuilder: (context, index) {
                  final skin = shop.skins[index];
                  return ShopItemTile(
                    item: skin, // Pass the existing skin object
                    isOwned: progress.unlockedSkins.contains(skin.id),
                    onBuy: () {
                      if (progress.coins >= skin.price &&
                          !progress.unlockedSkins.contains(skin.id)) {
                        progress.coins -= skin.price;
                        progress.unlockedSkins.add(skin.id);
                        progress.save();
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: const EdgeInsets.all(16),
          color: Colors.black54,
          child: Row(
            children: [
              const Icon(Icons.monetization_on, color: Colors.amber, size: 28),
              const SizedBox(width: 8),
              Text(
                '${progress.coins}',
                style: const TextStyle(fontSize: 24, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
