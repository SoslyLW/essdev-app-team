import 'package:flutter/material.dart';
import 'package:namer_app/main.dart';

class Notifications {
  String community;
  String message;
  Icon communityIcon;
  Notifications(
      {required this.community,
      required this.message,
      required this.communityIcon});

  Notifications.deafault()
      : community = "Kingston",
        message = "Hello I am looking to buy your screwdriver.",
        communityIcon = Icon(
          Icons.map,
          size: 50,
        );
}

class NotificationsList extends StatefulWidget {
  String community;
  String message;
  Icon communityIcon;
  NotificationsList(
      {required this.community,
      required this.message,
      required this.communityIcon});
  @override
  _NotificationsListState createState() => _NotificationsListState();
}

class _NotificationsListState extends State<NotificationsList> {
  final notification = Notifications.deafault();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
        color: theme.colorScheme.secondary,
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Expanded(
                    child: Row(
                  children: <Widget>[
                    notification.communityIcon,
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Community: ${notification.community}",
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            notification.message,
                            style: TextStyle(
                              fontSize: 13,
                              color: theme.colorScheme.onSecondary,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                )),
                Text("Now"),
              ]),
            ])));
  }
}

class NotificationsPage extends StatefulWidget {
  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
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
                  padding: EdgeInsets.all(10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Your Notifications",
                          style: TextStyle(
                              fontSize: 32, fontWeight: FontWeight.bold),
                        ),
                      ]),
                ),
              ),
              SafeArea(
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: NotificationsList(
                        community: "Kingston",
                        communityIcon: Icon(Icons.map),
                        message: "Hello I am looking to buy your screwdriver.",
                      )))
            ],
          ),
        ));
  }
}
