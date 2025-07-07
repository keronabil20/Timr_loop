import 'package:hive_flutter/hive_flutter.dart';
import 'package:time_loop/game/state/player_progress.dart';

class SaveManager {
  static const _boxName = 'timeloop_save';
  static late Box<PlayerProgress> _box;

  static Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox<PlayerProgress>(_boxName);

    if (_box.isEmpty) {
      await _box.put('progress', PlayerProgress());
    }
  }

  static PlayerProgress loadProgress() {
    return _box.get('progress') ?? PlayerProgress();
  }

  static Future<void> saveProgress(PlayerProgress progress) async {
    progress.lastPlayed = DateTime.now();
    await _box.put('progress', progress);
    await _syncWithCloud();
  }

  static Future<void> _syncWithCloud() async {
    // Implement Firebase/Firestore sync here
  }

  static Future<void> resetProgress() async {
    await _box.put('progress', PlayerProgress());
  }
}
