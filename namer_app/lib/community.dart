import 'package:flutter/material.dart';
import 'package:namer_app/commmunityDetail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

int atomicId = 1; // Want to transition atomic id to a firebase function

class Community {
  int id;
  String name;
  Icon icon = Icon(Icons.person);
  bool private = false;
  String firebaseDocumentId = "";

  Community(this.name, this.icon, {this.firebaseDocumentId = ""})
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
    //print(doc.data());
    return Community(doc['name'], Icon(Icons.handyman),
        firebaseDocumentId: doc.id);
  }
}

class CommunityCard extends StatelessWidget {
  const CommunityCard({
    super.key,
    required this.theme,
    required this.community,
  });

  final ThemeData theme;
  final Community community;

  @override
  Widget build(BuildContext context) {
    return Card(
        color: theme.colorScheme.secondary,
        child: ListTile(
          leading: community.icon,
          title: Text(
            community.name,
            overflow: TextOverflow.ellipsis,
          ),
          trailing: Text(community.id.toString()),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return CommunitiesDetailPage(community);
              },
            ));
          },
        ));
  }
}
