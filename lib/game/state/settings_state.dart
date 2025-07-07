import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

@HiveType(typeId: 1)
class SettingsState extends HiveObject with ChangeNotifier {
  @HiveField(0)
  bool _musicEnabled = true;

  @HiveField(1)
  double _musicVolume = 0.7;

  @HiveField(2)
  bool _sfxEnabled = true;

  @HiveField(3)
  double _sfxVolume = 0.8;

  @HiveField(4)
  bool _cloudSaveEnabled = true;

  @HiveField(5)
  bool _showTutorialHints = true;

  bool get musicEnabled => _musicEnabled;
  double get musicVolume => _musicVolume;
  bool get sfxEnabled => _sfxEnabled;
  double get sfxVolume => _sfxVolume;
  bool get cloudSaveEnabled => _cloudSaveEnabled;
  bool get showTutorialHints => _showTutorialHints;

  set musicEnabled(bool value) {
    _musicEnabled = value;
    save();
    notifyListeners();
  }

  set musicVolume(double value) {
    _musicVolume = value.clamp(0.0, 1.0);
    save();
    notifyListeners();
  }

  set sfxEnabled(bool value) {
    _sfxEnabled = value;
    save();
    notifyListeners();
  }

  set sfxVolume(double value) {
    _sfxVolume = value.clamp(0.0, 1.0);
    save();
    notifyListeners();
  }

  set cloudSaveEnabled(bool value) {
    _cloudSaveEnabled = value;
    save();
    notifyListeners();
  }

  set showTutorialHints(bool value) {
    _showTutorialHints = value;
    save();
    notifyListeners();
  }
}
