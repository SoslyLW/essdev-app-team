import 'package:flutter/material.dart';
import 'package:namer_app/main.dart';
import 'package:provider/provider.dart';

class Profile {
  String name;
  Icon icon;

  Profile(this.name, this.icon);

  Profile.defaultProfile()
      : icon = Icon(Icons.face),
        name = "Profile";
}

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    //user profile data
    Profile userProfile = Profile("John Doe", Icon(Icons.face));

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Page"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              child: userProfile.icon,
            ),
            SizedBox(height: 16),
            Text(
              userProfile.name,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Include bio for user",
              style: TextStyle(fontSize: 16),
            ),
            // future widgets below
          ],
        ),
      ),
    );
  }
}
