// lib/src/game/mechanics/time_loop.dart

import 'package:flame/game.dart';

abstract class PlayerAction {
  final PlayerActionType type;
  final Vector2 position;
  final double timestamp;

  PlayerAction({
    required this.type,
    required this.position,
    required this.timestamp,
  });
}

class MoveAction extends PlayerAction {
  MoveAction({
    required super.position,
    required super.timestamp,
  }) : super(
          type: PlayerActionType.move,
        );
}

class AbilityAction extends PlayerAction {
  final String abilityId;

  AbilityAction({
    required this.abilityId,
    required super.position,
    required super.timestamp,
  }) : super(
          type: PlayerActionType.ability,
        );
}

class TriggerAction extends PlayerAction {
  final String elementId;

  TriggerAction({
    required this.elementId,
    required super.position,
    required super.timestamp,
  }) : super(
          type: PlayerActionType.trigger,
        );
}

enum PlayerActionType {
  move,
  ability,
  trigger,
}

extension PlayerActionList on List<PlayerAction> {
  List<PlayerAction> clone() => map((action) {
        if (action is MoveAction) {
          return MoveAction(
            position: action.position.clone(),
            timestamp: action.timestamp,
          );
        } else if (action is AbilityAction) {
          return AbilityAction(
            abilityId: action.abilityId,
            position: action.position.clone(),
            timestamp: action.timestamp,
          );
        } else if (action is TriggerAction) {
          return TriggerAction(
            elementId: action.elementId,
            position: action.position.clone(),
            timestamp: action.timestamp,
          );
        }
        throw Exception('Unknown action type');
      }).toList();
}
