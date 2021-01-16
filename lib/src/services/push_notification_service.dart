import 'dart:io';

import 'package:e_grocery/src/components/grocery_stores_provider_aggregate_methods.dart';
import 'package:e_grocery/src/pages/groceries_home.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class PushNotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging();

  Future init(context) async {
    if (Platform.isIOS) {
      _fcm.requestNotificationPermissions(IosNotificationSettings());
    }

    _fcm.configure(
        onMessage: (Map<String, dynamic> message) async {
          print("onMessage $message");
          print("onMessage ${message['notification']['title']}");
        }, onLaunch: (Map<String, dynamic> message) async {
      print("onMessage $message");
      _serialAndNavigate(message);
    }, onResume: (Map<String, dynamic> message) async {
      print("onMessage $message");
      _serialAndNavigate(message);
    });
  }

  static void _serialAndNavigate(Map<String, dynamic> message) {
    var notificationData = message['data'];
    var view = notificationData['view'];

    final GlobalKey<NavigatorState> navigatorKey =
    GlobalKey(debugLabel: "Main Navigator");
    print("serializing");

    if (view != null) {
      print("view is not null");
      if (view == 'groceries') {
        print("view is groceries");
        GroceryStoresProviderMethods.checkNullAndGetAllProductData(
            navigatorKey.currentState.context);
        navigatorKey.currentState
            .push(MaterialPageRoute(builder: (_) => GroceriesHomePage()));
        print(navigatorKey.currentWidget);


//        Navigator.pushNamed(_context, GroceriesHomePage.id);
      } else if (view == 'clothing') {
        print("herrrrrrrr");

//        navigatorKey.currentContext.describeElement(name)
      }
    }
  }
}
