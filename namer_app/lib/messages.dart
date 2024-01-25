import 'package:flutter/material.dart';
import 'package:namer_app/chat.dart';
import 'package:namer_app/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageUsers {
  String name;
  String messageText;
  String imageURL;
  Timestamp time;
  MessageUsers(
      {required this.name,
      required this.messageText,
      required this.imageURL,
      required this.time}) {
    // TODO: implement MessageUsers
    throw UnimplementedError();
  }
}

class MessageList extends StatefulWidget {
  String name;
  String messageText;
  String imageURL;
  Timestamp time;
  MessageList(
      {required this.name,
      required this.messageText,
      required this.imageURL,
      required this.time});
  @override
  _MessageListState createState() => _MessageListState();
}

class MessagesProvider {
  final FirebaseFirestore firebaseFirestore;

  MessagesProvider({required this.firebaseFirestore});

  Future<void> updateFirestoreData(
      String collectionPath, String path, Map<String, dynamic> updateData) {
    return firebaseFirestore
        .collection(collectionPath)
        .doc(path)
        .update(updateData);
  }

  Stream<QuerySnapshot> getFirestoreData(
      String collectionPath, int limit, String? textSearch) {
    CollectionReference collection =
        FirebaseFirestore.instance.collection(collectionPath);
    if (textSearch?.isNotEmpty == true) {
      return firebaseFirestore
          .collection(collectionPath)
          .limit(limit)
          .where(collection.doc(), isEqualTo: textSearch)
          .snapshots();
    } else {
      return firebaseFirestore
          .collection(collectionPath)
          .limit(limit)
          .snapshots();
    }
  }
}

class _MessageListState extends State<MessageList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ChatPage(
            name: widget.name,
          );
        }));
      },
      child: Container(
        color: Color(0xfff5ab00),
        padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(children: <Widget>[
          Expanded(
              child: Row(
            children: <Widget>[
              Image.network(
                widget.imageURL,
                height: 50,
                width: 50,
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
                                fontSize: 13, color: Colors.grey.shade600),
                          ),
                        ],
                      )))
            ],
          )),
          Text(
            widget.time.toDate().toString(),
            style: TextStyle(fontSize: 12),
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
            StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('chat').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const Text('error');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text('loading...');
                  }
                  return ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 16),
                    physics: NeverScrollableScrollPhysics(),
                    children: snapshot.data!.docs
                        .map<Widget>((doc) => _buildUserListItem(doc))
                        .toList(),
                  );
                }),
          ],
        ),
      ),
    );
  }
}

Widget _buildUserListItem(DocumentSnapshot document) {
  Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
  return MessageList(
      name: data['name'],
      messageText: data['messageText'],
      imageURL: data['imageURL'],
      time: data['time']);
}
