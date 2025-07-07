import 'package:flame/game.dart';
import 'package:time_loop/game/core/levels/level.dart';

class LevelManager {
  static Future<Level> loadLevel(int levelId) async {
    switch (levelId) {
      case 1:
        return Level01();

      default:
        throw Exception('Level $levelId not found');
    }
  }
}

class Level01 extends Level {
  Level01()
      : super(
          id: 1,
          name: 'The First Loop',
          startPosition: Vector2(100, 300),
          exitPosition: Vector2(700, 300),
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    await loadMap('levels/level_01.tmx');
  }
}
