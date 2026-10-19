import 'package:flutter/material.dart';
import 'package:cat_sound_analyzer/core/settings.dart';
import 'package:cat_sound_analyzer/core/translations.dart';
import 'package:cat_sound_analyzer/screens/about_screen.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(t(context, 'Settings', 'الإعدادات')),
        centerTitle: true,
      ),
      body: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _sectionTitle(t(context, 'Preferences', 'التفضيلات')),
              Card(
                elevation: 0,
                color: scheme.surfaceContainerHighest.withOpacity(0.4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    ValueListenableBuilder<bool>(
                      valueListenable: darkModeNotifier,
                      builder: (context, isDark, _) {
                        return SwitchListTile(
                          secondary: const Icon(Icons.dark_mode_outlined),
                          title: Text(t(context, 'Dark Mode', 'الوضع الداكن')),
                          value: isDark,
                          onChanged: (value) {
                            darkModeNotifier.value = value;
                          },
                        );
                      },
                    ),
                    const Divider(height: 1, indent: 16, endIndent: 16),
                    ValueListenableBuilder<Locale>(
                      valueListenable: languageNotifier,
                      builder: (context, locale, _) {
                        return ListTile(
                          leading: const Icon(Icons.language),
                          title: Text(t(context, 'Language', 'اللغة')),
                          trailing: DropdownButton<String>(
                            value: locale.languageCode,
                            underline: const SizedBox(),
                            items: const [
                              DropdownMenuItem(
                                value: 'en',
                                child: Text('English'),
                              ),
                              DropdownMenuItem(
                                value: 'ar',
                                child: Text('العربية'),
                              ),
                            ],
                            onChanged: (value) {
                              if (value != null) {
                                languageNotifier.value = Locale(value);
                              }
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              _sectionTitle(t(context, 'General', 'عام')),
              Card(
                elevation: 0,
                color: scheme.surfaceContainerHighest.withOpacity(0.4),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: ListTile(
                  leading: const Icon(Icons.info_outline),
                  title: Text(t(context, 'About', 'حول التطبيق')),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const AboutPage()),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(start: 8, bottom: 8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}