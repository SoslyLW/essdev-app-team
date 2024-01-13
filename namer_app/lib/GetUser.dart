import 'package:flutter/material.dart';

// Import the firebase_core and cloud_firestore plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


Map<String, dynamic> getUser(userID) {
  final docRef = FirebaseFirestore.instance.collection("cities").doc("SF");
  docRef.get().then(
    (DocumentSnapshot doc) {
      final data = doc.data() as Map<String, dynamic>;
      return data;
    },
    onError: (e) => (
      print("You fucked it buddy"),
    ),
  );
}