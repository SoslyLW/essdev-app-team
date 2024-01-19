import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class ChatUser extends Equatable {
  final String name;
  final String imageURL;
  final String messageText;
  final String time;

  const ChatUser({
    required this.name,
    required this.imageURL,
    required this.messageText,
    required this.time,
  });

  ChatUser copyWith({
    String? name,
    String? imageURL,
    String? nickname,
    String? time,
    String? email,
  }) =>
      ChatUser(
        name: name ?? this.name,
        imageURL: imageURL ?? this.imageURL,
        messageText: nickname ?? messageText,
        time: time ?? this.time,
      );

  Map<String, dynamic> toJson() => {
        "message": messageText,
        "imageURL": imageURL,
        "12:00": time,
      };
  factory ChatUser.fromDocument(DocumentSnapshot snapshot) {
    String imageURL = "";
    String nickname = "";
    String time = "";

    try {
      imageURL = snapshot.get("imageURL");
      nickname = snapshot.get("message");
      time = snapshot.get("12:00");
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return ChatUser(
      name: snapshot.id,
      imageURL: imageURL,
      messageText: nickname,
      time: time,
    );
  }
  @override
  // TODO: implement props
  List<Object?> get props => [
        name,
        imageURL,
        messageText,
        time,
      ];
}
