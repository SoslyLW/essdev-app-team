import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:namer_app/main.dart';

enum PublicPrivate { public, private }

class AddToolForm extends StatefulWidget {
  const AddToolForm({super.key});

  @override
  AddToolFormState createState() {
    return AddToolFormState();
  }
}

class AddToolFormState extends State<AddToolForm> {
  var tools = FirebaseFirestore.instance.collection('tools');

  Future<void> addTool(String name, String condition, String availability, ownerID) {
    return tools
        .add({'name': name, 'condition': condition, 'availability': availability, 'ownerID': ownerID})
        .then((value) => print("Tool Added"))
        .catchError((error) => print("Failed to add tool: $error"));
  }

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  PublicPrivate? visibility = PublicPrivate.public;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    var appState = context.watch<MyAppState>();

    // must have a unique name controller for each text field
    final nameController = TextEditingController();
    final conditionController = TextEditingController();
    final availabilityController = TextEditingController();
    
    @override
    void dispose() {
      // Clean up the controller when the widget is disposed.
      nameController.dispose();
      conditionController.dispose();
      availabilityController.dispose();
      super.dispose();
    }

    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            // Probably want to add a list view and padding here
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: "Tool Name",
                prefixIcon: Icon(
                  Icons.business,
                  color: Colors.grey.shade600,
                  size: 20,
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding: EdgeInsets.all(8),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey.shade100)),
              ),
              controller: nameController,
            ),
            SizedBox(height: 10),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: "Tool Condition (e.g. 'Good')",
                prefixIcon: Icon(
                  Icons.business,
                  color: Colors.grey.shade600,
                  size: 20,
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding: EdgeInsets.all(8),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey.shade100)),
              ),
              controller: conditionController,
            ),
            SizedBox(height: 10),
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: "Availability (e.g. '6 Months')",
                prefixIcon: Icon(
                  Icons.business,
                  color: Colors.grey.shade600,
                  size: 20,
                ),
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding: EdgeInsets.all(8),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide(color: Colors.grey.shade100)),
              ),
              controller: availabilityController,
            ),
            //Spacer
            Expanded(
              child:
                SizedBox()
            ),
            // Submit Button
            Padding(
              padding: const EdgeInsets.only(
                  bottom: 8.0), //Padding for bottom of screen
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.fromHeight(50), // Default height was 40
                ),
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    addTool(nameController.text, conditionController.text, availabilityController.text, appState.thisUserID);

                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}