import 'package:flutter/material.dart';
import 'package:time_loop/assets.dart';
import 'package:time_loop/game/state/save_manager.dart';
import 'package:time_loop/timeloop_quest_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await SaveManager.init();

  // Preload assets
  await Assets.preload();

  runApp(const TimeLoopQuestApp());
}
