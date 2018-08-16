import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'new_concerts.dart';

class App extends StatefulWidget {

  App({Key key}) : super(key: key);

  @override
  _AppState createState() => new _AppState();
}

class _AppState extends State<App> {
  final FirebaseMessaging _firebaseMessaging = new FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      print(token);
    });
  }

    // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('Live in Conert'),
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.new_releases)),
                Tab(icon: Icon(Icons.music_note)),
              ]
            )
          ),
          body: TabBarView(
            children: [
             MyHomePage(title: 'home') ,
             MyHomePage(title: 'second'),
            ],
          )
        )
      )
    );
  }
}
