import 'package:e_grocery/src/pages/shoprite_home_screen.dart';
import 'package:flutter/material.dart';
import 'package:e_grocery/src/constants/constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PnPWelcomeScreen extends StatefulWidget {
  static const id = "pnpWelcomeScreen";
  @override
  _PnPWelcomeScreenState createState() => _PnPWelcomeScreenState();
}

class _PnPWelcomeScreenState extends State<PnPWelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: kBgPnP,
        ),
        Positioned(
          top: -300,
          left: -70,
          child: Transform.rotate(
            angle: 100,
            child: SvgPicture.asset(
              "assets/blob-3.svg",
              width: 900,
            ),
          ),
        ),
        Positioned(
          top: 390,
          right: 10,

          child: Transform.rotate(
            angle: 180,
            child: SvgPicture.asset(
              "assets/blob-2.svg",
              color: Colors.white,
              width: 700,
            ),
          ),
        ),
        Positioned(
          top: 230,
          left: 100,
          child: Transform.rotate(
            angle: 80,
            child: SvgPicture.asset(
              "assets/blob-1.svg",
              color: Colors.black.withOpacity(.5),
              width: 800,
            ),
          ),
        ),
        Positioned(
          top: 20,
          left: 50,
          child: SvgPicture.asset(
            "assets/pnp/pnp_w_1.svg",
            width: 300,
          ),
        ),
        Positioned(
          bottom: 50,
          left: 30,
          child: SvgPicture.asset(
            "assets/pnp/pnp_w_2.svg",
            width: 380,
          ),
        ),
        Positioned(
          bottom: 330,
          right: 10,
          child: SvgPicture.asset(
            "assets/pnp/pnp_w_3.svg",
            width: 50,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacer(
                flex: 7,
              ),
              Text(
                "Pick n Pay",
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
               "As a major retailer in Africa, the Group strives "
                   "to address socio-economic challenges through the"
                   " supply of high-quality, affordable food for all"
                   " customers.",
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

                    color: Color(0xffa70240) ,

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
                    onPressed:() =>null
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
