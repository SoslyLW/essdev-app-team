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
// Theres is a lot left to be done, most of which will reuire firebase.
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

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:namer_app/main.dart';

class ToolCardPage extends StatelessWidget {
  const ToolCardPage({
    super.key,
    required this.toolID,
  });

  final int toolID;

  @override
  Widget build(BuildContext context) {
    // watch the state of the app for changes
    // to the list of cards to be displayed
    var appState = context.watch<MyAppState>();

    // add a toolCard to the list of cards to be displayed
    // appState.addCard(ToolCard(toolID: 1,));

    var cardsList = appState.cardsList;

    // Hey! It kinda works. That's cool.

    return Center(
      child: ListView(
        padding: const EdgeInsets.all(8),
        // children: [
        //   SizedBox(height: 20),
        //   ToolCard(toolID: 1,),
        //   RequestedToolCard(toolID: 1,),
        //   ToolCard(toolID: 1),
        // ],
        children: cardsList
      ),
    );
  }

}