import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/Chat/chat_service.dart';

class ChatPage extends StatefulWidget {
  final String receiverName;
  final String receiverId;
  final String imageURL;
  const ChatPage(
      {required this.receiverName,
      required this.imageURL,
      required this.receiverId});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class ChatMessage {
  String messageContent;
  String messageType;
  ChatMessage({required this.messageContent, required this.messageType});
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverName, widget.receiverId, _messageController.text);
      _messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        flexibleSpace: SafeArea(
            child: Container(
          padding: EdgeInsets.only(right: 16),
          child: Row(
            children: <Widget>[
              IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: theme.colorScheme.onSecondary,
                  )),
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(widget.imageURL),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(
                width: 12,
              ),
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    widget.receiverName,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    "Online",
                    style: TextStyle(
                        color: theme.colorScheme.onSecondary, fontSize: 13),
                  ),
                ],
              ))
            ],
          ),
        )),
        backgroundColor: theme.colorScheme.secondary,
      ),
      body: Column(
        children: [
          Expanded(child: _buildMessageList()),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: theme.colorScheme.onError,
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                          hintText: "Write message...",
                          hintStyle:
                              TextStyle(color: theme.colorScheme.onBackground),
                          border: InputBorder.none),
                    ),
                  ),
                  IconButton(
                    onPressed: sendMessage,
                    icon: Icon(
                      Icons.send,
                      size: 40,
                      color: theme.colorScheme.onSecondary,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    return StreamBuilder(
      stream: _chatService.getMessages(
          widget.receiverId, _firebaseAuth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('loading...');
        }
        return ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(top: 10, bottom: 10),
          physics: NeverScrollableScrollPhysics(),
          children: snapshot.data!.docs
              .map((document) => _buildMessageItem(document))
              .toList(),
        );
      },
    );
  }

  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Container(
        alignment: alignment,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(children: [
            ChatBubble(
              message: data['message'],
              theme: Theme.of(context),
            )
          ]),
        ));
  }
}

class ChatBubble extends StatelessWidget {
  final String message;
  final ThemeData theme;
  const ChatBubble({super.key, required this.message, required this.theme});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: theme.colorScheme.secondary),
      child: Text(
        message,
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
