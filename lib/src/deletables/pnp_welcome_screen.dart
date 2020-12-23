import 'package:e_grocery/src/components/welcome_screen_components.dart';
import 'package:e_grocery/src/pages/shoprite_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:e_grocery/src/constants/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PnPWelcomeScreen extends StatefulWidget {
  static const id = "pnpWelcomeScreen";
  @override
  _PnPWelcomeScreenState createState() => _PnPWelcomeScreenState();
}

class _PnPWelcomeScreenState extends State<PnPWelcomeScreen> with SingleTickerProviderStateMixin{


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
      curve: Interval(.0, .3, curve: Curves.easeIn),
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

    return Container();
//      Stack(
//      children: [
//        Container(
//          color: kBgPnP,
//        ),
//        Positioned(
//          top: -300,
//          left: -70,
//          child: Transform.rotate(
//            angle: 100,
//            child: SvgPicture.asset(
//              "assets/blob-3.svg",
//              width: screenHeight*1.2,
//            ),
//          ),
//        ),
//        Positioned(
//          top: 390,
//          right: 10,
//
//          child: Transform.rotate(
//            angle: 180,
//            child: SvgPicture.asset(
//              "assets/blob-2.svg",
//              color: Colors.white,
//              width: screenHeight*.93,
//            ),
//          ),
//        ),
//        Positioned(
//          top: 110,
//          left: 170,
//          child: Transform.rotate(
//            angle: 37,
//            child: SvgPicture.asset(
//              "assets/blob-3.svg",
//              color: Colors.black.withOpacity(1),
//              width: screenHeight*1.1,
//            ),
//          ),
//        ),
////        Positioned(
////          top: 20,
////          left: 50,
////          child: SvgPicture.asset(
////            "assets/pnp/pnp_w_1.svg",
////            width:  screenHeight*.4,
////          ),
////        ),
////        Positioned(
////          bottom: 50,
////          left: 30,
////          child: SvgPicture.asset(
////            "assets/pnp/pnp_w_2.svg",
////            width:  screenHeight*.43,
////          ),
////        ),
////        Positioned(
////          bottom: 330,
////          right: 10,
////          child: SvgPicture.asset(
////            "assets/pnp/pnp_w_3.svg",
////            width:  screenHeight*.05,
////          ),
////        ),
//        Padding(
//          padding: const EdgeInsets.symmetric(horizontal: 20),
//          child: Column(
//            crossAxisAlignment: CrossAxisAlignment.start,
//            children: [
//              Spacer(
//                flex: 7,
//              ),
//             WelcomeScreenHeader(
//                 headerTitle: "Pick n Pay",
//                 textHeaderFade: _textHeaderFade,
//                 textHeaderSlide: _textHeaderSlide,
//                 screenHeight: screenHeight
//
//             ),
//              Spacer(
//                flex: 1,
//              ),
//             WelcomeScreenDetailsText(
//               screenWidth: screenWidth,
//               textFade: _textFade,
//               textSlide: _textSlide,
//               text: "As a major retailer in Africa, the Group strives "
//                   "to address socio-economic challenges through the"
//                   " supply of high-quality, affordable food for all"
//                   " customers."
//             ),
//              Spacer(
//                flex: 2,
//              ),
//              WelcomeScreenButton(
//                text: "Coming Soon...",
//                color: kPnPSecondary,
//                navigationFunction: ()=> null,
//                buttonPop: _buttonPop,
//              ),
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
