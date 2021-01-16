import 'package:e_grocery/src/components/welcome_screen_components.dart';
import 'package:e_grocery/src/constants/constants.dart';
import 'package:e_grocery/src/pages/clothing_home_screens/foschini_home_screen.dart';
import 'package:e_grocery/src/pages/clothing_home_screens/markham_home_screen.dart';
import 'package:e_grocery/src/pages/clothing_home_screens/superbalist_home_screen.dart';
import 'package:e_grocery/src/pages/clothing_home_screens/woolworths_clothing_home_screen.dart';
import 'package:e_grocery/src/pages/welcome_screen.dart';
import 'package:e_grocery/src/pages/clothing_home_screens/sportscene_home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ClothingHome extends StatefulWidget {
  static const id = 'clothing-home';

  @override
  _ClothingHomeState createState() => _ClothingHomeState();
}

class _ClothingHomeState extends State<ClothingHome>
    with SingleTickerProviderStateMixin {
  AnimationController _aController;

  Animation<double> _textFadeAnimation;
  Animation<Offset> _textSlide;

  Animation<Offset> _foschiniSlide;
  Animation<Offset> _sportsceneSlide;
  Animation<Offset> _superbalistSlide;
  Animation<Offset> _woolworthsClothingSlide;
  Animation<Offset> _markhamSlide;

  bool _isFoschiniInit = false;
  bool _isSportsceneInit = false;

//  bool _pnpIsInit = false;
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
        .5,
        curve: Curves.easeOut,
      ),
    );

    _textSlide = Tween<Offset>(
      begin: Offset(0, -0.15),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _aController,
      curve: Interval(0, .4, curve: Curves.easeOut),
    ));

    _foschiniSlide = Tween<Offset>(
      begin: Offset(1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _aController,
      curve: Interval(.4, .6, curve: Curves.easeOut),
    ));

    _sportsceneSlide = Tween<Offset>(
      begin: Offset(1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _aController,
      curve: Interval(.5, .7, curve: Curves.easeOut),
    ));

    _markhamSlide = Tween<Offset>(
      begin: Offset(2, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _aController,
      curve: Interval(.6, .8, curve: Curves.easeOut),
    ));

    _superbalistSlide = Tween<Offset>(
      begin: Offset(2, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _aController,
      curve: Interval(.7, .9, curve: Curves.easeOut),
    ));

    _woolworthsClothingSlide = Tween<Offset>(
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
    await Future.delayed(Duration(milliseconds: 2500));
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenHeight10p =
        screenHeight * (10 / MediaQuery.of(context).size.height);
    final screenWidth10p =
        screenWidth * (10 / MediaQuery.of(context).size.width);

    final cardHeight = screenHeight * .25;
    final cardWidth = screenWidth * .9;
    final cardBorderRadius = BorderRadius.circular(10);
    final cardPadding = EdgeInsets.symmetric(
        horizontal: screenWidth10p * 2, vertical: screenHeight10p);
    final _cardBoxShadow = BoxShadow(
        color: Colors.black.withOpacity(.15),
        spreadRadius: 10,
        blurRadius: 15,
        offset: Offset(10, 0));

    Map<String, WelcomeScreenItem> welcomeScreenItems = {
      'foschini': WelcomeScreenItem(
        header: "Foschini",
        details: 'With over 270 stores in Southern Africa, Foschini '
            'offers fashion, beauty and kidswear, delivering a vibrant'
            ' and on trend experience for all women.',
        blob1: Positioned(
          top: -screenHeight * .4,
          left: -screenWidth * .85,
          child: SvgPicture.asset(
            "assets/blob-1.svg",
            width: screenHeight * 1.2,
            color: Colors.white.withOpacity(.7),
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
            color: Colors.grey.withOpacity(.3),
            width: screenHeight * 1.1,
          ),
        ),
        bgColor: kBgWoolies,
        btn: WelcomeScreenButton(
          text: "Explore",
          color: kWooliesSecondary,
          navigationFunction: () {
            Navigator.pushNamed(context, FoschiniHomeScreen.id);
          },
        ),
      ),
      'sportscene': WelcomeScreenItem(
        header: "Sportscene",
        details: 'Respected as the kings of sneakerwear,'
            ' sportscene is an authorised retailer'
            ' of footwear and clothing from iconic '
            'street-inspired brands including Redbat,'
            ' Nike, Air Jordan, adidas Originals, PUMA, '
            'Converse and Vans to name a few',
        blob1: Positioned(
          top: -300,
          left: -70,
          child: Transform.rotate(
            angle: 100,
            child: SvgPicture.asset(
              "assets/blob-3.svg",
              width: screenHeight * 1.2,
              color: Colors.grey,
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
        bgColor: kBgWoolies,
        btn: WelcomeScreenButton(
          text: "Explore",
          color: kWooliesSecondary,
          navigationFunction: () {
            Navigator.pushNamed(context, SportsceneHomeScreen.id);
          },
        ),
      ),
      'markham': WelcomeScreenItem(
        header: "Markham",
        details: 'With over 320 stores across South Africa, '
            'Namibia, Botswana, Lesotho, Swaziland, '
            'Ghana and Zambia, the Markham lifestyle offers'
            ' a range of smartwear, casualwear, footwear,'
            ' accessories, cellphones and fragrance.',
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
            Navigator.pushNamed(context, MarkhamHomeScreen.id);
          },
        ),
      ),
      'superbalist': WelcomeScreenItem(
        header: "Superbalist",
        details: 'South Africa’s most-loved, online wardrobe + '
            'lifestyle destination.'
            ' We cater to all sizes, ages + price points, ensuring you'
            ' always find what you’re looking for.',
        blob1: Positioned(
          top: -screenHeight * .4,
          left: -screenWidth * .85,
          child: SvgPicture.asset(
            "assets/blob-1.svg",
            width: screenHeight * 1.2,
            color: Colors.white.withOpacity(.7),
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
            color: Colors.grey.withOpacity(.3),
            width: screenHeight * 1.1,
          ),
        ),
        bgColor: kBgWoolies,
        btn: WelcomeScreenButton(
          text: "Explore",
          color: kWooliesSecondary,
          navigationFunction: () {
//                            return null;
            Navigator.pushNamed(context, SuperbalistHomeScreen.id);
          },
        ),
      ),
      'woolworths_clothing': WelcomeScreenItem(
        header: "Woolworths",
        details: "Building on our reputation for superior quality, "
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
            Navigator.pushNamed(context, WoolworthsClothingHomeScreen.id);
          },
        ),
      ),
    };

    Map<String, DecorationImage> decorationImages = {
      'foschini': DecorationImage(
          image: AssetImage('assets/images/clothing/freestocks.jpg'),
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(.2), BlendMode.multiply),
          fit: BoxFit.cover,
          alignment: Alignment.lerp(Alignment.center, Alignment.topCenter, .5)),
      'sportscene': DecorationImage(
        image: AssetImage('assets/images/clothing/joseph.jpg'),
        colorFilter:
            ColorFilter.mode(Colors.black.withOpacity(.2), BlendMode.multiply),
        fit: BoxFit.cover,
      ),
      'markham': DecorationImage(
        image: AssetImage('assets/images/clothing/ruthson.jpg'),
        colorFilter:
            ColorFilter.mode(Colors.black.withOpacity(.3), BlendMode.multiply),
        fit: BoxFit.cover,
      ),
      'superbalist': DecorationImage(
          image: AssetImage('assets/images/clothing/alex.jpg'),
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(.3), BlendMode.multiply),
          fit: BoxFit.cover,
          alignment: Alignment.lerp(Alignment.center, Alignment.topCenter, .5)),
      'woolworths_clothing': DecorationImage(
          image: AssetImage('assets/images/clothing/judeus.jpg'),
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(.3), BlendMode.multiply),
          fit: BoxFit.cover,
          alignment: Alignment.lerp(Alignment.center, Alignment.topCenter, .5)),
    };

    return Scaffold(
      body: Container(
        color: kTextFieldBgGrey,
        child: ListView(
          children: [
            Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: screenHeight * .35,
                  decoration: BoxDecoration(),
                  child: SvgPicture.asset(
                    "assets/main_menu/clothing_bg.svg",
                    width: screenWidth * 4,
                    fit: BoxFit.cover,

                  ),
                ),
                Positioned.fill(
                  child: Container(
//                      color: Colors.black.withOpacity(.5),
                      decoration: BoxDecoration(
                        gradient: RadialGradient(
                          radius: .8,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(.3),
                          ],
                        ),)
                  ),
                ),
                Positioned(
                  bottom: screenHeight10p * 3.5,
                  child: FadeTransition(
                    opacity: _textFadeAnimation,
                    child: SlideTransition(
                      position: _textSlide,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth10p * 2,
                            vertical: screenHeight10p * 3),
                        child: Text(
                          "Clothing",
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


            Transform.translate(
              offset: Offset(0, -screenHeight * .05),
              child: Container(
                decoration: BoxDecoration(
                    color: kTextFieldBgGrey,
                    borderRadius: BorderRadius.circular(screenWidth10p * 4)
                ),

                child: Column(
                  children: [
                    SizedBox(
                      height: screenHeight10p * 3,
                    ),
                    SlideTransition(
                      position: _foschiniSlide,
                      child: InkWell(
                        onTap: () async {
//                      if (!_isFoschiniInit) {
//                        Provider.of<FoschiniAllProductList>(context,listen:false).getItems();
//                        setState(() {
//                          _isFoschiniInit = true;
//                        });
//                      }

                          final _item = welcomeScreenItems["foschini"];
                          await _whenCardIsClicked();

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WelcomeScreen(_item),
                            ),
                          );
                          _aController.animateTo(
                              1, duration: Duration(milliseconds: 4000),
                              curve: Curves.easeIn);
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
                                  image: decorationImages["foschini"],
                                  borderRadius: cardBorderRadius),
                              child: Stack(
                                children: [
//                              Positioned(
//                                left: -80,
//                                bottom: -50,
//                                child: SvgPicture.asset(
//                                  "assets/blob-1.svg",
//                                  height: screenHeight * .31,
//                                  color: Colors.white.withOpacity(.1),
//                                ),
//                              ),
//                              Positioned(
//                                right: 30,
//                                bottom: 40,
//                                child: SvgPicture.asset(
//                                  "assets/shoprite/shoprite_cart.svg",
//                                  height: screenWidth * .25,
//                                  color: Colors.white,
//                                ),
//                              ),
                                  Positioned(
                                    bottom: 20,
                                    left: 20,
                                    child: FittedBox(
                                      child: Text(
                                        "Foschini",
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
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SlideTransition(
                      position: _sportsceneSlide,
                      child: InkWell(
                        onTap: () async {
//                      if (!_isSportsceneInit) {
//                        Provider.of<SportsceneAllProductList>(context,listen:false).getItems();
//                        setState(() {
//                          _isSportsceneInit = true;
//                        });
//                      }

                          final _item = welcomeScreenItems['sportscene'];
                          await _whenCardIsClicked();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WelcomeScreen(_item),
                            ),
                          );
                          _aController.animateTo(
                              1, duration: Duration(milliseconds: 4000),
                              curve: Curves.easeIn);
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
                                  color: kBgWoolies,
                                  image: decorationImages['sportscene'],
                                  borderRadius: cardBorderRadius),
                              child: Stack(
                                children: [
//                              Positioned(
//                                right: -120,
//                                bottom: -80,
//                                child: SvgPicture.asset(
//                                  "assets/blob-1.svg",
//                                  height: screenHeight * .31,
//                                  color: Colors.white.withOpacity(.2),
//                                ),
//                              ),
//                              Positioned(
//                                left: 30,
//                                bottom: 60,
//                                child: SvgPicture.asset(
//                                  "assets/pnp/pnp_cart.svg",
//                                  height: screenHeight * .12,
//                                  color: Colors.white,
//                                ),
//                              ),
                                  Positioned(
                                    bottom: 20,
                                    right: 20,
                                    child: FittedBox(
                                      child: Text("Sportscene",
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
                    SlideTransition(
                      position: _markhamSlide,
                      child: InkWell(
                        onTap: () async {
//                      if (!_wooliesIsInit) {
//                        Provider.of<MarkhamAllProductList>(context,listen:false).getItems();
//                        setState(() {
//                          _wooliesIsInit = true;
//                        });
//                      }

                          final _item = welcomeScreenItems['markham'];
                          await _whenCardIsClicked();

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WelcomeScreen(_item),
                            ),
                          );

                          _aController.animateTo(
                              1, duration: Duration(milliseconds: 4000),
                              curve: Curves.easeIn);
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
                                  color: kBgWoolies,
                                  image: decorationImages['markham'],
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
//                              Positioned(
//                                right: 30,
//                                bottom: 60,
//                                child: SvgPicture.asset(
//                                  "assets/woolworths/woolies_cart.svg",
//                                  height: screenHeight * .12,
//                                  color: Colors.white,
//                                ),
//                              ),
                                  Positioned(
                                    bottom: 20,
                                    left: 20,
                                    child: FittedBox(
                                      child: Text("Markham",
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
                    SlideTransition(
                      position: _superbalistSlide,
                      child: InkWell(
                        onTap: () async {
//                      if (!_isInit) {
//                        Provider.of<SuperbalistAllProductList>(context,listen:false).getItems();
//                        setState(() {
//                          _isInit = true;
//                        });
//                      }

                          final _item = welcomeScreenItems['superbalist'];
                          await _whenCardIsClicked();

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WelcomeScreen(_item),
                            ),
                          );
                          _aController.animateTo(
                              1, duration: Duration(milliseconds: 4000),
                              curve: Curves.easeIn);
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
                                  color: kBgWoolies,
                                  image: decorationImages['superbalist'],
                                  borderRadius: cardBorderRadius),
                              child: Stack(
                                children: [
//                              Positioned(
//                                right: -20,
//                                bottom: -50,
//                                child: SvgPicture.asset(
//                                  "assets/blob-1.svg",
//                                  height: screenHeight * .31,
//                                  color: Colors.white.withOpacity(.1),
//                                ),
//                              ),
//                              Positioned(
//                                right: 30,
//                                bottom: 40,
//                                child: SvgPicture.asset(
//                                  "assets/shoprite/shoprite_cart.svg",
//                                  height: screenWidth * .25,
//                                  color: Colors.white,
//                                ),
//                              ),
                                  Positioned(
                                    bottom: 20,
                                    right: 20,
                                    child: FittedBox(
                                      child: Text(
                                        "Superbalist",
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
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SlideTransition(
                      position: _woolworthsClothingSlide,
                      child: InkWell(
                        onTap: () async {
                          if (!_wooliesIsInit) {
//                        Provider.of<WoolworthsClothingAllProductList>(context,listen:false).getItems();
//                        setState(() {
//                          _wooliesIsInit = true;
//                        });
                          }

                          final _item = welcomeScreenItems['woolworths_clothing'];
                          await _whenCardIsClicked();
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WelcomeScreen(_item),
                            ),
                          );
                          _aController.animateTo(
                              1, duration: Duration(milliseconds: 4000),
                              curve: Curves.easeIn);
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
                                  color: kBgWoolies,
                                  image: decorationImages['woolworths_clothing'],
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
//                              Positioned(
//                                right: 30,
//                                bottom: 60,
//                                child: SvgPicture.asset(
//                                  "assets/woolworths/woolies_cart.svg",
//                                  height: screenHeight * .12,
//                                  color: Colors.white,
//                                ),
//                              ),
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
                      height: screenHeight10p * 2,
                    ),
                  ],
                ),
              ),
            ),


//                SlideTransition(
//                  position: _pnpSlide,
//                  child: InkWell(
//                    onTap: ()async {
//
//                      if (!_pnpIsInit) {
////                        Provider.of<PnPAllProductList>(context,listen:false).getItems();
////                        setState(() {
////                          _pnpIsInit = true;
////                        });
//                      }
//
//
//                      final _item = WelcomeScreenItem(
//                        header: "Sportscene",
//                        details:
//                        'Respected as the kings of sneakerwear,'
//                            ' sportscene is an authorised retailer'
//                            ' of footwear and clothing from iconic '
//                            'street-inspired brands including Redbat,'
//                            ' Nike, Air Jordan, adidas Originals, PUMA, '
//                            'Converse and Vans to name a few',
//                        blob1: Positioned(
//                          top: -300,
//                          left: -70,
//                          child: Transform.rotate(
//                            angle: 100,
//                            child: SvgPicture.asset(
//                              "assets/blob-3.svg",
//                              width: screenHeight * 1.2,
//                            ),
//                          ),
//                        ),
//                        blob2: Positioned(
//                          top: 390,
//                          right: 10,
//                          child: Transform.rotate(
//                            angle: 180,
//                            child: SvgPicture.asset(
//                              "assets/blob-2.svg",
//                              color: Colors.white,
//                              width: screenHeight * .93,
//                            ),
//                          ),
//                        ),
//                        blob3: Positioned(
//                          top: 110,
//                          left: 170,
//                          child: Transform.rotate(
//                            angle: 37,
//                            child: SvgPicture.asset(
//                              "assets/blob-3.svg",
//                              color: Colors.black.withOpacity(1),
//                              width: screenHeight * 1.1,
//                            ),
//                          ),
//                        ),
//                        bgColor: kBgPnP,
//                        btn: WelcomeScreenButton(
//                          text: "Explore",
//                          color: kPnPSecondary,
//                          navigationFunction: () async{
//
////                            Navigator.pushNamed( context, PnPHomeScreen.id);
//
//                          },
//                        ),
//                      );
//                      await   _whenCardIsClicked();
//
//
//                      Navigator.push(
//                        context,
//                        MaterialPageRoute(
//                          builder: (context) => WelcomeScreen(_item),
//                        ),
//                      );
//                    },
//                    child: Padding(
//                      padding: cardPadding,
//                      child: ClipRRect(
//                        borderRadius: cardBorderRadius,
//                        child: Container(
//                          width: cardWidth,
//                          height: cardHeight,
//                          decoration: BoxDecoration(
//                              boxShadow: [_cardBoxShadow],
//                              color: kBgWoolies,
//                              borderRadius: cardBorderRadius),
//                          child: Stack(
//                            children: [
//                              Positioned(
//                                right: -120,
//                                bottom: -80,
//                                child: SvgPicture.asset(
//                                  "assets/blob-1.svg",
//                                  height: screenHeight * .31,
//                                  color: Colors.white.withOpacity(.2),
//                                ),
//                              ),
////                              Positioned(
////                                left: 30,
////                                bottom: 60,
////                                child: SvgPicture.asset(
////                                  "assets/pnp/pnp_cart.svg",
////                                  height: screenHeight * .12,
////                                  color: Colors.white,
////                                ),
////                              ),
//                              Positioned(
//                                bottom: 20,
//                                right: 20,
//                                child: FittedBox(
//                                  child: Text("Sportscene",
//                                      style: TextStyle(
//                                          color: Colors.white,
//                                          fontFamily: "Montserrat",
//                                          fontWeight: FontWeight.w700,
//                                          fontSize: screenWidth * .08)),
//                                ),
//                              ),
//                            ],
//                          ),
//                        ),
//                      ),
//                    ),
//                  ),
//                ),
//                SizedBox(
//                  height: 20,
//                ),
          ],
        ),
      ),
    );
  }
}
