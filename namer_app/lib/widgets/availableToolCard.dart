import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:namer_app/main.dart';
import 'package:provider/provider.dart';

import 'package:namer_app/Chat/chat_service.dart';

class AvailableToolCard extends StatelessWidget {
  AvailableToolCard({
    super.key,
    required this.tool,
  });

  // tool object from the database.
  final Map<String, dynamic> tool;

  var ownerName;
  var chatID;

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
                        FutureBuilder<dynamic>(
                              // future: getUserName(tool["ownerID"]), 

                              // OK So we're gonna change this to query for a user with a userID equal to the ownerID
                              // given by the tool. This will accomodate for sign ins.
                              future: FirebaseFirestore.instance.collection("users").doc(tool["ownerID"].toString()).get(),
                              
                              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                if (snapshot.connectionState == ConnectionState.done) { 
                                  Map<String, dynamic> owner = snapshot.data!.data() as Map<String, dynamic>;
                                  ownerName = owner["name"];
                                  chatID = owner["chatID"];
                                  return Column(
                                    children: [
                                      Text(
                                        owner["name"],
                                        style: TextStyle(
                                          decoration: TextDecoration.underline
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          for (var i = 0; i < owner["rating"]; i++) Icon(Icons.star),
                                          for (var i = 0; i < (5-owner["rating"]); i++) Icon(Icons.star_border)
                                        ],
                                      ),
                                    ],
                                  );
                                }
                                else {
                                  return CircularProgressIndicator(
                                    color: Colors.black,
                                  );
                                }
                              }
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

                child: Text("REQUEST"), 
                
                onPressed: () => {
                  // ignore: prefer_interpolation_to_compose_strings
                  ChatService().sendMessage(ownerName, chatID, ("${"Hello! I would like to borrow your " + tool["name"]}.")),
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Message Sent')),
                    )
                },
              )
            ],
          )
        )
      );
    }  
  }
