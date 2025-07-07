enum PuzzleDependencyType {
  activate,
  deactivate,
  toggle,
  hold,
}

class PuzzleDependency {
  final String targetId;
  final PuzzleDependencyType type;
  final int requiredGhosts;

  PuzzleDependency({
    required this.targetId,
    required this.type,
    this.requiredGhosts = 1,
  });
}

class PuzzleSystem {
  final Map<String, List<PuzzleDependency>> _dependencies = {};

  void registerDependency(String triggerId, PuzzleDependency dependency) {
    _dependencies.putIfAbsent(triggerId, () => []).add(dependency);
  }
}
