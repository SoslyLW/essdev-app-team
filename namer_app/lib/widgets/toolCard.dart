import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ToolCard extends StatelessWidget {
  const ToolCard({
    super.key,
    required this.toolID,
  });

  final int toolID;

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
                Center(child: Text("IMAGE OF TOOL")),
                Center(child: Text("INITIAL TOOL INFO")),
              ],
            ),
            Column(
              children: [
                Text("Condition: "),
                Text("Availability:"),
                Text("Yes Chef"),
              ],
            )
          ],
          
        )
      )
    );
  }
}