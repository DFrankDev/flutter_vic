import 'dart:async';

import 'package:flutter/material.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:workmanager/workmanager.dart';

import 'contacts/ContactManager.dart';
import 'contacts/widgets/ContactsList.dart';
import 'contacts/widgets/EmptyContacts.dart';
import 'notifications/NotificationManager.dart';

void callbackDispatcher() {
  Workmanager.executeTask((backgroundTask) async {
    return Future.value(true);
  });
}

void main() {
  Workmanager.initialize(callbackDispatcher);
  Workmanager.registerPeriodicTask(
      "task",
      "check contect engagement",
      frequency: Duration(minutes: 20)
  );

  runApp(MyApp());
}
enum OverflowMenu { test }

class MyApp extends StatelessWidget {

  static final navigatorKey = new GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        home: MainPage()
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  MainPageState createState() => MainPageState();
}

class MainPageState extends State<MainPage> {

  List<Contact> _contacts = new List();
  Timer _timer;

  @mustCallSuper
  void initState() {
    super.initState();

    NotificationManager.init();
    _timer = Timer.periodic(new Duration(seconds: 60), NotificationManager.displayNotification);

    ContactManager.reloadContacts((_contacts) =>
        setState(() {
          this._contacts = _contacts;
        }));
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_contacts.length > 0 ? 'Contacts' : 'Main'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search, color: Colors.white,)),
          PopupMenuButton<OverflowMenu>(
            onSelected: (OverflowMenu result) {
              setState(() {});
            },
            itemBuilder: (BuildContext context) =>
            <PopupMenuEntry<OverflowMenu>>[
            ],
          )
        ],
      ),
      drawer: Drawer(),
      body: _contacts.length > 0 ? ContactList(_contacts) : EmptyContacts(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () =>
            ContactManager.contactChooser((_contacts) =>
                setState(() {
                  this._contacts = _contacts;
                })),
      ),
    );
  }
}