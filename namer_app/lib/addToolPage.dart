import 'package:flutter/material.dart';
import 'package:namer_app/addToolForm.dart';

class AddToolPage extends StatelessWidget {
  AddToolPage() : super();

  @override
  Widget build(BuildContext context) {
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
                  "Add Tool",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),
              //Items (Scrollable)
              Expanded(child: AddToolForm()),
            ],
          ),
        ),
      ),
    );
  }
}