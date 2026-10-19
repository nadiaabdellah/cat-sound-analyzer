import 'package:flutter/material.dart';
import 'package:cat_sound_analyzer/core/translations.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t(context, 'About', 'حول التطبيق')),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.pets, size: 48),
            const SizedBox(height: 10),
            Text(t(context, 'Cat sound analyzer', 'محلل أصوات القط')),
            const SizedBox(height: 10),
            Text(
              t(context, 'An app that helps analyze cat sounds.',
                  'تطبيق يساعد في تحليل أصوات القط.'),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Text(t(context, 'Version 1.0.0', 'الإصدار 1.0.0')),
          ],
        ),
      ),
    );
  }
}