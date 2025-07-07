// lib/src/game/core/entities/ghost.dart

import 'package:flame/components.dart';
import 'package:time_loop/game/core/entities/player.dart';

import 'package:time_loop/game/core/timeloop_game.dart';
import 'package:time_loop/game/mechanics/time_loop.dart';

class Ghost extends SpriteAnimationComponent with HasGameRef<TimeLoopGame> {
  final List<PlayerAction> actions;
  final int loopId;
  int currentActionIndex = 0;
  double elapsedTime = 0;

  Ghost.fromPlayer(Player player, this.loopId)
      : actions = player.actionHistory.clone(),
        super(
          size: Vector2.all(32),
        );

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    animation = await game.loadSpriteAnimation(
      'characters/ghost.png',
      SpriteAnimationData.sequenced(
        amount: 4,
        stepTime: 0.15,
        textureSize: Vector2.all(32),
      ),
    );
  }

  @override
  void update(double dt) {
    elapsedTime += dt;

    while (currentActionIndex < actions.length &&
        actions[currentActionIndex].timestamp <= elapsedTime) {
      _executeAction(actions[currentActionIndex]);
      currentActionIndex++;
    }

    super.update(dt);
  }

  void _executeAction(PlayerAction action) {
    position = action.position;

    if (action is TriggerAction) {
      gameRef.currentLevel.triggerElement(action.elementId);
    }

    // Handle other action types if needed
  }
}
