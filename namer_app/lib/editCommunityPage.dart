import 'package:flutter/material.dart';
import 'package:namer_app/EditCommunityForm.dart';
import 'package:namer_app/community.dart';

class EditCommunityPage extends StatelessWidget {
  final Community community;
  EditCommunityPage(this.community) : super();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
                  "Edit " + community.name.toString(),
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),
              //Items (Scrollable)
              Expanded(child: EditCommunityForm(community)),
            ],
          ),
        ),
      ),
    );
  }
}
