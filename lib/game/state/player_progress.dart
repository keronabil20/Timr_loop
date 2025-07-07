// lib/src/state/player_progress.dart
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class PlayerProgress with ChangeNotifier, HiveObjectMixin {
  @HiveField(0)
  int coins = 0;

  @HiveField(1)
  Set<String> unlockedCharacters = {'default'};

  @HiveField(2)
  String selectedCharacter = 'default';

  @HiveField(3)
  Set<String> unlockedAbilities = {};

  @HiveField(4)
  Set<String> unlockedSkins = {};

  @HiveField(5)
  Set<int> unlockedLevels = {1};

  @HiveField(6)
  Map<int, int> levelStars = {};

  @HiveField(7)
  DateTime lastPlayed = DateTime.now();

  void unlockNextLevel(int currentLevel) {
    unlockedLevels.add(currentLevel + 1);
    save();
  }

  void addCoins(int amount) {
    coins += amount;
    save();
  }
}
