class Assets {
  // Images
  static const String playerSprite = 'assets/images/characters/default.png';
  static const String ghostSprite = 'assets/images/characters/ghost.png';
  static const String timeDoor = 'assets/images/environment/time_door.png';

  // Audio
  static const String mainBgm = 'assets/audio/bgm/main_theme.mp3';
  static const String loopSfx = 'assets/audio/sfx/loop_start.wav';

  // Levels
  static const String level01 = 'assets/levels/level_01.tmx';

  // Animations
  static const String timePortalRiv = 'assets/rive/time_portal.riv';

  // Fonts
  static const String futuristicFont = 'assets/fonts/futuristic_font.ttf';

  // Preload all assets
  static Future<void> preload() async {
    // Implement asset preloading
  }
}
