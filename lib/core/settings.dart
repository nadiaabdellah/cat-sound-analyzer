import 'package:flutter/material.dart';

final ValueNotifier<bool> darkModeNotifier = ValueNotifier<bool>(false);

final ValueNotifier<Locale> languageNotifier =
    ValueNotifier<Locale>(const Locale('en'));