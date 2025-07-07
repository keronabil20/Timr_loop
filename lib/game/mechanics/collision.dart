import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:time_loop/game/core/entities/player.dart';
import 'package:time_loop/game/core/entities/player_types.dart';

class TimeLoopCollisionSystem {
  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent a,
    PositionComponent b,
  ) {
    if (a is Player && b is ExitZone) {
      (a).reachedExit = true;
    }

    if (a is Player && b is Hazard) {
      (a).die();
    }
  }
}
