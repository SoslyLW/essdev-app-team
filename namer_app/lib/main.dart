import 'package:flutter/material.dart';
import 'package:namer_app/messages.dart';
import 'package:provider/provider.dart';
import 'package:namer_app/screens/toolCardPage.dart';
import 'package:namer_app/communities.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:namer_app/addToolPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseFirestore db = FirebaseFirestore.instance;

  runApp(MyApp(firestore: db,));
}


class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.firestore,
    });

  final FirebaseFirestore firestore;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme(
              background: Color(0xFFFFEBBA), //Used for bottom naviagation bar
              primary: Color(0xffFFF6D9), //Backkground/main colour of screens
              onPrimary: Color(0xff241d0f),
              secondary: Color(0xFFf5ab00), //Main orange colour
              onSecondary: Color(0xff241d0f),
              tertiary: Color(0xffd5dad2), //Secondary colour
              onTertiary: Color(0xff241d0f),
              onBackground: Color(0xff241d0f),
              brightness: Brightness.light,
              error: Colors.red,
              onError: Colors.white,
              surface:Color(0xFFf5ab00), //Default background for card-like widgets
              onSurface: Color(0xff241d0f)),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  // ID of the currently signed in user. To be used when creating
  // new tools. Automatically linked to current user.
  var thisUserID = "1";
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = AddToolPage();
      case 1:
        page = ToolCardPage(toolID: 1,);
      case 2:      
        page = MessagesPage();
      case 3:
        page = CommunitiesHomePage();
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              selectedIndex = index;
            });
          },
          indicatorColor: Theme.of(context).colorScheme.secondary,
          backgroundColor: Theme.of(context).colorScheme.background,
          selectedIndex: selectedIndex,
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.home),
              icon: Icon(Icons.home_outlined),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.handyman),
              label: 'Tools',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.message),
              icon: Icon(Icons.message_outlined),
              label: 'Messages',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.people_alt),
              icon: Icon(Icons.people_alt_outlined),
              label: 'Communities',
            ),
          ],
        ),
        body: Row(
          children: [
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: page,
              ),
            ),
          ],
        ),
      );
    });
  }
}