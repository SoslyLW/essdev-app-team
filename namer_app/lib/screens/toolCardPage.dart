// TODO:
// Change widgets such that passing in a 
// toolID effects the tool used for card.
// This may require a database.

// This page is comprised of a list view which can hold two
// widgets: a card to request a given tool, and a card to 
// see which of your tools has been requested. As a proof of concept,
// the 'REQUEST' button on the first type of widget will automatically
// add one of the second type of widget to the listview, which will 
// automatically be added to the page.
//
// Theres is a lot left to be done, most of which will require firebase.
//
// For example, the request button should only generate a 'requested tool'
// card for the specific tool that was requested, but right now it just
// generates a default card. In addition, each icon on the 'requested tool'
// widget should perform an action.
//
// In the future I would like to create a widget for adding a tool to your 
// list of available tools using a form, and have that automatically 
// generate a 'toolCard' widget of the tool, which can then be requested.
// this will require a database of tools and users.


// UPDATE: Gonna want a dropdown that changes this page
// between 'My Tools' and 'Available Tools'

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:namer_app/main.dart';
import 'package:namer_app/widgets/myToolCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ToolCardPage extends StatelessWidget {
  const ToolCardPage({
    super.key,
    required this.toolID,
  });

  final int toolID;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return FutureBuilder(
      future: FirebaseFirestore.instance.collection("tools").where("ownerID", isEqualTo: appState.thisUserID.toString()).get(),

      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> query) {
        if (query.connectionState == ConnectionState.done) {
          var toolCardsList = <Widget>[];
          toolCardsList.add(SizedBox(height:30));
          for (var doc in query.data!.docs) {
            print(doc.data());
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
          return CircularProgressIndicator(
            color: Colors.black,
          );
        }
      }
    );
  }
}