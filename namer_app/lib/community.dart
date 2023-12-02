import 'package:flutter/material.dart';
import 'package:namer_app/commmunityDetail.dart';

int atomicId = 1;

class Community {
  int id;
  String name;
  Icon icon = Icon(Icons.person);
  bool private = false;

  Community(this.name, this.icon) : id = atomicId++;

  Community.Default()
      : icon = Icon(Icons.person),
        id = atomicId++,
        name = "Default Community";
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
