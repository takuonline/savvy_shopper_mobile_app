import 'package:e_grocery/src/pages/shoprite_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:e_grocery/src/constants/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:io';

class ShopriteWelcomeScreen extends StatefulWidget {
  static const id = "shopriteWelcomeScreen";
  @override
  _ShopriteWelcomeScreenState createState() => _ShopriteWelcomeScreenState();
}

class _ShopriteWelcomeScreenState extends State<ShopriteWelcomeScreen> {
  bool _isConnected = false;

  @override
  void initState() {
    checkForConnection();
  }

  void checkForConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          _isConnected = true;
        });

        print('connected');
      }
    } on SocketException catch (_) {
      setState(() {
        _isConnected = false;
      });
      print('not connected');
    }
  }

  Future<void> _showNetworkDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Please connect to a network'),
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

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: kBgShoprite,
        ),
        Positioned(
          top: -300,
          left: -410,
          child: SvgPicture.asset(
            "assets/blob-1.svg",
            width: 900,
          ),
        ),
        Positioned(

          top: 70,
          left: 200,

          child: SvgPicture.asset(
            "assets/blob-2.svg",
            color: Colors.white,
            width: 700,
          ),
        ),

        Positioned(
          bottom: -190,
          left: -370,

          child: SvgPicture.asset(
            "assets/blob-3.svg",
            color: Colors.black,
            width: 800,
          ),
        ),
        Positioned(
          left: 50,
          top: 30,

          child: SvgPicture.asset(
            "assets/shoprite/shoprite_w_1.svg",
//            color: Colors.black,
            width: 300,
          ),
        ),
        Positioned(
          left: 50,
          bottom: 120,

          child: SvgPicture.asset(
            "assets/shoprite/shoprite_w_2.svg",
//            color: Colors.black,
            width: 300,
          ),
        ),

        Positioned(
          right: 50,
          bottom: 280,

          child: Transform.rotate(
            angle: 70,
            child: SvgPicture.asset(
              "assets/shoprite/shoprite_w_3.svg",
//            color: Colors.black,
              width: 50,
            ),
          ),
        ),


        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
//            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacer(
                flex: 7,
              ),
              Text(
                "Shoprite",
                style: TextStyle(
                    fontFamily: "Montserrat",
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.none),
              ),
              Spacer(
                flex: 1,
              ),
              Text(
                "The Largest retailer in South Africa "
                    "bringing the lowest prices in quality food and essential home "
                    "goods to its customers.",
                style: TextStyle(
                    fontFamily: "Montserrat",
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1,
                    height: 1.5,
                    decoration: TextDecoration.none),
              ),
              Spacer(
                flex: 2,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(

                    color: kBgShoprite,

                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    child:

                    Text(
                      "Explore",
                      style: TextStyle(
                          fontFamily: "Montserrat",
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 24),
                    ),
                    elevation: 1,
                    onPressed: () {
                      _isConnected
                          ? Navigator.pushNamed(context, ShopriteHomeScreen.id)
                          : _showNetworkDialog();
                    },
                  )

                ],
              ),
              Spacer(
                flex: 1,
              ),
            ],
          ),
        )
      ],
    );
  }
}
