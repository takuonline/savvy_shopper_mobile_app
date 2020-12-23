

import 'dart:io';
import 'package:e_grocery/src/constants/constants.dart';
import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';

class TestConnection {

  static Future<bool> checkForConnection() async {

    bool isConnected = false;

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {

        isConnected = true;
         print('connected');
      }
    } on SocketException catch (_) {

      isConnected = false;
      print('not connected');
    }


    return isConnected;


  }
  static Future<void> showNetworkDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Please check your Network'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'An internet connection is required for this app, please make sure you are'
                      ' connected to a network and try again',
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    color: Colors.black,
                  ),
                ),
//                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Back',
                style: TextStyle(color: kBgShoprite),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}


