import 'package:e_grocery/src/pages/accessories_home_screens/computermania_home_screen.dart';
import 'package:e_grocery/src/pages/accessories_home_screens/hifi_home_screen.dart';
import 'package:e_grocery/src/pages/accessories_home_screens/takealot_home_screen.dart';
import 'package:e_grocery/src/pages/welcome_screen.dart';
import 'package:e_grocery/src/components/welcome_screen_components.dart';
import 'package:e_grocery/src/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AccessoriesHome extends StatefulWidget {
  static const id = "/accessoriesHome";

  @override
  _AccessoriesHomeState createState() => _AccessoriesHomeState();
}

class _AccessoriesHomeState extends State<AccessoriesHome>
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
      'takealot': WelcomeScreenItem(
        header: "Takealot",
        details:
            "Takealot, a place where extraordinary people come together to do extraordinary "
            "things, bringing world-class online shopping to the"
            " people of South Africa.",
        blob1: Positioned(
          top: -screenHeight * .4,
          left: -screenWidth * .85,
          child: SvgPicture.asset(
            "assets/blob-1.svg",
            width: screenHeight * 1.2,
            color: Colors.blue,
          ),
        ),
        blob2: Positioned(
          top: screenHeight * .08,
          left: screenWidth * .55,
          child: SvgPicture.asset(
            "assets/blob-2.svg",
            color: Colors.white.withOpacity(.5),
            width: screenHeight * .93,
          ),
        ),
        blob3: Positioned(
          bottom: -screenHeight * .28,
          left: -screenWidth * .88,
          child: SvgPicture.asset(
            "assets/blob-3.svg",
            color: Colors.black.withOpacity(.2),
            width: screenHeight * 1.1,
          ),
        ),
        bgColor: kBgTakealot.withBlue(200),
        btn: WelcomeScreenButton(
            text: "Explore",
            color: kBgTakealot,
            navigationFunction: () =>
                Navigator.pushNamed(context, TakealotHomeScreen.id)),
      ),
      'hifi': WelcomeScreenItem(
        header: "Hifi",
        details: 'After more than two decades of the leading '
            'budget beater in electronic audio visual'
            ' products and appliances, the brand continues'
            ' to fight for consumer justice in bringing the '
            'lowest possible prices to consumers.',
        blob1: Positioned(
          top: -300,
          left: -70,
          child: Transform.rotate(
            angle: 100,
            child: SvgPicture.asset(
              "assets/blob-3.svg",
              width: screenHeight * 1.2,
              color: Colors.redAccent,
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
              color: Colors.white.withOpacity(.3),
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
              color: Colors.black.withOpacity(.7),
              width: screenHeight * 1.1,
            ),
          ),
        ),
        bgColor: kBgHifi,
        btn: WelcomeScreenButton(
          text: "Explore",
          color: kBgHifi,
          navigationFunction: () =>
              Navigator.pushNamed(context, HifiHomeScreen.id),
        ),
      ),
      'computermania': WelcomeScreenItem(
        header: "Computer Mania",
        details:
            'With a success record spanning more than 28 years, Computer Mania'
            'is equipped to lead dedicated'
            ' franchisees and become a successful retailer.',
        blob1: Positioned(
          top: screenHeight10p * -30,
          left: screenWidth10p * -46,
          child: SvgPicture.asset(
            "assets/blob-1.svg",
            width: screenWidth10p * 90,
            color: Colors.black.withOpacity(.5),
          ),
        ),
        blob2: Positioned(
          top: screenHeight10p,
          left: screenWidth10p * 20,
          child: SvgPicture.asset(
            "assets/blob-2.svg",
            color: Colors.white.withOpacity(.6),
            width: 70 * screenWidth10p,
          ),
        ),
        blob3: Positioned(
          bottom: screenHeight10p * -18,
          left: -37 * screenWidth10p,
          child: SvgPicture.asset(
            "assets/blob-3.svg",
            color: Colors.black.withOpacity(.6),
            width: 80 * screenWidth10p,
          ),
        ),
        bgColor: kBgComputermania,
        btn: WelcomeScreenButton(
          text: "Explore",
          color: kComputermaniaSecondary.withOpacity(.7),
          navigationFunction: () {
            Navigator.pushNamed(context, ComputermaniaHomeScreen.id);
//            Navigator.pushNamed(context, TakealotHomeScreen.id);
          },
        ),
      )
    };

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
                    bottom: screenHeight10p * 2.3,
                    child: FadeTransition(
                      opacity: _textFadeAnimation,
                      child: SlideTransition(
                        position: _textSlide,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth10p * 2,
                              vertical: screenHeight10p * 3),
                          child: Text(
                            "Accessories",
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
                    borderRadius: BorderRadius.circular(screenWidth * .07)),
                child: Column(
                  children: [
                    SizedBox(
                      height: screenHeight10p * 4,
                    ),
                    SlideTransition(
                      position: _shopriteSlide,
                      child: InkWell(
                        onTap: () async {
//                          if (Provider.of<TakealotAllProductList>(context,
//                                      listen: false)
//                                  .data ==
//                              null) {
//                            await Provider.of<TakealotAllProductList>(context,
//                                    listen: false)
//                                .getItems();
//                          }

//                      if (!_isInit) {
//                      Provider.of<ShopriteAllProductList>(context,listen:false).getItems();
//                        setState(() {
//                          _isInit = true;
//                        });
//                      }
                          final _item = _welcomeScreenItemMap['takealot'];
                          await _whenCardIsClicked();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WelcomeScreen(_item),
                            ),
                          );
                          _aController.animateTo(1,
                              duration: Duration(milliseconds: 4000));
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
                                    kBgTakealot.withBlue(200),
                                    kBgTakealot,
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

//                                Positioned(
//                                  right: 30,
//                                  bottom: 40,
//                                  child: SvgPicture.asset(
//                                    "assets/grocery_card_svg/trolley.svg",
//                                    height: screenWidth * .23,
//
//                                  ),
//                                ),
                                Positioned(
                                  bottom: 20,
                                  left: 20,
                                  child: FittedBox(
                                    child: Text(
                                      "Takealot",
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
//                          if (Provider.of<HifiAllProductList>(context,
//                                      listen: false)
//                                  .data ==
//                              null) {
//                            await Provider.of<HifiAllProductList>(context,
//                                    listen: false)
//                                .getItems();
//                          }

//                      if (!_pnpIsInit) {
//                        Provider.of<PnPAllProductList>(context,listen:false).getItems();
//                        setState(() {
//                          _pnpIsInit = true;
//                        });
//                      }

                          final _item = _welcomeScreenItemMap['hifi'];
                          await _whenCardIsClicked();

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WelcomeScreen(_item),
                            ),
                          );

                          _aController.animateTo(1,
                              duration: Duration(milliseconds: 4000));
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
                                          kBgShoprite,
                                          kBgShoprite.withRed(160),
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
//                                      Positioned(
//                                        left: 30,
//                                        bottom: 60,
//                                        child: SvgPicture.asset(
//                                          "assets/grocery_card_svg/grocery_bag_2.svg",
//                                          height: constraints.maxWidth * .25,
////                                      color: Colors.white,
//                                        ),
//                                      ),
                                      Positioned(
                                        bottom: 20,
                                        right: 20,
                                        child: FittedBox(
                                          child: Text("Hifi",
                                              style: _cardHeaderStyle),
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
//                          if (Provider.of<ComputermaniaAllProductList>(context,
//                                      listen: false)
//                                  .data ==
//                              null) {
//                            await Provider.of<ComputermaniaAllProductList>(
//                                    context,
//                                    listen: false)
//                                .getItems();
//                          }
//                      if (!_wooliesIsInit) {
//                        Provider.of<WooliesAllProductList>(context,listen:false).getItems();
//                        setState(() {
//                          _wooliesIsInit = true;
//                        });
//                      }

//                          await Provider.of<ComputermaniaAllProductList>(
//                                  context,
//                                  listen: false)
//                              .getItems();

                          final _item = _welcomeScreenItemMap['computermania'];
                          await _whenCardIsClicked();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WelcomeScreen(_item),
                            ),
                          );
                          _aController.animateTo(1,
                              duration: Duration(milliseconds: 4000));
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
                                  gradient: LinearGradient(
                                    colors: [
                                      kBgComputermania.withBlue(80),
                                      kBgComputermania,
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
//                                  Positioned(
//                                    right: 30,
//                                    bottom: 60,
//                                    child: SvgPicture.asset(
//                                      "assets/grocery_card_svg/plastic_bag.svg",
//                                      height: screenHeight * .12,
//
//                                    ),
//                                  ),
                                  Positioned(
                                    bottom: 20,
                                    left: 20,
                                    child: FittedBox(
                                      child: Text("Computermania",
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
