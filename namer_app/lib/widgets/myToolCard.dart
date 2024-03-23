// ignore_for_file: file_names, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:namer_app/main.dart';
import 'package:provider/provider.dart';

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

    var appState = context.watch<MyAppState>();

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
                            fontSize: 24,
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
                          text: (tool["availability"])
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(theme.colorScheme.onPrimary),
                ),

                child: Text("DELETE"), 
                
                onPressed: () => {
                  // THIS WORKS! just add visual cues and an 'are you sure?'
                  // plus find out how to immediately refresh page if you can.
                  FirebaseFirestore.instance.collection("tools").where("name", isEqualTo: tool["name"]).get().then(
                    (QuerySnapshot query) {
                      for (var doc in query.docs) {
                        doc.reference.delete();
                        appState.notifyListeners();
                      }
                    },
                  ),
                },
              )
            ],
          )
        )
      );
    }  
  }
