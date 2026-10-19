import 'package:flutter/material.dart';
import 'package:cat_sound_analyzer/core/translations.dart';
import 'package:cat_sound_analyzer/screens/recording_screen.dart';
import 'package:cat_sound_analyzer/screens/history_screen.dart';
import 'package:cat_sound_analyzer/screens/settings_screen.dart';

class CatSound extends StatelessWidget {
  CatSound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Cat Sound")),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Recording()),
                );
              },
              child: Text(t(context, '🎙 Recorder', '🎙 التسجيل')),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => History()),
                );
              },
              child: Text(t(context, '📝 History', '📝 التاريخ')),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Settings()),
                );
              },
              child: Text(t(context, '⚙ Settings', '⚙ الإعدادات')),
            ),
          ],
        ),
      ),
    );
  }
}