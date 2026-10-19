import 'package:flutter/material.dart';
import 'package:cat_sound_analyzer/core/translations.dart';

class Analyzing extends StatelessWidget {
  const Analyzing({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t(context, 'Analyzing', 'التحليل')),
      ),
      body: Center(
        child: Text(
          t(context, 'Analyzing Unavailable Now', 'التحليل غير متاح حاليًا'),
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}