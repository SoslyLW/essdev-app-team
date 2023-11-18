import 'package:flutter/material.dart';
import 'package:namer_app/communities.dart';

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
    pageId = pageId_;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Title
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  'COMMUNITY NAME HERE',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),
              //Search Bar
              Padding(
                padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "Search...",
                      hintStyle: TextStyle(color: Colors.grey.shade600),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey.shade600,
                        size: 20,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding: EdgeInsets.all(8),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.grey.shade100))),
                ),
              ),
              //Items (Scrollable)
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 16, left: 16, right: 16, bottom: 4),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
