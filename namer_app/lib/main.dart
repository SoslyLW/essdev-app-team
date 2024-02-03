import 'package:flutter/material.dart';
import 'package:namer_app/loginpage.dart';
import 'package:namer_app/messages.dart';
import 'package:provider/provider.dart';
import 'package:namer_app/communitiesHomePage.dart';
import 'package:namer_app/screens/toolCardPage.dart';
import 'package:namer_app/profile.dart';
import 'package:namer_app/settings.dart';
import 'package:namer_app/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:namer_app/registerpage.dart';
void main() async {
  runApp(MyApp());
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
              surface:
                  Color(0xFFf5ab00), //Default background for card-like widgets
              onSurface: Color(0xff241d0f)),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = 0;
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
        page = NotificationsPage();
      case 1:
        page = ToolCardPage(
          toolID: 1,
        );
      case 2:
        page = MessagesPage();
      case 3:
        page = CommunitiesHomePage();
        case 4:
        page = LoginPage();
        break;
        case 5:
        page = RegisterPage();
        break;
      case 4:
        page = LoginPage();
        break;
        case 5:
        page = RegisterPage();
        break;
      case 4:
        page = LoginPage();
        break;
        case 5:
        page = RegisterPage();
        break;
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        appBar: AppBar(
          title: Text('ToolPool'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.man_3_rounded),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
            ),
          ],
        ),
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
              icon: Icon(Icons.business),
              label: 'Business',
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
            NavigationDestination(
              selectedIcon: Icon(Icons.account_circle),
              icon: Icon(Icons.account_circle),
              label: 'Login Page',
            ),
             NavigationDestination(
              selectedIcon: Icon(Icons.remember_me),
              icon: Icon(Icons.remember_me),
              label: 'Registration Page',
            )
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
class GeneratorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigCard(pair: pair),
          SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  appState.toggleFavorite();
                },
                icon: Icon(icon),
                label: Text('Like'),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  appState.getNext();
                },
                child: Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var favs = appState.favorites;

    if (favs.isEmpty) {
      return Center(
        child: Text('No favorites yet.'),
      );
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text('You have '
                  '${appState.favorites.length} favorites:'),
            ),
            for (var fav in favs)
              ListTile(
                leading: Icon(Icons.favorite),
                title: Text(fav.toString()),
              ),
          ],
        ),
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          pair.asLowerCase,
          style: style,
          semanticsLabel: "${pair.first} ${pair.second}",
        ),
      ),
    );
  }
}
