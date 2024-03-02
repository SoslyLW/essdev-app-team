import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/Chat/message.dart';

class ChatService extends ChangeNotifier {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<void> sendMessage(
      String receiverName, String receiverId, String message) async {
    const String currentUserName = "Admin";
    const String currentUserId = "sUA4ZVLUjoVp4txYb9W2";
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
