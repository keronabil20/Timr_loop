import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:time_loop/game/core/entities/player.dart';

// Marker component for hazards
class Hazard extends PositionComponent with CollisionCallbacks {}

// Exit zone component
class ExitZone extends PositionComponent with CollisionCallbacks {}

// Collectible items
class Collectible extends PositionComponent with CollisionCallbacks {
  final String id;
  final int value;

  Collectible({
    required this.id,
    required this.value,
    required Vector2 position,
    required Vector2 size,
  }) : super(position: position, size: size);
}

// Player state extension
extension PlayerState on Player {
  bool get isMoving => velocity.length2 > 0;
  bool get isUsingAbility => isInvulnerable;
  bool get canInteract => isAlive && !reachedExit;
}
