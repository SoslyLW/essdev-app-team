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
    int availability = 0;
    if (doc.data().keys.toList().contains('availability')) {
      availability = doc['availability'];
    }
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
                    Center(child: tool.icon),
                    Center(
                      child: Column(
                        children: [
                          Text(tool.name),
                          Text(tool.owner.name),
                          Row(
                            children: [
                              for (var i = 0; i < tool.owner.rating; i++)
                                Icon(Icons.star),
                              for (var i = 0; i < (5 - tool.owner.rating); i++)
                                Icon(Icons.star_border)
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Condition: " + tool.condition),
                    Text("Availability:" +
                        tool.availability.toString() +
                        " months"),
                    Text("Distance: " + tool.distance.toString() + " km"),
                    Text("Method: " + tool.method),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TimeDropdown(),
                    Text("Request"),
                  ],
                ),
              ],
            )));
  }
}
