
import 'package:flutter/material.dart';


class WoolworthsWelcomeScreen extends StatefulWidget {
  static const id = "woolworthsWelcomeScreen";
  @override
  _WoolworthsWelcomeScreenState createState() => _WoolworthsWelcomeScreenState();
}

class _WoolworthsWelcomeScreenState extends State<WoolworthsWelcomeScreen> with  SingleTickerProviderStateMixin{

  bool _isConnected = false;

  AnimationController _aController ;

  Animation<Offset>  _textHeaderSlide ;
  Animation<double>  _textHeaderFade ;


  Animation<Offset> _textSlide;
  Animation<double> _textFade;

  Animation _buttonPop;

  @override
  void initState() {
//    checkForConnection();

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



  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenHeight10p = screenHeight*(10/MediaQuery.of(context).size.height);
    final screenWidth10p =screenWidth* (10/MediaQuery.of(context).size.width);


    return Container();
//      Stack(
//      children: [
//        Container(
//          color: kBgWoolies,
//        ),
//        Positioned(
//          top: screenHeight10p*-30,
//          left: screenWidth10p*-46,
//          child: SvgPicture.asset(
//            "assets/blob-1.svg",
//            width: screenWidth10p*90,
//            color: Colors.white.withOpacity(.7),
//          ),
//        ),
//        Positioned(
////          bottom: -200,
////          left: -410,
//          top: screenHeight10p,
//          left: screenWidth10p*20,
//
//          child: SvgPicture.asset(
//            "assets/blob-2.svg",
//            color: Colors.white,
//            width: 70*screenWidth10p,
//          ),
//        ),
//        Positioned(
//          bottom: screenHeight10p*-18,
//          left: -37*screenWidth10p,
//          child: SvgPicture.asset(
//            "assets/blob-3.svg",
//            color: Colors.grey.withOpacity(.9),
//            width: 80*screenWidth10p,
//          ),
//        ),
////        Positioned(
////          top: 20,
////          left: 60,
////          child: SvgPicture.asset(
////            "assets/woolworths/woolies_w_1.svg",
////            width: 250,
////          ),
////        ),
////        Positioned(
////          bottom: 100,
////          left: 50,
////          child: SvgPicture.asset(
////            "assets/woolworths/woolies_w_2.svg",
////            width: 300,
////          ),
////        ),
//        Padding(
//          padding: const EdgeInsets.symmetric(horizontal: 20),
//          child: Column(
////            mainAxisAlignment: MainAxisAlignment.start,
//            crossAxisAlignment: CrossAxisAlignment.start,
//            children: [
//              Spacer(
//                flex: 7,
//              ),
//             WelcomeScreenHeader(textHeaderFade: _textHeaderFade,
//                 textHeaderSlide: _textHeaderSlide,
//                 screenHeight: screenHeight,
//                 headerTitle: "Woolworths",),
//              Spacer(
//                flex: 1,
//              ),
//            WelcomeScreenDetailsText(
//
//              text: "Building on our reputation for superior quality, "
//                  "exciting innovation and excellent value.",
//                textFade: _textFade,
//                textSlide: _textSlide,
//                screenWidth: screenWidth,
//),
//              Spacer(
//                flex: 2,
//              ),
//          WelcomeScreenButton(
//            text: "Coming Soon...",
//            color: kWooliesSecondary,
//
//            navigationFunction: ()=> null,
//            buttonPop: _buttonPop,
//          ),
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
