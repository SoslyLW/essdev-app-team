import 'package:flutter/material.dart';
import 'package:namer_app/community.dart';
import 'package:namer_app/editCommunityPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:namer_app/widgets/toolCard.dart';

/// TODO
/// - Figure out how to keep bottom and top bars when going from community home
/// page to community detail page
/// - Add Restriction on Community name overflow
/// - Add ability to delete a community

List<Tool> communityTools = [];

Future<void> getToolsData(Community community) async {
  //Reset tools list
  communityTools = [];

  //Get list of users from community document
  if (community.users.isNotEmpty) {
    //Get list of tools from users
    var dataFromFirebase = await FirebaseFirestore.instance
        .collection('logan_tools')
        .where('ownerID', whereIn: community.users)
        .get();

    communityTools =
        dataFromFirebase.docs.map((toolDoc) => Tool.fromDoc(toolDoc)).toList();
  }
}

class CommunitiesDetailPage extends StatefulWidget {
  // final Community community;
  final String communityFirestoreId;
  final Function refreshHomeStateFunction;
  CommunitiesDetailPage(
      this.communityFirestoreId, this.refreshHomeStateFunction)
      : super();

  @override
  State<CommunitiesDetailPage> createState() => _CommunitiesDetailPageState();
}

class _CommunitiesDetailPageState extends State<CommunitiesDetailPage> {
  Community? community;

  Future<void> getCommunity() async {
    var dataFromFirebase = await FirebaseFirestore.instance
        .collection('communities')
        .doc(widget.communityFirestoreId)
        .get();

    community = Community.fromDoc(dataFromFirebase);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    void handleClick(int listItem) {
      switch (listItem) {
        //Switch to edit page
        case 0:
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return EditCommunityPage(community!);
          })).then((_) => setState(() {
                widget.refreshHomeStateFunction();
              }));
        case 1:
        // Navigator.push(context, MaterialPageRoute(builder: (context) {
        //   return AddCommunityPage();
        // }));
        //Switch to delete page
      }
    }

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          PopupMenuButton<int>(
              onSelected: (item) => handleClick(item),
              itemBuilder: (context) => [
                    PopupMenuItem<int>(value: 0, child: Text('Edit community')),
                    PopupMenuItem<int>(
                        value: 1, child: Text('Delete community')),
                  ],
              icon: Icon(
                Icons.more_vert,
                color: theme.colorScheme.onBackground,
              ),
              color: theme.colorScheme.primary),
        ],
      ),
      body: SafeArea(
          child: FutureBuilder(
              future: getCommunity(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return CommunityDetailPageBody(community, theme);
                } else {
                  return Center(
                      child: CircularProgressIndicator(
                    color: theme.colorScheme.onPrimary,
                  ));
                }
              })),
    );
  }
}

Widget CommunityDetailPageBody(Community? community, ThemeData theme) {
  return Padding(
    padding: const EdgeInsets.only(top: 16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //Title
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            community!.name,
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
        //Search Bar (for tools)
        Padding(
          padding: EdgeInsets.only(top: 16, left: 16, right: 16),
          child: TextField(
            decoration: InputDecoration(
                hintText: "Search Tools...",
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
            child: FutureBuilder(
                future: getToolsData(community),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return CommunityToolsList(communityTools, theme);
                  } else {
                    return Center(
                        child: CircularProgressIndicator(
                      color: theme.colorScheme.onPrimary,
                    ));
                  }
                })),
      ],
    ),
  );
}

Widget CommunityToolsList(List<Tool> communityTools, ThemeData theme) {
  return Padding(
    padding: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 4),
    child: ListView.builder(
      itemCount: communityTools.length,
      shrinkWrap: true,
      padding: EdgeInsets.only(bottom: 16),
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return CommunityToolCard(tool: communityTools[index], theme: theme);
      },
    ),
  );
}
