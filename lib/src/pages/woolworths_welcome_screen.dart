import 'package:e_grocery/src/pages/shoprite_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:e_grocery/src/constants/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WoolworthsWelcomeScreen extends StatefulWidget {
  static const id = "woolworthsWelcomeScreen";
  @override
  _WoolworthsWelcomeScreenState createState() => _WoolworthsWelcomeScreenState();
}

class _WoolworthsWelcomeScreenState extends State<WoolworthsWelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: kBgWoolies,
        ),
        Positioned(
          top: -300,
          left: -460,
          child: SvgPicture.asset(
            "assets/blob-1.svg",
            width: 900,
            color: Colors.white.withOpacity(.7),
          ),
        ),
        Positioned(
//          bottom: -200,
//          left: -410,
          top: 10,
          left: 200,

          child: SvgPicture.asset(
            "assets/blob-2.svg",
            color: Colors.white,
            width: 700,
          ),
        ),
        Positioned(
          bottom: -180,
          left: -370,
          child: SvgPicture.asset(
            "assets/blob-3.svg",
            color: Colors.grey.withOpacity(.9),
            width: 800,
          ),
        ),
        Positioned(
          top: 20,
          left: 60,
          child: SvgPicture.asset(
            "assets/woolworths/woolies_w_1.svg",
            width: 250,
          ),
        ),
        Positioned(
          bottom: 100,
          left: 50,
          child: SvgPicture.asset(
            "assets/woolworths/woolies_w_2.svg",
            width: 300,
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
                "Woolworths",
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
                  "Building on our reputation for superior quality, "
                      "exciting innovation and excellent value.",
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

                    color: kWooliesSecondary ,

                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                    child: Text(
                      "Coming Soon...",
                      style: TextStyle(
                          fontFamily: "Montserrat",
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 24),
                    ),
                    elevation: 1,
                    onPressed:() =>null,
//                        Navigator.pushNamed(context, ShopriteHomeScreen.id),
                  ),
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
