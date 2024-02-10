import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/message.dart';

class ChatService extends ChangeNotifier {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> sendMessage(String receiverName, String message) async {
    Message newMessage = Message(
        receiverName: receiverName,
        message: message,
        timestamp: Timestamp.now());

    String chatRoom = receiverName;

    await _firebaseFirestore
        .collection('chat_rooms')
        .doc(chatRoom)
        .collection('messages')
        .add(newMessage.toMap());
  }

  Stream<QuerySnapshot> getMessages(String userName) {
    return _firebaseFirestore
        .collection('chat_rooms')
        .doc(userName)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
