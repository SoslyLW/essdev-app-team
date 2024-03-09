// ignore_for_file: file_names, prefer_interpolation_to_compose_strings

// Like toolCard, but for tools owned by the user of the app.
// This means no button to request the tool, but add the ability
// to remove the tool from the database. Also no need to identify 
// the user, because it is you haha.

// Also perhaps add the current status of the tool to list of 
// attributes. Is it in your posession or rented out? To who?

// Will have to query db where ownerID == appState.thisUserID

// TODO:

// - Get rid of user info (you are the user)
// - Add delete button and functionality
// - Provide default values where no info available (either accomplish here or in
//   tool form -> database)
// - Set up available tool widget (maybe get rid of time dropdown, overcomplicated)


import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyToolCard extends StatelessWidget {
  MyToolCard({
    super.key,
    required this.tool,
  });

  // tool object from the database.
  final Map<String, dynamic> tool;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

      return Card(
        color: theme.colorScheme.secondary,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Center(
                    child: Icon(
                      Icons.handyman,
                      size: 50,
                      )
                    ),
                  Center(
                    child: Column(
                      children: [
                        Text(
                          tool["name"],
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: ("Condition: "),
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          )
                        ),
                        TextSpan(
                          text: tool["condition"]
                        ),
                      ],
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: ("Availability: "),
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          )
                        ),
                        TextSpan(
                          text: (tool["availability"].toString() + " months")
                        ),
                      ],
                    ),
                  ),
                  // Text.rich(
                  //   TextSpan(
                  //     children: <TextSpan>[
                  //       TextSpan(
                  //         text: ("Method: "),
                  //         style: TextStyle(
                  //           fontWeight: FontWeight.bold
                  //         )
                  //       ),
                  //       TextSpan(
                  //         text: tool["method"]
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
              SizedBox(height: 10),
              TextButton(
                child: Text("DELETE"), 
                
                onPressed: () => {
                  // THIS WORKS! just add visual cues and an 'are you sure?'
                  // plust find out how to immediately refresh page if you can.
                  FirebaseFirestore.instance.collection("tools").where("name", isEqualTo: tool["name"]).get().then(
                    (QuerySnapshot query) {
                      for (var doc in query.docs) {
                        doc.reference.delete();
                      }
                    }
                  ),
                },
              )
            ],
          )
        )
      );
    }  
  }
