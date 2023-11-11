import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
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
              SizedBox(
                width: 2,
              ),
              Icon(
                Icons.person,
                size: 50,
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
                    "Jhon Doe",
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
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: theme.colorScheme.surface,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: "Write message...",
                          hintStyle:
                              TextStyle(color: theme.colorScheme.onSurface),
                          border: InputBorder.none),
                    ),
                  ),
                  // SizedBox(
                  //   width: 15,
                  // ),
                  // FloatingActionButton(
                  //   onPressed: () {},
                  //   backgroundColor: theme.colorScheme.secondary,
                  //   elevation: 0,
                  //   child: Icon(
                  //     Icons.send,
                  //     color: theme.colorScheme.onSecondary,
                  //   ),
                  // )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
