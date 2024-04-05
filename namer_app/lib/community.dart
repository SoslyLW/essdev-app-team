import 'package:flutter/material.dart';
import 'package:namer_app/commmunityDetail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:namer_app/widgets/toolCard.dart';
import 'package:namer_app/screens/toolCardPage.dart';

int atomicId = 1; // Want to transition atomic id to a firebase function

class Community {
  int id;
  String name;
  Icon icon = Icon(Icons.person);
  bool private = true;
  String firebaseDocumentId = "";
  List<int> users = [];

  Community(this.name, this.icon,
      {this.firebaseDocumentId = "",
      this.private = true,
      this.users = const []})
      : id = atomicId++;

  Community.Default()
      : icon = Icon(Icons.person),
        id = atomicId++,
        name = "Default Community";

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (id != null) "state": id,
    };
  }

  factory Community.fromDoc(doc) {
    if (doc['icon'] != null && doc['icon'] != 'null') {
      return Community(doc['name'], Icon(IconData(doc['icon'])));
    }

    List<int> users = [];
    List<String> keys = doc.data().keys.toList();
    String listOfUsersString = "list_of_users";

    //Check if 'list_of_users' field exists in document
    if (doc.data().keys.toList().contains(listOfUsersString) &&
        doc['list_of_users'] != null) {
      //Add each users to the list individually using the toString method
      for (var user in doc['list_of_users']) {
        // users.add(user.toString());
        users.add(int.parse(user.toString()));
      }
    }

    return Community(doc['name'], Icon(Icons.handyman),
        firebaseDocumentId: doc.id, private: doc['private'], users: users);
  }
}

class CommunityCard extends StatefulWidget {
  CommunityCard({
    super.key,
    required this.theme,
    required this.community,
    required this.updateFunction,
  });

  final ThemeData theme;
  Community community;
  final Function updateFunction;

  @override
  State<CommunityCard> createState() => _CommunityCardState();
}

class _CommunityCardState extends State<CommunityCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
        color: widget.theme.colorScheme.secondary,
        child: ListTile(
          leading: widget.community.icon,
          title: Text(
            widget.community.name,
            overflow: TextOverflow.ellipsis,
          ),
          // trailing: Text(widget.community.id.toString()), //for debugging
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return CommunitiesDetailPage(
                    widget.community.firebaseDocumentId, widget.updateFunction);
              },
            ));
          },
        ));
  }
}

class CommunityToolCard extends StatelessWidget {
  final Tool tool;
  final ThemeData theme;

  CommunityToolCard({required this.tool, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: theme.colorScheme.secondary,
      child: ListTile(
        leading: tool.icon,
        title: Text(tool.name),
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              //This needs to go to tool page
              return ToolCardPage(toolID: tool.toolID);
              // return CommunitiesDetailPage(community.firebaseDocumentId, () {});
            },
          ));
        },
      ),
    );
  }
}
