import 'package:flutter/material.dart';
import 'package:namer_app/commmunityDetail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

int atomicId = 1; // Want to transition atomic id to a firebase function

class Community {
  int id;
  String name;
  Icon icon = Icon(Icons.person);
  bool private = true;
  String firebaseDocumentId = "";

  Community(this.name, this.icon,
      {this.firebaseDocumentId = "", this.private = true})
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

    return Community(doc['name'], Icon(Icons.handyman),
        firebaseDocumentId: doc.id, private: doc['private']);
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
          trailing: Text(widget.community.id.toString()),
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
