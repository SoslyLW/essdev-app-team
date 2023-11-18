import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:namer_app/widgets/toolCard.dart';

class ToolCardPage extends StatelessWidget {
  const ToolCardPage({
    super.key,
    required this.toolID,
  });

  final int toolID;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          SizedBox(height: 20),
          ToolCard(toolID: 1,),
          ToolCard(toolID: 1,),
          ToolCard(toolID: 1),
        ],
      ),
    );
  }

}