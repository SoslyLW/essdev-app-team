import 'package:flutter/material.dart';
import 'widgets/toolCard.dart';

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
  int toolID; // Assume each post has an associated tool ID
  String imageUrl;
  String caption;

  Post(this.toolID, this.imageUrl, this.caption);
}

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isDark = false;
  TextEditingController searchController = TextEditingController();
  List<Post> filteredPosts = [];

  @override
  void initState() {
    super.initState();
    // Initializing filteredPosts with all userPosts
    filteredPosts = userPosts;
  }

  // Sample posts for the user
  List<Post> userPosts = [
    Post(
        1,
        "https://images.pexels.com/photos/6011489/pexels-photo-6011489.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
        "Machete"),
    Post(2, "", "Chainsaw"),
    Post(3, "", "Kitchen Knife"),
    Post(4, "", "Fancy Spoon"),
    Post(5, "", "Horse"),
    Post(6, "", "Screw Driver"),
    Post(7, "", "Casio FX-991MS"),
    Post(8, "", "Sock"),
    Post(9, "", "Black paint"),
    Post(10, "", "Hammer"),
    // Add more posts as needed
  ];

  @override
  Widget build(BuildContext context) {
    // User profile data
    Profile userProfile =
        Profile("John Doe", Icon(Icons.face), "Community Name");

    return Scaffold(
      appBar: AppBar(
        title: Text("Profile Page"),
      ),
      body: SingleChildScrollView(
        child: Padding(
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
              SizedBox(
                width: 2 * (MediaQuery.of(context).size.width / 3),
                child: TextField(
                  controller: searchController,
                  onChanged: onSearchTextChanged,
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
              filteredPosts.isEmpty
                  ? Center(
                      child: Text(
                        "No Tools Posted",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                      ),
                      itemCount: filteredPosts.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            // Navigate to the tool detail screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ToolCard(
                                    toolID: filteredPosts[index].toolID.toString()),
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color.fromARGB(195, 245, 172, 0),
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                filteredPosts[index].imageUrl != null
                                    ? Container(
                                        width: 30.0,
                                        height: 30.0,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12.0),
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                filteredPosts[index].imageUrl),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      )
                                    : Container(),
                                Center(
                                  child: Text(
                                    filteredPosts[index].caption,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }

  void onSearchTextChanged(String searchText) {
    setState(() {
      filteredPosts = userPosts
          .where((post) =>
              post.caption.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }
}
