import 'package:flutter/material.dart';

String t(BuildContext context, String en, String ar) {
  final isArabic = Localizations.localeOf(context).languageCode == 'ar';
  return isArabic ? ar : en;
}