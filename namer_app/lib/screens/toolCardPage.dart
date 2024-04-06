import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:namer_app/main.dart';
import 'package:namer_app/widgets/myToolCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:namer_app/widgets/availableToolCard.dart';

class ToolCardPage extends StatelessWidget {
  const ToolCardPage({
    super.key,
    required this.toolID,
  });

  final int toolID;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                title: null,
                toolbarHeight: 0,
                forceElevated: innerBoxIsScrolled,
                pinned: true,
                floating: true,
                bottom: TabBar(
                  tabs: <Tab>[
                    Tab(text: 'Available Tools'),
                    Tab(text: 'My Tools'),
                  ],
                ),
              ),
            ];
          },
          body: TabBarView(
            children: [
              FutureBuilder(
                future: FirebaseFirestore.instance.collection("tools").where("ownerID", isNotEqualTo: appState.thisUserID.toString()).get(),

                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> query) {
                  if (query.connectionState == ConnectionState.done) {
                    var toolCardsList = <Widget>[];
                    toolCardsList.add(SizedBox(height:10));
                    for (var doc in query.data!.docs) {
                      var tool = doc.data();
                      toolCardsList.add(AvailableToolCard(tool: tool));
                    }
                    return SingleChildScrollView(
                      child: 
                        Column(
                          children: [...toolCardsList],
                        )
                    );
                  }
                  else {
                    return Text("");
                  }
                }
              ),
              FutureBuilder(
                future: FirebaseFirestore.instance.collection("tools").where("ownerID", isEqualTo: appState.thisUserID.toString()).get(),

                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> query) {
                  if (query.connectionState == ConnectionState.done) {
                    var toolCardsList = <Widget>[];
                    toolCardsList.add(SizedBox(height:10));
                    for (var doc in query.data!.docs) {
                      var tool = doc.data();
                      toolCardsList.add(MyToolCard(tool: tool));
                    }
                    return SingleChildScrollView(
                      child: 
                        Column(
                          children: [...toolCardsList],
                        )
                    );
                  }
                  else {
                    return Text("");
                  }
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
