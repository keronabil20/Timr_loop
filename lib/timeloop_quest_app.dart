import 'package:flutter/material.dart';
import 'package:time_loop/game/state/player_progress.dart';
import 'package:time_loop/game/state/settings_state.dart';
import 'package:time_loop/game/state/shop_state.dart';
import 'package:time_loop/game/ui/screens/character_select.dart';
import 'package:time_loop/game/ui/screens/game_complete_screen.dart';
import 'package:time_loop/game/ui/screens/game_screen.dart';
import 'package:time_loop/game/ui/screens/level_selection.dart';
import 'package:time_loop/game/ui/screens/main_menu.dart';
import 'package:time_loop/game/ui/screens/setting_screen.dart';
import 'package:time_loop/game/ui/screens/shop_screen.dart';
import 'package:time_loop/game/ui/screens/tutorial_screen.dart';
import 'package:provider/provider.dart';

class TimeLoopQuestApp extends StatelessWidget {
  const TimeLoopQuestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PlayerProgress>(
          create: (context) => PlayerProgress(),
        ),
        ChangeNotifierProvider<SettingsState>(
          create: (context) => SettingsState(),
        ),
        ChangeNotifierProvider<ShopState>(
          create: (context) => ShopState(),
        ),
      ],
      child: MaterialApp(
        title: 'TimeLoop Quest',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          fontFamily: 'FuturisticFont',
          scaffoldBackgroundColor: Colors.transparent,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.white),
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const MainMenuScreen(),
          '/level_select': (context) => const LevelSelectScreen(),
          '/character_select': (context) => const CharacterSelectScreen(),
          '/shop': (context) => const ShopScreen(),
          '/settings': (context) => const SettingsScreen(),
          '/tutorial': (context) => const TutorialScreen(),
          '/game': (context) {
            final level = ModalRoute.of(context)!.settings.arguments as int?;
            return GameScreen(level: level ?? 1);
          },
          '/complete': (context) {
            final args = ModalRoute.of(context)!.settings.arguments as Map;
            return GameCompleteScreen(
              level: args['level'],
            );
          },
        },
      ),
    );
  }
}
