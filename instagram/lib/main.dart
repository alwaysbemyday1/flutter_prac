import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:instagram/tabs/feed/feed_page.dart' as feed;
import 'package:instagram/tabs/tab_page.dart';
import './style.dart' as style;
import 'tabs/feed/posting_page.dart' as posting;
import 'tabs/feed/profile_page.dart' as profile;
import './notification.dart' as notification;
import 'firebase_options.dart';

final auth = FirebaseAuth.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: ((context) => feed.MainProviderStore())),
      ChangeNotifierProvider(
          create: ((context) => profile.ProfileProviderStore())),
    ],
    child: MaterialApp(
      theme: style.theme,
      initialRoute: '/',
      routes: {
        '/': (context) => MyApp(),
        '/posting': (context) => posting.PostingPage(),
        '/profile': (context) => profile.ProfilePage()
      },
    ),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var tab = 0;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 100), () {
      notification.initNotifications(context);
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Provider.of<feed.MainProviderStore>(context, listen: false).getData();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const TabPage(),
      floatingActionButton: FloatingActionButton(
          child: Text('+'),
          onPressed: () {
            notification.showNotification2();
          }),
    );
  }
}
