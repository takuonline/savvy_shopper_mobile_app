import 'package:e_grocery/src/constants/constants.dart';
import 'package:e_grocery/src/pages/pnp_welcome_screen.dart';
import 'package:e_grocery/src/pages/shoprite_welcome_screen.dart';
import 'package:e_grocery/src/pages/woolworths_welcome_screen.dart';
import 'package:e_grocery/src/providers/shoprite_product_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const id = "home";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
//      backgroundColor: kTextFieldBgGrey,

      appBar: AppBar(
        title: Text("Home",
          style: TextStyle(
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w700,
              fontSize: 24
          ),
        ),
        backgroundColor: kBgBlue,
      ),
      body: Container(
          color: kTextFieldBgGrey,
          child: ListView(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Text(
                  "Welcome",
                  style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w700,
                      color: kTextColor,
                      fontSize: 40),
                ),
              ),
              InkWell(
                onTap: () {
                  Provider.of<AllProductList>(context,listen:false).getItems();
                  Navigator.pushNamed(context, ShopriteWelcomeScreen.id);},
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Container(
                    width: screenWidth * .8,
                    height: screenHeight * .24,
                    decoration: BoxDecoration(
                        color: kBgShoprite,
                        borderRadius: BorderRadius.circular(20)),
                    child: Stack(
                      children: [




                        Positioned(
                      left: -80,
                      bottom: -50,
                      child: SvgPicture.asset(
                        "assets/blob-1.svg",
                        height: 220,
                        color: Colors.black.withOpacity(.3),

                      ),

                        ),

                    Positioned(
                      right: 20,
                      bottom: 30,
                      child: SvgPicture.asset(
                        "assets/shoprite/shoprite_cart.svg",
                        height: 110,
                        color: Colors.white,

                      ),)
                        ,
                        Positioned(
                          bottom: 20,
                          left: 20,
                          child: Text("Shoprite",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w700,
                                fontSize: 40),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, PnPWelcomeScreen.id);

                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Container(
                    width: screenWidth * .8,
                    height: screenHeight * .24,
                    decoration: BoxDecoration(
                        color: kBgPnP,
                        borderRadius: BorderRadius.circular(20)),
                    child: Stack(
                      children: [
                        Positioned(
                          right: -80,
                          bottom: -100,
                          child: SvgPicture.asset(
                            "assets/blob-1.svg",
                            height: 220,
                            color: Colors.black.withOpacity(.3),

                          ),

                        ),

                        Positioned(
                          left: 40,
                          bottom: 70,
                          child: SvgPicture.asset(
                            "assets/pnp/pnp_cart.svg",
                            height: 70,
                            color: Colors.white,

                          ),)
                        ,
                        Positioned(
                          bottom: 20,
                          right: 20,
                          child: Text("Pick n Pay",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 40)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: ()=> Navigator.pushNamed(context, WoolworthsWelcomeScreen.id),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Container(
                    width: screenWidth * .8,
                    height: screenHeight * .24,
                    decoration: BoxDecoration(
                        color: kBgWoolies,
                        borderRadius: BorderRadius.circular(20)),
                    child: Stack(
                      children: [
                        Positioned(
                          left: -80,
                          top: -100,
                          child: SvgPicture.asset(
                            "assets/blob-1.svg",
                            height: 220,
                            color: Colors.white.withOpacity(.2),

                          ),
                        ),

                        Positioned(
                          right: 30,
                          bottom: 60,
                          child: SvgPicture.asset(
                            "assets/woolworths/woolies_cart.svg",
                            height: 80,
                            color: Colors.white,

                          ),)
                        ,
                        Positioned(
                          bottom: 20,
                          left: 20,
                          child: Text("Woolworths",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 40)),
                        ),



                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
      ),
    );
  }
}


