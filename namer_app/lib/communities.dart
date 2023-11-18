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
    var appState = context.watch<MyAppState>();

    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        //Something for the top bar
        DecoratedBox(
          decoration: BoxDecoration(border: Border.all()),
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 8,
          ),
        ),
        //Title
        Text('Browse Communities'),
        //Search Bar
        SearchAnchor(
            builder: (BuildContext context, SearchController controller) {
          return SearchBar(
            controller: controller,
            padding: const MaterialStatePropertyAll<EdgeInsets>(
                EdgeInsets.symmetric(horizontal: 16.0)),
            onTap: () {
              controller.openView();
            },
            onChanged: (_) {
              controller.openView();
            },
            leading: const Icon(Icons.search),
          );
        }, suggestionsBuilder:
                (BuildContext context, SearchController controller) {
          return List<ListTile>.generate(5, (int index) {
            final String item = 'item $index';
            return ListTile(
              title: Text(item),
              onTap: () {
                setState(() {
                  controller.closeView(item);
                });
              },
            );
          });
        }),
        //Items (Scrollable)
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: ListView.builder(
              itemCount: communities.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 16),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Card(
                    child: ListTile(
                        leading: communities[index].icon,
                        title: Text(communities[index].name)));
              },
            ),
          ),
        )
      ],
    );
  }
}
