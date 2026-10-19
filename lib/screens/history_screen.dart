import 'package:flutter/material.dart';
import 'package:cat_sound_analyzer/core/translations.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t(context, 'History', 'السجل')),
      ),
      body: Center(
        child: Text(
          t(context, 'No history yet', 'لا توجد تسجيلات بعد'),
          style: const TextStyle(fontSize: 28),
        ),
      ),
    );
  }
}