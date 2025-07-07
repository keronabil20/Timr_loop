import 'package:flutter/material.dart';

class ShopItem {
  final String id;
  final String name;
  final String description;
  final int price;
  final String imagePath;
  final Color color;

  ShopItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
    this.color = Colors.blue,
  });

  IconData? get icon => null;
}

class ShopState extends ChangeNotifier {
  final List<ShopItem> characters = [
    ShopItem(
      id: 'cyber_runner',
      name: 'Cyber Runner',
      description: 'Increased movement speed',
      price: 500,
      imagePath: 'characters/cyber_runner.png',
      color: Colors.cyan,
    ),
    // More characters...
  ];

  final List<ShopItem> abilities = [
    ShopItem(
      id: 'time_slow',
      name: 'Time Slow',
      description: 'Slow down time for 3 seconds',
      price: 1000,
      imagePath: 'abilities/time_slow.png',
      color: Colors.purple,
    ),
    // More abilities...
  ];

  final List<ShopItem> skins = [
    ShopItem(
      id: 'neon_skin',
      name: 'Neon Skin',
      description: 'Glowing futuristic appearance',
      price: 300,
      imagePath: 'skins/neon.png',
      color: Colors.pink,
    ),
    // More skins...
  ];
}
