import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:namer_app/main.dart';

class Community {
  String name;
  Icon icon = Icon(Icons.person);

  Community(this.name, this.icon);

  Community.Default()
      : icon = Icon(Icons.person),
        name = "Default Community";
}

class CommunitiesHomePage extends StatefulWidget {
  @override
  State<CommunitiesHomePage> createState() => _CommunitiesHomePageState();
}

class _CommunitiesHomePageState extends State<CommunitiesHomePage> {
  bool isDark = false;
  List<Community> communities = [
    Community.Default(),
    Community("Smith Engineering", Icon(Icons.handyman)),
    Community("Smith Engineering", Icon(Icons.handyman)),
    Community("Smith Engineering", Icon(Icons.handyman)),
    Community("Smith Engineering", Icon(Icons.handyman)),
    Community("Smith Engineering", Icon(Icons.handyman)),
    Community("Smith Engineering", Icon(Icons.handyman)),
    Community("Smith Engineering", Icon(Icons.handyman)),
    Community("Smith Engineering", Icon(Icons.handyman)),
    Community("Smith Engineering", Icon(Icons.handyman)),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      child: SafeArea(
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
                      return Card(
                          color: theme.colorScheme.secondary,
                          child: ListTile(
                              leading: communities[index].icon,
                              title: Text(communities[index].name)));
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
