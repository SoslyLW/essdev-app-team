import 'package:flutter/material.dart';
import 'package:namer_app/chat.dart';
import 'package:namer_app/main.dart';

class MessageUsers {
  String name;
  String messageText;
  Icon imageURL;
  String time;
  MessageUsers(
      {required this.name,
      required this.messageText,
      required this.imageURL,
      required this.time});
}

class MessageList extends StatefulWidget {
  String name;
  String messageText;
  Icon imageURL;
  String time;
  bool isMessageRead;
  MessageList(
      {required this.name,
      required this.messageText,
      required this.imageURL,
      required this.time,
      required this.isMessageRead});
  @override
  _MessageListState createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ChatPage();
        }));
      },
      child: Container(
        color: Color(0xfff5ab00),
        padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(children: <Widget>[
          Expanded(
              child: Row(
            children: <Widget>[
              Icon(
                Icons.person,
                size: 50,
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                  child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.name,
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            widget.messageText,
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.grey.shade600,
                                fontWeight: widget.isMessageRead
                                    ? FontWeight.bold
                                    : FontWeight.normal),
                          ),
                        ],
                      )))
            ],
          )),
          Text(
            widget.time,
            style: TextStyle(
                fontSize: 12,
                fontWeight:
                    widget.isMessageRead ? FontWeight.bold : FontWeight.normal),
          )
        ]),
      ),
    );
  }
}

class MessagesPage extends StatefulWidget {
  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  List<MessageUsers> messageUsers = [
    MessageUsers(
        name: "Jhon Doe",
        messageText: "HEY",
        imageURL: Icon(Icons.person),
        time: "Now"),
    MessageUsers(
        name: "Jane Doe",
        messageText: "I will give it",
        imageURL: Icon(Icons.person),
        time: "Yesterday"),
    MessageUsers(
        name: "Smith Smith",
        messageText: "100 million",
        imageURL: Icon(Icons.person),
        time: "November 3"),
    MessageUsers(
        name: "Batman",
        messageText: "Dont steal",
        imageURL: Icon(Icons.person),
        time: "October 31"),
    MessageUsers(
        name: "Jhon Doe",
        messageText: "Bye",
        imageURL: Icon(Icons.person),
        time: "October 29"),
  ];
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
        backgroundColor: theme.colorScheme.primary,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SafeArea(
                  child: Padding(
                      padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Conversations",
                              style: TextStyle(
                                  fontSize: 32, fontWeight: FontWeight.bold),
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  left: 8, right: 8, top: 2, bottom: 2),
                              height: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Color(0xffffbd59),
                              ),
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.add,
                                    color: Colors.pink,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    "Add New",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ]))),
              Padding(
                padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                child: TextField(
                  decoration: InputDecoration(
                      hintText: "Search...",
                      hintStyle: TextStyle(color: Colors.grey.shade600),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey.shade600,
                        size: 20,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                      contentPadding: EdgeInsets.all(8),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.grey.shade100))),
                ),
              ),
              ListView.builder(
                itemCount: messageUsers.length,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 16),
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return MessageList(
                      name: messageUsers[index].name,
                      messageText: messageUsers[index].messageText,
                      imageURL: messageUsers[index].imageURL,
                      time: messageUsers[index].time,
                      isMessageRead: (index == 0 || index == 3) ? true : false);
                },
              )
            ],
          ),
        ));
  }
}
