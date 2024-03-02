import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:namer_app/community.dart';

/// TODO
/// - Add community icon selector
/// - Add ability to invite users from the main screen
/// - Fix issue where selecting public/private erases the name

enum PublicPrivate { public, private }

class EditCommunityForm extends StatefulWidget {
  final Community community;
  const EditCommunityForm(this.community);

  @override
  EditCommunityFormState createState() {
    return EditCommunityFormState();
  }
}

class EditCommunityFormState extends State<EditCommunityForm> {
  var communities = FirebaseFirestore.instance.collection('communities');

  Future<void> editCommunity(String _name, bool _private) {
    //Check if community has a document ID
    if (widget.community.firebaseDocumentId == "") {
      print("Error: No document ID");
      return Future.value();
    }

    //Get document
    var docRef = communities.doc(widget.community.firebaseDocumentId);

    //Call .update() on that document
    docRef.update({'name': _name, 'private': _private}).then((value) {
      print("Community Updated");
    }).catchError((error) => print("Failed to update community: $error"));

    return Future.value();
  }

  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  PublicPrivate? visibility = PublicPrivate.public;
  String updatedName = "";
  bool changedPrivacy = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final nameController = TextEditingController();

    //Setup name field
    if (updatedName != "") {
      nameController.text = updatedName;
    } else {
      nameController.text = widget.community.name.toString();
    }

    //Setup visibility
    if (!changedPrivacy) {
      if (widget.community.private) {
        print("Private");
        visibility = PublicPrivate.private;
      } else {
        visibility = PublicPrivate.public;
      }
    }

    @override
    void dispose() {
      // Clean up the controller when the widget is disposed.
      nameController.dispose();
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
                hintText: "Community Name",
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
            //Public/Private Selector
            Row(
              children: [
                Expanded(
                  child: RadioListTile(
                    value: PublicPrivate.public,
                    groupValue: visibility,
                    onChanged: (PublicPrivate? value) {
                      if (value != null) {
                        updatedName = nameController.text;
                        changedPrivacy = true;
                        setState(() => visibility = value);
                      }
                    },
                    fillColor:
                        MaterialStateProperty.all(theme.colorScheme.secondary),
                    title: const Text('Public'),
                  ),
                ),
                Expanded(
                  child: RadioListTile(
                    value: PublicPrivate.private,
                    groupValue: visibility,
                    onChanged: (PublicPrivate? value) {
                      if (value != null) {
                        updatedName = nameController.text;
                        changedPrivacy = true;
                        setState(() => visibility = value);
                      }
                    },
                    fillColor:
                        MaterialStateProperty.all(theme.colorScheme.secondary),
                    title: const Text('Private'),
                  ),
                ),
              ],
            ),
            //Spacer
            Expanded(
                child:
                    SizedBox()), //Moves button to bottom of screen (optional)
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
                    bool private = false;
                    if (visibility == PublicPrivate.private) {
                      private = true;
                    }

                    //addCommunity(nameController.text, private);
                    editCommunity(nameController.text, private);

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
