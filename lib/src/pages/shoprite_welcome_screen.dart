import 'package:e_grocery/src/pages/shoprite_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:e_grocery/src/constants/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ShopriteWelcomeScreen extends StatefulWidget {
  static const id = "shopriteWelcomeScreen";
  @override
  _ShopriteWelcomeScreenState createState() => _ShopriteWelcomeScreenState();
}

class _ShopriteWelcomeScreenState extends State<ShopriteWelcomeScreen> {
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
//          bottom: -200,
//          left: -410,
          top: 70,
          left: 200,

          child: SvgPicture.asset(
            "assets/blob-2.svg",
            color: Colors.white,
            width: 700,
          ),
        ),
        Positioned(
//          bottom: -200,
//          left: -410,
          bottom: -190,
          left: -370,

          child: SvgPicture.asset(
            "assets/blob-3.svg",
            color: Colors.black,
            width: 800,
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

                    color: kBgShoprite ,

                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      child: Text(
                        "Explore",
                        style: TextStyle(
                            fontFamily: "Montserrat",
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 24),
                      ),
                      elevation: 1,
                      onPressed:() =>Navigator.pushNamed(context, ShopriteHomeScreen.id),
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
