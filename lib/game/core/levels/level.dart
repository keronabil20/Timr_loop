import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:time_loop/game/core/entities/puzzle_entity.dart';

abstract class Level extends Component {
  final int id;
  final String name;
  final Vector2 startPosition;
  final Vector2 exitPosition;
  final Map<String, PuzzleElement> elements = {};

  Level({
    required this.id,
    required this.name,
    required this.startPosition,
    required this.exitPosition,
  });

  Future<void> loadMap(String mapPath) async {
    final tiledMap = await TiledComponent.load(mapPath, Vector2.all(16));
    add(tiledMap);

    // Parse objects layer for puzzle elements
    final objects = tiledMap.tileMap.getLayer<ObjectGroup>('objects');
    for (final obj in objects!.objects) {
      final element = _createPuzzleElement(obj);
      if (element != null) {
        elements[element.id] = element;
        add(element);
      }
    }
  }

  PuzzleElement? _createPuzzleElement(TiledObject obj) {
    switch (obj.class_) {
      case 'PressurePlate':
        return PressurePlate(
          id: obj.name,
          position: Vector2(obj.x, obj.y),
        );
      case 'TimeDoor':
        return TimeDoor(
          id: obj.name,
          position: Vector2(obj.x, obj.y),
          requiredGhosts: obj.properties.getValue('requiredGhosts'),
        );
      // Other element types...
      default:
        return null;
    }
  }

  void triggerElement(String elementId) {
    elements[elementId]?.activate();
  }
}
