import 'package:flutter/material.dart';
import 'package:namer_app/main.dart';
import 'package:provider/provider.dart';

class Settings {
  String name;
  Icon icon;

  Settings(this.name, this.icon);

  Settings.defaultSettings()
      : icon = Icon(Icons.settings),
        name = "Settings";
}

class SettingsPage extends StatefulWidget {
  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    //settings data

    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // future widgets below
        ),
      ),
    );
  }
}
