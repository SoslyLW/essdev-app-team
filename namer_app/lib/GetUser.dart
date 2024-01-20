
// Import the firebase_core and cloud_firestore plugin
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


Future<String> getUserName(userID) async {
  Map<String, dynamic> data = {"name": "Default Gnome"};


  final docRef = FirebaseFirestore.instance.collection("users").doc(userID);
  await docRef.get().then(
    (DocumentSnapshot doc) {
      data = doc.data() as Map<String, dynamic>;
      print(data["name"]);
      return data["name"];
    }
  );

  return data["name"];
}

// Future getUser(userID) async {
//   final docRef = FirebaseFirestore.instance.collection("users").doc(userID);
//   return await docRef.get().then<dynamic>((DocumentSnapshot snapshot) async {
//     if(snapshot.data() == null){
//       print("No name exists");
//     }
//     else {
//       return snapshot.data();
//     }
//   });
// }