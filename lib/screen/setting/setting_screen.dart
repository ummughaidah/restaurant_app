import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/theme_setting_provider.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Setting',
          style: TextTheme.of(context).headlineSmall,
        ),
      ),
      body: Consumer<ThemeSettingProvider>(builder: (_, provider, __) {
        return SwitchListTile(
          title: Text('Dark Theme'),
          value: provider.isDarkTheme,
          onChanged: (value) {
            provider.setDarkTheme(value);
            provider.setTheme(value);
          },
        );
      }),
    );
  }
}
