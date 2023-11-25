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
        message = "Hello",
        communityIcon = Icon(Icons.map);
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
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
    );
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
              ))
            ],
          ),
        ));
  }
}
