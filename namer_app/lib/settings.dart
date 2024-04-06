import 'package:flutter/material.dart';

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
  double fontSize = 16.0; // Initial font size

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildSection("Profile", [
              _buildListItem("Edit Profile", () {
                // Handle Edit Profile button press
              }),
              _buildListItem("Privacy Settings", () {
                // Handle Privacy Settings button press
              }),
            ]),
            _buildSection("Notifications", [
              _buildToggleItem("Connection Request", false, (value) {
                // Handle Connection Request toggle
              }),
              _buildToggleItem("Tool Sharing Request", false, (value) {
                // Handle Tool Sharing Request toggle
              }),
              _buildToggleItem("Messages", false, (value) {
                // Handle Messages toggle
              }),
              _buildToggleItem("Email Notifications", false, (value) {
                // Handle Email Notifications toggle
              }),
            ]),
            _buildSection("Preferences", [
              _buildToggleItem("Dark Mode", false, (value) {
                setState(() {
                  isDark = value;
                  // Handle Dark Mode toggle
                });
              }),
              _buildFontSliderItem("Font", fontSize, (value) {
                setState(() {
                  fontSize = value;
                  // Handle Font Size change
                });
              }),
            ]),
            _buildSection("Account", [
              _buildListItem("Change Password", () {
                // Handle Change Password button press
              }),
              _buildListItem("Delete Account", () {
                // Handle Delete Account button press
              }),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        ...children,
        Divider(),
      ],
    );
  }

  Widget _buildListItem(String title, VoidCallback onPressed) {
    return ListTile(
      title: Text(title),
      onTap: onPressed,
    );
  }

  Widget _buildToggleItem(
      String title, bool value, ValueChanged<bool> onChanged) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
    );
  }

  Widget _buildFontSliderItem(
      String title, double value, ValueChanged<double> onChanged) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  title,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Text("Font Size: ${value.toStringAsFixed(1)}"),
            ],
          ),
        ),
        SizedBox(
          width: 200.0, // Adjust the width as needed
          child: Slider(
            value: value,
            min: 10.0,
            max: 30.0,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
