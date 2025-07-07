import 'package:flame/components.dart';
import 'package:flame/input.dart';
import 'package:flame/effects.dart';
import 'package:flame/collisions.dart';
import 'package:flutter/services.dart';
import 'package:time_loop/game/core/entities/player_types.dart';
import 'package:time_loop/game/core/timeloop_game.dart';
import 'package:time_loop/game/mechanics/time_loop.dart';

class Player extends SpriteAnimationComponent
    with KeyboardHandler, CollisionCallbacks, HasGameRef<TimeLoopGame> {
  // Character properties
  final String character;
  final Set<String> abilities;

  // Movement properties
  final double moveSpeed = 200;
  final Vector2 velocity = Vector2.zero();
  Vector2 lastSafePosition = Vector2.zero();

  // Game state
  final List<PlayerAction> actionHistory = [];
  bool isAlive = true;
  bool reachedExit = false;
  bool isInvulnerable = false;

  // Components
  late final CircleHitbox hitbox;
  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation runAnimation;

  Player({
    required this.character,
    required this.abilities,
    required Vector2 position,
  }) : super(
          position: position,
          size: Vector2.all(32),
          anchor: Anchor.center,
        ) {
    lastSafePosition = position.clone();
  }

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // Load animations
    idleAnimation = await _loadAnimation('idle', 4, 0.2);
    runAnimation = await _loadAnimation('run', 6, 0.1);
    animation = idleAnimation;

    // Setup hitbox
    hitbox = CircleHitbox(
      radius: 12,
      isSolid: true,
    );
    add(hitbox);

    // Setup abilities
    if (abilities.contains('phase_shift')) {
      hitbox.collisionType = CollisionType.passive;
    }
  }

  Future<SpriteAnimation> _loadAnimation(
      String state, int frames, double stepTime) async {
    return await game.loadSpriteAnimation(
      'characters/$character/$state.png',
      SpriteAnimationData.sequenced(
        amount: frames,
        stepTime: stepTime,
        textureSize: Vector2.all(32),
      ),
    );
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Update position based on velocity
    position += velocity * dt;

    // Record movement action
    if (velocity.length2 > 0) {
      _recordAction(MoveAction(
        position: position.clone(),
        timestamp: gameRef.currentTime(),
      ));
    }

    // Animation state
    animation = velocity.length2 > 0 ? runAnimation : idleAnimation;

    // Flip sprite based on direction
    if (velocity.x != 0) {
      flipHorizontally;
    }
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);

    if (other is Hazard && !isInvulnerable) {
      die();
    } else if (other is ExitZone) {
      reachedExit = true;
      gameRef.onLevelComplete();
    } else if (other is Collectible) {
      _collectItem(other);
    }
  }

  void _recordAction(PlayerAction action) {
    actionHistory.add(action);
  }

  void useAbility(String abilityId) {
    if (!abilities.contains(abilityId)) return;

    _recordAction(AbilityAction(
      abilityId: abilityId,
      position: position.clone(),
      timestamp: gameRef.currentTime(),
    ));

    switch (abilityId) {
      case 'phase_shift':
        _activatePhaseShift();
        break;
      // Add more abilities as needed
    }
  }

  void _activatePhaseShift() {
    isInvulnerable = true;
    add(OpacityEffect.fadeOut(
      EffectController(
        duration: 0.5,
        alternate: true,
        repeatCount: 3,
      ),
      onComplete: () => isInvulnerable = false,
    ));
  }

  void _collectItem(Collectible item) {
    _recordAction(TriggerAction(
      elementId: item.id,
      position: position.clone(),
      timestamp: gameRef.currentTime(),
    ));

    gameRef.coinsEarned += item.value;
    item.removeFromParent();
  }

  void die() {
    if (!isAlive) return;

    isAlive = false;
    animation = idleAnimation;
    velocity.setZero();

    add(SequenceEffect(
      [
        OpacityEffect.fadeOut(EffectController(duration: 0.2)),
        ScaleEffect.to(
          Vector2.all(1.5),
          EffectController(duration: 0.2),
        ),
      ],
      onComplete: () {
        removeFromParent();
        gameRef.onPlayerDie();
      },
    ));
  }

  void resetPosition() {
    position = gameRef.currentLevel.startPosition.clone();
    lastSafePosition = position.clone();
    isAlive = true;
    reachedExit = false;
    velocity.setZero();
  }

  // Input handling
  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    velocity.setZero();

    if (keysPressed.contains(LogicalKeyboardKey.arrowLeft)) {
      velocity.x = -moveSpeed;
    }
    if (keysPressed.contains(LogicalKeyboardKey.arrowRight)) {
      velocity.x = moveSpeed;
    }
    if (keysPressed.contains(LogicalKeyboardKey.arrowUp)) {
      velocity.y = -moveSpeed;
    }
    if (keysPressed.contains(LogicalKeyboardKey.arrowDown)) {
      velocity.y = moveSpeed;
    }

    // Normalize diagonal movement
    if (velocity.length2 > 0) {
      velocity.normalize();
      velocity.scale(moveSpeed);
    }

    return true;
  }

  void teleport(Vector2 newPosition) {
    position = newPosition.clone();
    lastSafePosition = position.clone();
    _recordAction(MoveAction(
      position: position.clone(),
      timestamp: gameRef.currentTime(),
    ));
  }
}
