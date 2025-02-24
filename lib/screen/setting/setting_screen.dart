import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/setting_provider.dart';

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
      body: Consumer<SettingProvider>(builder: (_, provider, __) {
        return Column(
          children: [
            SwitchListTile(
              title: Text('Dark Theme'),
              value: provider.isDarkTheme,
              onChanged: (value) {
                provider.setDarkTheme(value);
              },
            ),
            SwitchListTile(
              title: Text('Daily Lunch Reminder'),
              value: provider.isReminderOn,
              onChanged: (value) {
                provider.toggleReminder(value);
              },
            ),
          ],
        );
      }),
    );
  }
}
