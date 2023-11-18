import 'package:flutter/material.dart';

class CommunitiesDetailPage extends StatefulWidget {
  final int pageId;

  const CommunitiesDetailPage(this.pageId) : super();
  @override
  State<CommunitiesDetailPage> createState() =>
      _CommunitiesDetailPageState(this.pageId);
}

class _CommunitiesDetailPageState extends State<CommunitiesDetailPage> {
  bool isDark = false;
  int pageId = -1;

  _CommunitiesDetailPageState(int pageId_) {
    this.pageId = pageId_;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      child: SafeArea(
        child: Column(
          children: [
            Text(pageId.toString()),
          ],
        ),
      ),
    );
  }
}
