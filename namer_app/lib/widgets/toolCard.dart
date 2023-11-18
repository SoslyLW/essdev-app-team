// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  User(
    this.userID,
    this.name,
    this.icon,
    this.rating
  );

  // default user for prototyping
  User.Default():
    userID = 0,
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

  Tool(
    this.toolID,
    this.name,
    this.icon,
    this.owner,
    this.condition,
    this.availability,
    this.distance,
    this.method
  );

  // default tool for prototyping
  Tool.Default():
    toolID = 0,
    name = "Screwdriver",
    icon = Icon(
      Icons.handyman,
      size: 60,
      ),
    owner = User.Default(),
    condition = "Good",
    availability = 3,
    distance = 1,
    method = "Pickup";
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
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
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
  final tool = Tool.Default();

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
                  child: tool.icon
                  ),
                Center(
                  child: Column(
                    children: [
                      Text(
                        tool.name
                      ),
                      Text(
                        tool.owner.name,
                        style: TextStyle(
                          decoration: TextDecoration.underline
                        ),
                      ),
                      Row(
                        children: [
                          for (var i = 0; i < tool.owner.rating; i++) Icon(Icons.star),
                          for (var i = 0; i < (5-tool.owner.rating); i++) Icon(Icons.star_border)
                        ],
                        )
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
                        text: tool.condition
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
                        text: (tool.availability.toString() + " months")
                      ),
                    ],
                  ),
                ),
                Text.rich(
                  TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                        text: ("Distance: "),
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        )
                      ),
                      TextSpan(
                        text: (tool.distance.toString() + " km")
                      ),
                    ],
                  ),
                ),
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
                        text: tool.method
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
                Text("Request"),
            ],
            ),
          ],
          
        )
      )
    );
  }
}