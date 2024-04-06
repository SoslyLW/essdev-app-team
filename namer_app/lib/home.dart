import 'package:flutter/material.dart';
import 'package:namer_app/main.dart';

class Notification {
  String community;
  String message;
  Icon communityIcon;
  String timeString;
  Notification(
      this.community, this.message, this.timeString, this.communityIcon);

  Notification.Default()
      : community = "Kingston",
        message = "Hello I am looking to buy your screwdriver.",
        timeString = "Now",
        communityIcon = Icon(
          Icons.map,
          size: 50,
        );
    }

class NotificationsList extends StatefulWidget {
  List<Notification> notifications;
  NotificationsList(this.notifications);

  @override
  _NotificationsListState createState() => _NotificationsListState();
}

List<Notification> testNotifications = [
  Notification.Default(),
  Notification.Default(),
  Notification.Default(),
  Notification.Default(),
  Notification.Default(),
  Notification.Default(),
  Notification(
      "Test 2",
      "Give me money please",
      "1 min",
      Icon(
        Icons.handshake,
        size: 50,
      ))
];

class _NotificationsListState extends State<NotificationsList> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListView.builder(
        itemCount: testNotifications.length,
        shrinkWrap: true,
        padding: EdgeInsets.only(top: 16),
        physics: BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return NotificationCard(
              theme: theme, notification: testNotifications[index]);
        });
  }
}

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    required this.theme,
    required this.notification,
  });

  final ThemeData theme;
  final Notification notification;

  @override
  Widget build(BuildContext context) {
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
                Text(notification.timeString),
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
                        testNotifications,
                      )))
            ],
          ),
        ));
  }
}
