import 'package:flame/game.dart';
import 'package:flame/collisions.dart' show HasCollisionDetection;
import 'package:flame/input.dart';
import 'package:flame/components.dart';
import 'package:time_loop/game/core/entities/ghost.dart';
import 'package:time_loop/game/core/entities/player.dart';
import 'package:time_loop/game/core/levels/level.dart';
import 'package:time_loop/game/core/levels/level_manager.dart';
import 'package:time_loop/game/state/player_progress.dart';

class TimeLoopGame extends FlameGame with HasCollisionDetection {
  final int level;
  final String character;
  final Set<String> abilities;
  final PlayerProgress progress;

  int loopCount = 0;
  int coinsEarned = 0;
  int starsEarned = 0;
  bool isPaused = false;

  late Player player;
  final ghosts = <Ghost>[];
  late Level currentLevel;

  TimeLoopGame({
    required this.level,
    required this.character,
    required this.abilities,
    required this.progress,
  });

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    currentLevel = await LevelManager.loadLevel(level);
    add(currentLevel);

    player = Player(
      character: character,
      abilities: abilities,
      position: currentLevel.startPosition,
    );
    add(player);

    camera.follow(player);
    _startNewLoop();
  }

  void _startNewLoop() {
    loopCount++;
    final newGhost = Ghost.fromPlayer(player, loopCount);
    ghosts.add(newGhost);
    add(newGhost);
    player.resetPosition();
  }

  void onPlayerDie() {
    _startNewLoop();
  }

  void onLevelComplete() {
    starsEarned = _calculateStars();
    coinsEarned = _calculateCoins();
    overlays.add('GameComplete');
    pauseEngine();
  }

  int _calculateStars() {
    if (loopCount <= 3) return 3;
    if (loopCount <= 6) return 2;
    return 1;
  }

  int _calculateCoins() {
    return (100 * (4 - _calculateStars())) + (level * 50);
  }

  void togglePause() {
    if (isPaused) {
      resumeEngine();
      overlays.remove('PauseMenu');
    } else {
      pauseEngine();
      overlays.add('PauseMenu');
    }
    isPaused = !isPaused;
  }
}
