import 'dart:async';
import 'dart:math';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_vic/contacts/screens/contact_view.dart';
import '../main.dart';

class NotificationManager{

  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();

  static void init(){
    var initializationSettingsAndroid =
    new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = new IOSInitializationSettings(
        onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    var initializationSettings = new InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  static Future onDidReceiveLocalNotification(int id, String title, String body,
      String payload) async {
  }

  static Future onSelectNotification(String payload) async {
    if (payload != null) {
      Iterable<Contact> contacts = await ContactsService.getContacts(
          query: payload);

      for (Contact contact in contacts)
        if (contact != null && contact.displayName == payload) {
          Navigator.push(
            MyApp.navigatorKey.currentState.context,
            MaterialPageRoute(
                builder: (context) => ContactView(contact)),
          );
        }
    }
  }

  static void displayNotification(Timer t) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();

    for (String key in prefs.getKeys()) {
      String phone = prefs.getString(key);
      if (int.tryParse(phone.substring(phone.length - 2)) % 2 == 0) {
        var androidPlatformChannelSpecifics = AndroidNotificationDetails(
            'channel_id', 'channel_name', 'channel_description');

        var iOSPlatformChannelSpecifics = IOSNotificationDetails();
        var platformChannelSpecifics = NotificationDetails(
            androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

        await flutterLocalNotificationsPlugin.show(
            Random().nextInt(10000), 'Reminder', '$key Engagement out of date',
            platformChannelSpecifics,
            payload: key);
      }
    }
  }

}