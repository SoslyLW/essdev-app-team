// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:namer_app/main.dart';
import 'package:namer_app/widgets/requestedToolCard.dart';

import 'package:namer_app/GetUser.dart';
import 'package:namer_app/getTool.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// This file exclusively defines the card to request
// a tool as a stateless widget. This card can then
// be used in a number of contexts, shown in the
// toolCardPage

// list of options for dropdown
// hard coded for now, will fix later
const List<String> timeList = <String>['1 Month', '2 Months', '3 Months'];

class TimeDropdown extends StatefulWidget {
  const TimeDropdown({
    super.key,
    });

  @override
  State<TimeDropdown> createState() => _TimeDropdownState();
}

class _TimeDropdownState extends State<TimeDropdown> {
  String dropdownValue = timeList.first;

  @override 
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(
        Icons.arrow_downward,
        color: Theme.of(context).colorScheme.onPrimary,
        ),
      elevation: 16,
      underline: Container(
        height: 2,
        color: Theme.of(context).colorScheme.onPrimary,
      ),
      onChanged: (String? value) {
        setState(() {
          dropdownValue = value!;
        });
      },
      items: [
        DropdownMenuItem<String>(
          value: "1 Month",
          child: Text('1 Month'),
        ),
        DropdownMenuItem<String>(
          value: "2 Months",
          child: Text('2 Months'),
        ),
        DropdownMenuItem<String>(
          value: "3 Months",
          child: Text('3 Months'),
        ),
      ],
    );
  }
}


// The toolcard itself is stateless,
// but contains a stateful widget in dropdown
class ToolCard extends StatelessWidget {
  ToolCard({
    super.key,
    required this.toolID,
  });

  final int toolID;

  // would usually then search database for matching
  // toolID, but we'll just use default tool for now
  // final tool = Tool.Default();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // watch the state of the app for changes
    // to the list of cards to be displayed
    var appState = context.watch<MyAppState>();

    return FutureBuilder(
      future: FirebaseFirestore.instance.collection("tools").doc(toolID.toString()).get(),

      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> tool = snapshot.data!.data() as Map<String, dynamic>;
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
                            /*
                              OK We're gonna try something!
                              Let's replace this text with a future
                              builder that calls getUserName asynchronously
                              to query for a given use. Let's hope this works!
                            */
          
                            // AND IT WORKS!!!!!! LETS GOOOOO
                            FutureBuilder<dynamic>(
                              // future: getUserName(tool["ownerID"]), 
                              future: FirebaseFirestore.instance.collection("users").doc(tool["ownerID"].toString()).get(),
                              
                              builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                                if (snapshot.connectionState == ConnectionState.done) { 
                                  Map<String, dynamic> owner = snapshot.data!.data() as Map<String, dynamic>;
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
                              text: (tool["availability"].toString() + " months")
                            ),
                          ],
                        ),
                      ),
                      // Text.rich(
                      //   TextSpan(
                      //     children: <TextSpan>[
                      //       TextSpan(
                      //         text: ("Distance: "),
                      //         style: TextStyle(
                      //           fontWeight: FontWeight.bold
                      //         )
                      //       ),
                      //       TextSpan(
                      //         text: (tool.distance.toString() + " km")
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Text.rich(
                        TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: ("Method: "),
                              style: TextStyle(
                                fontWeight: FontWeight.bold
                              )
                            ),
                            TextSpan(
                              text: tool["method"]
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TimeDropdown(),
                      SizedBox(width: 20),
                      TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(theme.colorScheme.onPrimary),
                        ),
                        onPressed: () => {
                          // add a requested toolCard to the list of cards
                          // to be displayed on the page
                          appState.addCard(RequestedToolCard(tool: tool, requester: "USER")),
                        },
                        child: Text("REQUEST"),
                        ),
                  ],
                ),
                ],
              )
            )
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.black,
            ),
          );
        }    
      }
    );
  }
}