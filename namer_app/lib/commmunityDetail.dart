import 'package:flutter/material.dart';
import 'package:namer_app/community.dart';
import 'package:namer_app/editCommunityPage.dart';

/// TODO
/// - Figure out how to keep bottom and top bars when going from community home
/// page to community detail page
/// - Add Restriction on Community name overflow

class CommunitiesDetailPage extends StatelessWidget {
  final Community community;
  CommunitiesDetailPage(this.community) : super();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    void handleClick(int listItem) {
      switch (listItem) {
        case 0:
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return EditCommunityPage(community);
          }));
        //Switch to edit page
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
        child: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Title
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  community.name,
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
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 16, left: 16, right: 16, bottom: 4),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
