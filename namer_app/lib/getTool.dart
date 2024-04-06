// Import the firebase_core and cloud_firestore plugin
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

// Get a single tool from an ID
Future<dynamic> getTool(toolID) async {
  final docRef = FirebaseFirestore.instance.collection("tools").doc(toolID.toString());
  await docRef.get().then(
    (DocumentSnapshot doc) {
      return doc.data() as Map<String, dynamic>;
    }
  );
}

// Get all tools owned by current user
Future<List<dynamic>> getMyTools(appUserID) async {
  var toolsList = [];

  final docRef = FirebaseFirestore.instance.collection("tools").where("ownerID", isEqualTo: appUserID);
  await docRef.get().then(
    (QuerySnapshot query) {
      for (var doc in query.docs) {
        toolsList.add(doc as Map<String, dynamic>);
      }
      print(toolsList);
      return toolsList;
    }
  );

  throw errorPropertyTextConfiguration;
}

// Get all tools NOT owned by current user.
// Will also filter for communities in the future, but not yet.
Future<dynamic> getAvailableTools(appUserID) async {
  final docRef = FirebaseFirestore.instance.collection("tools").where("ownerID", isNotEqualTo: appUserID);
  await docRef.get().then(
    (QuerySnapshot query) {
      print(query.docs as Map<String, dynamic>);
      return query.docs as Map<String, dynamic>;
    }
  );
}