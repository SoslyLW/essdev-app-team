// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:namer_app/main.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

// This file exclusively defines the card to request
// a tool as a stateless widget. This card can then
// be used in a number of contexts, shown in the
// toolCardPage

// basic info for a user
// info will later be stored in db
class User {
  int userID;
  String name;
  Icon icon;
  int rating;

  User(this.userID, this.name, this.icon, this.rating);

  // default user for prototyping
  User.Default()
      : userID = 0,
        name = "John Doe",
        icon = Icon(Icons.person),
        rating = 4;
}

// class for all types of tool
// info will later be stored in db
class Tool {
  int toolID;
  String name;
  Icon icon;
  User owner;
  String condition;
  int availability;
  int distance;
  String method;

  Tool(this.toolID, this.name, this.icon, this.owner, this.condition,
      this.availability, this.distance, this.method);

  // default tool for prototyping
  Tool.Default()
      : toolID = 0,
        name = "Screwdriver",
        icon = Icon(Icons.handyman),
        owner = User.Default(),
        condition = "Good",
        availability = 3,
        distance = 1,
        method = "Pickup";

  factory Tool.fromDoc(doc) {
    //Create variables for each required field to handle cases where field is not present in database
    String ownerName = "Owner Unknown";
    int ownerRating = 0;
    int ownerID = 0;
    if (doc.data().keys.toList().contains('ownerID')) {
      ownerID = int.parse(doc['ownerID'].toString());
    }
    if (doc.data().keys.toList().contains('ownerName')) {
      ownerName = doc['ownerName'];
    }
    if (doc.data().keys.toList().contains('ownerRating')) {
      ownerRating = doc['ownerRating'];
    }
    int toolID = 0;
    if (doc.data().keys.toList().contains('toolID')) {
      toolID = doc['toolID'];
    }
    String name = "Unknown Tool";
    if (doc.data().keys.toList().contains('name')) {
      name = doc['name'];
    }
    String condition = "Unknown Condition";
    if (doc.data().keys.toList().contains('condition')) {
      condition = doc['condition'];
    }
    //Availability current not support due to type confusion
    // String availability = "Unknown Availability";
    // if (doc.data().keys.toList().contains('availability')) {
    //   availability = doc['availability'];
    // }
    int availability = 0;
    int distance = 0;
    if (doc.data().keys.toList().contains('distance')) {
      distance = doc['distance'];
    }
    String method = "Unknown Method";
    if (doc.data().keys.toList().contains('method')) {
      method = doc['method'];
    }

    return Tool(
        toolID,
        name,
        Icon(Icons.handyman),
        User(ownerID, ownerName, Icon(Icons.handshake), ownerRating),
        condition,
        availability,
        distance,
        method);
  }
}

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

  final String toolID;

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
        future:
            FirebaseFirestore.instance.collection("tools").doc(toolID).get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> tool =
                snapshot.data!.data() as Map<String, dynamic>;
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
                            )),
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
                                      future: FirebaseFirestore.instance
                                          .collection("users")
                                          .doc(tool["ownerID"].toString())
                                          .get(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot<dynamic> snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.done) {
                                          Map<String, dynamic> owner =
                                              snapshot.data!.data()
                                                  as Map<String, dynamic>;
                                          return Column(
                                            children: [
                                              Text(
                                                owner["name"],
                                                style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline),
                                              ),
                                              Row(
                                                children: [
                                                  for (var i = 0;
                                                      i < owner["rating"];
                                                      i++)
                                                    Icon(Icons.star),
                                                  for (var i = 0;
                                                      i < (5 - owner["rating"]);
                                                      i++)
                                                    Icon(Icons.star_border)
                                                ],
                                              ),
                                            ],
                                          );
                                        } else {
                                          return CircularProgressIndicator(
                                            color: Colors.black,
                                          );
                                        }
                                      }),
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
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(text: tool["condition"]),
                                ],
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                      text: ("Availability: "),
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: (tool["availability"].toString() +
                                          " months")),
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
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(text: tool["method"]),
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
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        theme.colorScheme.onPrimary),
                              ),
                              onPressed: () => {
                                // add a requested toolCard to the list of cards
                                // to be displayed on the page

                                // got rid of this because there is no longer a global cardslist.
                                // Everything done by queries now.
                                // appState.addCard(RequestedToolCard(tool: tool, requester: "USER")),

                                // DOES NOTHING RIGHT NOW BUT WILL SEND MESSAGE TO TOOL OWNER
                              },
                              child: Text("REQUEST"),
                            ),
                          ],
                        ),
                      ],
                    )));
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            );
          }
        });
  }
}
