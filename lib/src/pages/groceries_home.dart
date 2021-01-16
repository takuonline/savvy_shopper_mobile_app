import 'package:e_grocery/src/pages/groceries_home_screens/pnp_home_screen.dart';
import 'package:e_grocery/src/pages/welcome_screen.dart';
import 'package:e_grocery/src/components/welcome_screen_components.dart';
import 'package:e_grocery/src/constants/constants.dart';
import 'package:e_grocery/src/pages/groceries_home_screens/shoprite_home_screen.dart';
import 'package:e_grocery/src/pages/groceries_home_screens/woolies_home_screen.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class GroceriesHomePage extends StatefulWidget {
  static const id = "/groceriesHome";

  @override
  _GroceriesHomePageState createState() => _GroceriesHomePageState();
}

class _GroceriesHomePageState extends State<GroceriesHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _aController;

  Animation<double> _textFadeAnimation;
  Animation<Offset> _textSlide;

  Animation<Offset> _shopriteSlide;
  Animation<Offset> _pnpSlide;
  Animation<Offset> _woolworthsSlide;

  bool _isInit = false;
  bool _pnpIsInit = false;
  bool _wooliesIsInit = false;


  @override
  void initState() {
    super.initState();

//
//    if (!_isInit) {
//      Provider.of<AllProductList>(context,listen:false).getItems();
//      setState(() {
//        _isInit = true;
//      });
//    }
//
//    if (!_pnpIsInit) {
//      Provider.of<PnPAllProductList>(context,listen:false).getItems();
//      setState(() {
//        _pnpIsInit = true;
//      });
//    }
//
//    if (!_wooliesIsInit) {
//      Provider.of<WooliesAllProductList>(context,listen:false).getItems();
//      setState(() {
//        _wooliesIsInit = true;
//      });
//    }

    _aController = AnimationController(
      duration: Duration(milliseconds: 3000),
      vsync: this,
    );

    _aController.forward();

    _textFadeAnimation = CurvedAnimation(
      parent: _aController,
      curve: Interval(
        0,
        .4,
        curve: Curves.easeOut,
      ),
    );

    _textSlide = Tween<Offset>(
      begin: Offset(0, -0.15),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _aController,
      curve: Interval(0, .5, curve: Curves.easeOut),
    ));

    _shopriteSlide = Tween<Offset>(
      begin: Offset(2, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _aController,
      curve: Interval(.6, .8, curve: Curves.easeOut),
    ));

    _pnpSlide = Tween<Offset>(
      begin: Offset(2, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _aController,
      curve: Interval(.7, .9, curve: Curves.easeOut),
    ));

    _woolworthsSlide = Tween<Offset>(
      begin: Offset(2, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _aController,
      curve: Interval(.8, 1, curve: Curves.easeOut),
    ));

    _aController.reverseDuration = Duration(milliseconds: 1500);
    _aController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _aController.dispose();
    super.dispose();
  }

  Future<void> _whenCardIsClicked() async {
    _aController.reverse();
    await Future.delayed(
      Duration(milliseconds: 2500),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenHeight10p =
        screenHeight * (10 / MediaQuery.of(context).size.height);
    final screenWidth10p =
        screenWidth * (10 / MediaQuery.of(context).size.width);
    final cardHeight = screenHeight * .24;
    final cardWidth = screenWidth * .9;
    final cardBorderRadius = BorderRadius.circular(20);
    final cardPadding = EdgeInsets.symmetric(horizontal: 20, vertical: 10);
    final _cardBoxShadow = BoxShadow(
        color: Colors.black.withOpacity(.15),
        spreadRadius: 10,
        blurRadius: 15,
        offset: Offset(10, 0));

    final Map<String, WelcomeScreenItem> _welcomeScreenItemMap = {
      'shoprite': WelcomeScreenItem(
        header: "Shoprite",
        details: "The Largest retailer in South Africa "
            "bringing the lowest prices in quality food and essential home "
            "goods to its customers.",
        blob1: Positioned(
          top: -screenHeight * .4,
          left: -screenWidth * .85,
          child: SvgPicture.asset(
            "assets/blob-1.svg",
            width: screenHeight * 1.2,
          ),
        ),
        blob2: Positioned(
          top: screenHeight * .08,
          left: screenWidth * .55,
          child: SvgPicture.asset(
            "assets/blob-2.svg",
            color: Colors.white,
            width: screenHeight * .93,
          ),
        ),
        blob3: Positioned(
          bottom: -screenHeight * .28,
          left: -screenWidth * .88,
          child: SvgPicture.asset(
            "assets/blob-3.svg",
            color: Colors.black,
            width: screenHeight * 1.1,
          ),
        ),
        bgColor: kBgShoprite,

        btn: WelcomeScreenButton(
          text: "Explore",
          color: kBgShoprite,
          navigationFunction: () async {
//                            bool _isConnected =  await TestConnection.checkForConnection();
//
//                           _isConnected

            Navigator.pushNamed(
                context, ShopriteHomeScreen.id);
//                                : TestConnection.showNetworkDialog(context);
          },
        ),
      ),
      'pnp': WelcomeScreenItem(
        header: "Pick n Pay",
        details:
        "As a major retailer in Africa, the Group strives "
            "to address socio-economic challenges through the"
            " supply of high-quality, affordable food for all"
            " customers.",
        blob1: Positioned(
          top: -300,
          left: -70,
          child: Transform.rotate(
            angle: 100,
            child: SvgPicture.asset(
              "assets/blob-3.svg",
              width: screenHeight * 1.2,
            ),
          ),
        ),
        blob2: Positioned(
          top: 390,
          right: 10,
          child: Transform.rotate(
            angle: 180,
            child: SvgPicture.asset(
              "assets/blob-2.svg",
              color: Colors.white,
              width: screenHeight * .93,
            ),
          ),
        ),
        blob3: Positioned(
          top: 110,
          left: 170,
          child: Transform.rotate(
            angle: 37,
            child: SvgPicture.asset(
              "assets/blob-3.svg",
              color: Colors.black.withOpacity(1),
              width: screenHeight * 1.1,
            ),
          ),
        ),
        bgColor: kBgPnP,
        btn: WelcomeScreenButton(
          text: "Explore",
          color: kPnPSecondary,
          navigationFunction: () async {
            Navigator.pushNamed(context, PnPHomeScreen.id);
          },
        ),
      ),
      'woolies': WelcomeScreenItem(
        header: "Woolworths",
        details:
        "Building on our reputation for superior quality, "
            "exciting innovation and excellent value.",
        blob1: Positioned(
          top: screenHeight10p * -30,
          left: screenWidth10p * -46,
          child: SvgPicture.asset(
            "assets/blob-1.svg",
            width: screenWidth10p * 90,
            color: Colors.white.withOpacity(.7),
          ),
        ),
        blob2: Positioned(
          top: screenHeight10p,
          left: screenWidth10p * 20,

          child: SvgPicture.asset(
            "assets/blob-2.svg",
            color: Colors.white,
            width: 70 * screenWidth10p,
          ),
        ),
        blob3: Positioned(
          bottom: screenHeight10p * -18,
          left: -37 * screenWidth10p,
          child: SvgPicture.asset(
            "assets/blob-3.svg",
            color: Colors.grey.withOpacity(.9),
            width: 80 * screenWidth10p,
          ),
        ),
        bgColor: kBgWoolies,
        btn: WelcomeScreenButton(
          text: "Explore",
          color: kWooliesSecondary,
          navigationFunction: () async {
            Navigator.pushNamed(context, WooliesHomeScreen.id);
          },
        ),
      )
    };

//    ScreenUtil.init(constrants);
//    allowFontScaling:false;
//    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);

//If the design is based on the size of the iPhone6 ​​(iPhone6 ​​750*1334)
//    ScreenUtil.instance = ScreenUtil()..init(context);


    return Scaffold(
      body: Container(
        color: kTextFieldBgGrey,
        child: ListView(
          children: [
            Container(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: screenHeight * .35,
                    decoration: BoxDecoration(),
                    child: SvgPicture.asset(
                      "assets/main_menu/grocery_shoppinglist_bg.svg",
                      width: screenWidth * 4,
                      fit: BoxFit.cover,

                    ),
                  ),
                  Positioned.fill(
                      child: Container(
//                          color: Colors.black.withOpacity(.5),
                        decoration: BoxDecoration(
//                              color: kBgShoprite,
                          gradient: RadialGradient(
                            radius: .5,
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(.3),
                            ],
                          ),
                        ),
                      )),
                  Positioned(
                    bottom: screenHeight10p * 4,
                    child: FadeTransition(
                      opacity: _textFadeAnimation,
                      child: SlideTransition(
                        position: _textSlide,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth10p * 2,
                              vertical: screenHeight10p * 3),
                          child: Text(
                            "Groceries",
                            style: TextStyle(
                                fontFamily: "Montserrat",
                                fontWeight: FontWeight.w800,
                                color: Colors.white,
                                fontSize: screenWidth10p * 4),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Transform.translate(
              offset: Offset(0, -screenHeight * .05),
              child: Container(
                decoration: BoxDecoration(
                    color: kTextFieldBgGrey,
                    borderRadius: BorderRadius.circular(
                        screenWidth * .07
                    )
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: screenHeight10p * 4,
                    ),
                    SlideTransition(
                      position: _shopriteSlide,
                      child: InkWell(
                        onTap: () async {
//                      if (!_isInit) {
//                      Provider.of<ShopriteAllProductList>(context,listen:false).getItems();
//                        setState(() {
//                          _isInit = true;
//                        });
//                      }
                          final _item = _welcomeScreenItemMap['shoprite'];
                          await _whenCardIsClicked();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WelcomeScreen(_item),
                            ),
                          );
                          _aController.animateTo(
                              1, duration: Duration(milliseconds: 4000));
                        },
                        child: ClipRRect(
                          borderRadius: cardBorderRadius,
                          child: Container(
                            width: cardWidth,
                            height: cardHeight,
                            padding: cardPadding,
                            decoration: BoxDecoration(
                                boxShadow: [_cardBoxShadow],
                                gradient: LinearGradient(
                                  colors: [
                                    kBgShoprite,
                                    kBgShoprite.withRed(160),
                                  ],
                                ),
                                borderRadius: cardBorderRadius),
                            child: Stack(
                              children: [
//                              Positioned(
//                                left: -80,
//                                bottom: -50,
//                                child: SvgPicture.asset(
//                                  "assets/blob-1.svg",
//                                  height: screenHeight * .31,
//                                  color: Colors.black.withOpacity(.3),
//                                ),
//                              ),

                                Positioned(
                                  right: 30,
                                  bottom: 40,
                                  child: SvgPicture.asset(
                                    "assets/grocery_card_svg/trolley.svg",
                                    height: screenWidth * .23,

                                  ),
                                ),
                                Positioned(
                                  bottom: 20,
                                  left: 20,
                                  child: FittedBox(
                                    child: Text(
                                      "Shoprite",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Montserrat",
                                        fontWeight: FontWeight.w700,
                                        fontSize: screenWidth * .08,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SlideTransition(
                      position: _pnpSlide,
                      child: InkWell(
                        onTap: () async {
//
//                      if (!_pnpIsInit) {
//                        Provider.of<PnPAllProductList>(context,listen:false).getItems();
//                        setState(() {
//                          _pnpIsInit = true;
//                        });
//                      }


                          final _item = _welcomeScreenItemMap['pnp'];
                          await _whenCardIsClicked();


                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WelcomeScreen(_item),
                            ),
                          );

                          _aController.animateTo(
                              1, duration: Duration(milliseconds: 4000));
                        },
                        child: Padding(
                          padding: cardPadding,
                          child: ClipRRect(
                            borderRadius: cardBorderRadius,
                            child: LayoutBuilder(
                              builder: (_, constraints) {
                                final _cardHeaderStyle = TextStyle(
                                    color: Colors.white,
                                    fontFamily: "Montserrat",
                                    fontWeight: FontWeight.w700,
                                    fontSize: constraints.maxWidth * .1);

                                return Container(
                                  width: cardWidth,
                                  height: cardHeight,
                                  decoration: BoxDecoration(
                                      boxShadow: [_cardBoxShadow],
//                              color: kBgPnP,
                                      gradient: LinearGradient(
                                        colors: [
                                          kBgPnP.withBlue(110),

                                          kBgPnP,

                                        ],

                                      ),
                                      borderRadius: cardBorderRadius),
                                  child: Stack(
                                    children: [
//                              Positioned(
//                                right: -120,
//                                bottom: -80,
//                                child: SvgPicture.asset(
//                                  "assets/blob-1.svg",
//                                  height: screenHeight * .31,
//                                  color: Colors.black.withOpacity(.3),
//                                ),
//                              ),
                                      Positioned(
                                        left: 30,
                                        bottom: 60,
                                        child: SvgPicture.asset(
                                          "assets/grocery_card_svg/grocery_bag_2.svg",
                                          height: constraints.maxWidth * .25,
//                                      color: Colors.white,
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 20,
                                        right: 20,
                                        child: FittedBox(
                                          child: Text("Pick n Pay",
                                              style: _cardHeaderStyle

                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },

                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SlideTransition(
                      position: _woolworthsSlide,
                      child: InkWell(
                        onTap: () async {
//                      if (!_wooliesIsInit) {
//                        Provider.of<WooliesAllProductList>(context,listen:false).getItems();
//                        setState(() {
//                          _wooliesIsInit = true;
//                        });
//                      }

                          final _item = _welcomeScreenItemMap['woolies'];
                          await _whenCardIsClicked();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WelcomeScreen(_item),
                            ),
                          );
                          _aController.animateTo(
                              1, duration: Duration(milliseconds: 4000));
                        },
                        child: Padding(
                          padding: cardPadding,
                          child: ClipRRect(
                            borderRadius: cardBorderRadius,
                            child: Container(
                              width: cardWidth,
                              height: cardHeight,
                              decoration: BoxDecoration(
                                  boxShadow: [_cardBoxShadow],
//                              color: kBgWoolies,
                                  gradient: LinearGradient(
                                    colors: [
                                      kBgWoolies.withOpacity(.87),
                                      kBgWoolies,
                                    ],

                                  ),
                                  borderRadius: cardBorderRadius),
                              child: Stack(
                                children: [
//                              Positioned(
//                                left: -80,
//                                top: -100,
//                                child: SvgPicture.asset(
//                                  "assets/blob-1.svg",
//                                  height: screenHeight * .31,
//                                  color: Colors.white.withOpacity(.2),
//                                ),
//                              ),
                                  Positioned(
                                    right: 30,
                                    bottom: 60,
                                    child: SvgPicture.asset(
                                      "assets/grocery_card_svg/plastic_bag.svg",
                                      height: screenHeight * .12,

                                    ),
                                  ),
                                  Positioned(
                                    bottom: 20,
                                    left: 20,
                                    child: FittedBox(
                                      child: Text("Woolworths",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: "Montserrat",
                                              fontWeight: FontWeight.w700,
                                              fontSize: screenWidth * .08)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
