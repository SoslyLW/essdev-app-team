import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

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

  @override
  // TODO: implement props
  List<Object?> get props => [
        name,
        imageURL,
        messageText,
        time,
      ];
}

class ChatUserDatabaseService {
  final CollectionReference chatUserCollection =
      FirebaseFirestore.instance.collection('chat');
}
