import 'package:e_grocery/src/components/welcome_screen_components.dart';
import 'package:e_grocery/src/networking/connection_test.dart';
import 'file:///C:/Users/Taku/AndroidStudioProjects/e_grocery/lib/src/pages/groceries_home_screens/shoprite_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:e_grocery/src/constants/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:io';

class ShopriteWelcomeScreen extends StatefulWidget {
  static const id = "shopriteWelcomeScreen";
  @override
  _ShopriteWelcomeScreenState createState() => _ShopriteWelcomeScreenState();
}

class _ShopriteWelcomeScreenState extends State<ShopriteWelcomeScreen> with SingleTickerProviderStateMixin {

  bool _isConnected = false;

  AnimationController _aController ;

  Animation<Offset>  _textHeaderSlide ;
  Animation<double>  _textHeaderFade ;


  Animation<Offset> _textSlide;
  Animation<double> _textFade;

  Animation _buttonPop;

  void checkNetwork()  async{
      _isConnected = await  TestConnection.checkForConnection();
  }

  @override
  void initState() {
    checkNetwork();

    _aController =   AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000),

    ) ;

    _aController.forward();

    _textHeaderSlide = Tween<Offset>(
      begin: Offset(1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _aController,
      curve: Interval(0, .3, curve: Curves.easeIn),
    ));

    _textHeaderFade = CurvedAnimation(
      parent: _aController,
      curve: Interval(0, .2, curve: Curves.easeOut,),
    );


    _textSlide = Tween<Offset>(
      begin: Offset(1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _aController,
      curve: Interval(.2, .5, curve: Curves.easeOut),
    ));

    _textFade = CurvedAnimation(
      parent: _aController,
      curve: Interval(0.2, .3, curve: Curves.easeOut,),
    );



    _buttonPop = Tween<double>(
      begin: 0,
      end: 1
    ).animate( CurvedAnimation(
      parent: _aController,
      curve: Interval(0.7, 1, curve: Curves.bounceOut,),
    ));


_aController.addListener(() => setState(() {}) );

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _aController.dispose();
  }



//  void checkForConnection() async {
//    try {
//      final result = await InternetAddress.lookup('google.com');
//      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
//        setState(() {
//          _isConnected = true;
//        });
//
//        print('connected');
//      }
//    } on SocketException catch (_) {
//      setState(() {
//        _isConnected = false;
//      });
//      print('not connected');
//    }
//  }

//  Future<void> _showNetworkDialog() async {
//    return showDialog<void>(
//      context: context,
//      barrierDismissible: true,
//      builder: (BuildContext context) {
//        return AlertDialog(
//          title: Text('Please connect to a network'),
//          content: SingleChildScrollView(
//            child: ListBody(
//              children: <Widget>[
//                Text(
//                  'An internet connection is required for this app, please make sure you are'
//                  ' connected to a network and try again',
//                  style: TextStyle(
//                    fontFamily: "Montserrat",
//                    color: Colors.black,
//                  ),
//                ),
////                Text('Would you like to approve of this message?'),
//              ],
//            ),
//          ),
//          actions: <Widget>[
//            TextButton(
//              child: Text(
//                'Back',
//                style: TextStyle(color: kBgShoprite),
//              ),
//              onPressed: () {
//                Navigator.of(context).pop();
//              },
//            ),
//          ],
//        );
//      },
//    );
//  }

  @override
  Widget build(BuildContext context) {



    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;


    return Container();
//      Stack(
//      children: [
//        Container(
//          color: kBgShoprite,
//        ),
//        Positioned(
//          top: -screenHeight*.4,
//          left: -screenWidth*.85,
//          child: SvgPicture.asset(
//            "assets/blob-1.svg",
//            width: screenHeight*1.2,
//          ),
//        ),
//        Positioned(
//          top: screenHeight*.08,
//          left: screenWidth*.55,
//
//          child: SvgPicture.asset(
//            "assets/blob-2.svg",
//            color: Colors.white,
//            width:  screenHeight*.93,
//          ),
//        ),
//
//        Positioned(
//          bottom: -screenHeight*.28,
//          left: -screenWidth*.88,
//
//          child: SvgPicture.asset(
//            "assets/blob-3.svg",
//            color: Colors.black,
//            width:  screenHeight*1.1,
//          ),
//        ),
////        Positioned(
////          left: screenWidth*.08,
////          top: screenHeight*.03,
////
////          child: SvgPicture.asset(
////            "assets/shoprite/shoprite_w_1.svg",
//////            color: Colors.black,
////            width:  screenHeight*.4,
////          ),
////        ),
////        Positioned(
////          left: 50,
////          bottom: 120,
////
////          child: SvgPicture.asset(
////            "assets/shoprite/shoprite_w_2.svg",
//////            color: Colors.black,
////            width:  screenHeight*.4,
////          ),
////        ),
////
////        Positioned(
////          right: 50,
////          bottom: 300,
////
////          child: Transform.rotate(
////            angle: 70,
////            child: SvgPicture.asset(
////              "assets/shoprite/shoprite_w_3.svg",
//////            color: Colors.black,
////              width:  screenHeight*.05,
////            ),
////          ),
////        ),
//
//
//        Padding(
//          padding: const EdgeInsets.symmetric(horizontal: 20),
//          child: Column(
////            mainAxisAlignment: MainAxisAlignment.start,
//            crossAxisAlignment: CrossAxisAlignment.start,
//            children: [
//              Spacer(
//                flex: 7,
//              ),
//              WelcomeScreenHeader(
//                headerTitle: "Shoprite",
//                  textHeaderFade: _textHeaderFade,
//                  textHeaderSlide: _textHeaderSlide,
//                  screenHeight: screenHeight),
//              Spacer(
//                flex: 1,
//              ),
//              WelcomeScreenDetailsText(
//                text: "The Largest retailer in South Africa "
//                    "bringing the lowest prices in quality food and essential home "
//                    "goods to its customers.",
//                  textFade: _textFade,
//                  textSlide: _textSlide,
//                  screenWidth: screenWidth),
//              Spacer(
//                flex: 2,
//              ),
//             WelcomeScreenButton(
//               text: "Explore",
//            color: kBgShoprite,
//               buttonPop: _buttonPop,
//               navigationFunction: () {
//                 _isConnected
//                     ? Navigator.pushNamed(context, ShopriteHomeScreen.id)
//                     : TestConnection.showNetworkDialog(context);
//               } ,
//             ),
//              Spacer(
//                flex: 1,
//              ),
//            ],
//          ),
//        )
//      ],
//    );
  }
}


