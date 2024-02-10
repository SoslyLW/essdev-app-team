// Import the firebase_core and cloud_firestore plugin
import 'package:cloud_firestore/cloud_firestore.dart';

Future<dynamic> getTool(toolID) async {
  final docRef = FirebaseFirestore.instance.collection("tools").doc(toolID.toString());
  await docRef.get().then(
    (DocumentSnapshot doc) {
      return doc.data() as Map<String, dynamic>;
    }
  );
}
