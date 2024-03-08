import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/Chat/message.dart';

class ChatService extends ChangeNotifier {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<void> sendMessage(
      String receiverName, String receiverId, String message) async {
    final String currentUserName = _firebaseAuth.currentUser!.email.toString();
    final String currentUserId = _firebaseAuth.currentUser!.uid;
    Message newMessage = Message(
      senderId: currentUserId,
      senderName: currentUserName,
      receiverName: receiverName,
      message: message,
      timestamp: Timestamp.now(),
      receiverId: receiverId,
    );

    List<String> ids = [currentUserId, receiverId];
    ids.sort();
    String chatRoom = ids.join("_");

    await _firebaseFirestore
        .collection('chat_rooms')
        .doc(chatRoom)
        .collection('messages')
        .add(newMessage.toMap());

    await _firebaseFirestore
        .collection('chat')
        .doc(receiverId)
        .update({'messageText': message, 'time': newMessage.timestamp});

    await _firebaseFirestore
        .collection('chat')
        .doc(currentUserId)
        .update({'messageText': message, 'time': newMessage.timestamp});
  }

  Stream<QuerySnapshot> getMessages(String userId, String otherUserId) {
    List<String> ids = [userId, otherUserId];
    ids.sort();
    String chatRoom = ids.join("_");
    return _firebaseFirestore
        .collection('chat_rooms')
        .doc(chatRoom)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots();
  }
}
