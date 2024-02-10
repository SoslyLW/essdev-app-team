// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';

// This file exclusively defines the card that
// shows when one of your tools have been requested.
// This card is a widget that can be used in many contexts,
// shown in the toolCardPage.

class RequestedToolCard extends StatelessWidget {
  RequestedToolCard({
    super.key,
    required this.tool,
    required this.requester
  });

  final tool;
  final requester;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      color: theme.colorScheme.secondary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              (requester + " has requested your " + tool["name"] + "."),
            ),
            Text("Duration: " + tool["availability"].toString() + " months"),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.cancel,
                  color: Colors.red,
                  size: 30,
                  ),
                SizedBox(width: 10),
                Icon(
                  Icons.message,
                  color: Colors.grey.shade800,
                  size: 30,
                  ),
                SizedBox(width: 10),
                Icon(
                  Icons.check_box,
                  color: Colors.green.shade800,
                  size: 30,
                  )
              ],
            ),
          ]
        ),
      ),
    );
  }
}
