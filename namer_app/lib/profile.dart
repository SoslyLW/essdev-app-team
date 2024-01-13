import 'package:flutter/material.dart';

class Profile {
  String name;
  Icon icon;
  String bio;

  Profile(this.name, this.icon, this.bio);

  Profile.defaultProfile()
      : icon = Icon(Icons.face),
        name = "Profile",
        bio = "Include bio for user";
}

class Post {
  String imageUrl;
  String caption;

  Post(this.imageUrl, this.caption);
}

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    // User profile data
    Profile userProfile =
        Profile("John Doe", Icon(Icons.face), "Community Name");

    // Sample posts for the user
    List<Post> userPosts = [
      //Post("https://example.com/image1.jpg", "Machete"),
      //Post("https://example.com/image2.jpg", "Chainsaw"),
      // Add more posts as needed
    ];

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
              radius: 80,
              child: userProfile.icon,
            ),
            SizedBox(height: 25),
            Text(
              userProfile.name,
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              userProfile.bio,
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Add functionality for the follow button
              },
              child: Text("Connect"),
            ),
            SizedBox(height: 16),
            Container(
              width: 2 *
                  (MediaQuery.of(context).size.width /
                      3), // Twice the size of Connect button
              child: TextField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Search a tool...',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            userPosts.isEmpty
                ? Expanded(
                    child: Center(
                      child: Text(
                        "No Tools Posted",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  )
                : Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                      ),
                      itemCount: userPosts.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(userPosts[index].imageUrl),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              userPosts[index].caption,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
