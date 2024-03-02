import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  //final String senderName;
  final String receiverName;
  final String message;
  final Timestamp timestamp;

  Message(
      { //required this.senderName,
      required this.receiverName,
      required this.message,
      required this.timestamp});

  Map<String, dynamic> toMap() {
    return {
      //'senderName': senderName,
      'receiverName': receiverName,
      'message': message,
      'timestamp': timestamp
    };
  }
}
