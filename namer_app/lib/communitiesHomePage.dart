import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:namer_app/addCommunityPage.dart';
import 'package:namer_app/community.dart';

/// TODO
/// - Remove index number from Browse Communities list
/// - Change over to FutureBuilder to have a loading screen in small delay before data is loaded
/// Load one local copy of the database first and only update that copy when the user makes a change

List<Community> allCommunities = [];
bool firstload = true;

class CommunitiesHomePage extends StatefulWidget {
  @override
  State<CommunitiesHomePage> createState() => _CommunitiesHomePageState();
}

class _CommunitiesHomePageState extends State<CommunitiesHomePage> {
  bool isDark = false;
  List<Community> communities = [];

  void getData() async {
    var dataFromFirebase =
        await FirebaseFirestore.instance.collection('communities').get();

    List communitiesDocuments = dataFromFirebase.docs;
    //print(communitiesDocuments);

    allCommunities = communitiesDocuments
        .map((commDoc) => Community.fromDoc(commDoc))
        .toList();

    if (firstload) {
      setState(() {
        firstload = false;
      });
    }
  }

  void filterCommunities(String query) {
    setState(() {
      communities = allCommunities
          .where(
              (item) => item.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    getData();

    communities = allCommunities.toList();

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Title
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  'Browse Communities',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),
              //Search Bar
              Padding(
                padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                child: TextField(
                  onChanged: (value) {
                    filterCommunities(value);
                  },
                  decoration: InputDecoration(
                      hintText: "Search...",
                      hintStyle: TextStyle(color: Colors.grey.shade600),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey.shade600,
                        size: 20,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding: EdgeInsets.all(8),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.grey.shade100))),
                ),
              ),
              //Items (Scrollable)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 16, left: 16, right: 16, bottom: 4),
                  child: ListView.builder(
                    itemCount: communities.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(bottom: 16),
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return CommunityCard(
                          theme: theme, community: communities[index]);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: //Add button
          FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return AddCommunityPage();
            },
          ));
        },
        label: Text("Add"),
        icon: Icon(
          Icons.add,
          color: theme.colorScheme.secondary,
        ),
      ),
    );
  }
}
