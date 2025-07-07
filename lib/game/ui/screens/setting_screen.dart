import 'package:flutter/material.dart';
import 'package:time_loop/game/state/settings_state.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsState>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF222831), Color(0xFF393e46)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: ListView(
          padding:
              const EdgeInsets.only(top: 100, left: 20, right: 20, bottom: 40),
          children: [
            const Text(
              'Audio Settings',
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.cyanAccent,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            SwitchListTile(
              title: const Text(
                'Enable Music',
                style: TextStyle(color: Colors.white),
              ),
              value: settings.musicEnabled,
              onChanged: (value) {
                settings.musicEnabled = value;
                settings.save();
              },
            ),
            Slider(
              value: settings.musicVolume,
              min: 0,
              max: 1,
              divisions: 10,
              label: 'Music Volume: ${(settings.musicVolume * 100).toInt()}%',
              onChanged: settings.musicEnabled
                  ? (value) {
                      settings.musicVolume = value;
                      settings.save();
                    }
                  : null,
            ),
            const Divider(color: Colors.white24),
            SwitchListTile(
              title: const Text(
                'Enable Sound Effects',
                style: TextStyle(color: Colors.white),
              ),
              value: settings.sfxEnabled,
              onChanged: (value) {
                settings.sfxEnabled = value;
                settings.save();
              },
            ),
            Slider(
              value: settings.sfxVolume,
              min: 0,
              max: 1,
              divisions: 10,
              label: 'SFX Volume: ${(settings.sfxVolume * 100).toInt()}%',
              onChanged: settings.sfxEnabled
                  ? (value) {
                      settings.sfxVolume = value;
                      settings.save();
                    }
                  : null,
            ),
            const SizedBox(height: 40),
            const Text(
              'Game Settings',
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.cyanAccent,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            SwitchListTile(
              title: const Text(
                'Enable Cloud Sync',
                style: TextStyle(color: Colors.white),
              ),
              value: settings.cloudSaveEnabled,
              onChanged: (value) {
                settings.cloudSaveEnabled = value;
                settings.save();
              },
            ),
            SwitchListTile(
              title: const Text(
                'Show Tutorial Hints',
                style: TextStyle(color: Colors.white),
              ),
              value: settings.showTutorialHints,
              onChanged: (value) {
                settings.showTutorialHints = value;
                settings.save();
              },
            ),
            const SizedBox(height: 40),
            const Text(
              'Controls',
              style: TextStyle(
                  fontSize: 22,
                  color: Colors.cyanAccent,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const ListTile(
              title: Text(
                'Control Scheme: Virtual Joystick',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Reset progress confirmation
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.withOpacity(0.3),
                ),
                child: const Text('Reset Game Progress'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
