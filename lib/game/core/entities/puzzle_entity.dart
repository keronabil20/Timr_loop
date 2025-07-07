import 'package:flame/components.dart';

abstract class PuzzleElement extends PositionComponent {
  final String id;
  bool isActive = false;

  PuzzleElement({
    required this.id,
    required Vector2 position,
    required Vector2 size,
  }) : super(position: position, size: size);

  void activate() {
    isActive = true;
    // Trigger visual effect
  }

  void deactivate() {
    isActive = false;
    // Trigger visual effect
  }
}

class PressurePlate extends PuzzleElement {
  PressurePlate({
    required super.id,
    required super.position,
  }) : super(size: Vector2.all(32));

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    // Add sprite and hitbox
  }
}

class TimeDoor extends PuzzleElement {
  final int requiredGhosts;
  int currentGhosts = 0;

  TimeDoor({
    required super.id,
    required super.position,
    required this.requiredGhosts,
  }) : super(size: Vector2(32, 64));

  void addGhost() {
    currentGhosts++;
    if (currentGhosts >= requiredGhosts) {
      activate();
    }
  }

  void removeGhost() {
    currentGhosts--;
    if (currentGhosts < requiredGhosts) {
      deactivate();
    }
  }
}
