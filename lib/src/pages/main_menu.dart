import 'dart:io';

import 'package:e_grocery/src/components/grocery_stores_provider_aggregate_methods.dart';
import 'package:e_grocery/src/constants/constants.dart';
import 'package:e_grocery/src/networking/connection_test.dart';
import 'package:e_grocery/src/pages/clothing_home.dart';
import 'package:e_grocery/src/pages/groceries_home.dart';
import 'package:e_grocery/src/pages/shopping_list.dart';
import 'package:e_grocery/src/providers/clothing/foschini/foschini_product_provider.dart';
import 'package:e_grocery/src/providers/clothing/markham/markham_product_provider.dart';
import 'package:e_grocery/src/providers/clothing/sportscene/sportscene_product_provider.dart';
import 'package:e_grocery/src/providers/clothing/superbalist/superbalist_product_provider.dart';
import 'package:e_grocery/src/providers/clothing/woolworths_clothing/woolworths_clothing_product_provider.dart';
import 'package:e_grocery/src/services/push_notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class MainMenu extends StatefulWidget {
  static const id = 'main-menu';

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollController = ScrollController();

  final FirebaseMessaging _fcm = FirebaseMessaging();

  final _borderRadius = BorderRadius.circular(15);
  final _borderRadiusSmaller = BorderRadius.circular(10);

  AnimationController _aController;

  Animation<Offset> _textHeader1Slide;
  Animation<double> _textHeader1Fade;

  Animation<Offset> _textHeader2Slide;
  Animation<double> _textHeader2Fade;

  Animation<Offset> _groceriesSlide;
  Animation<double> _groceriesFade;

  Animation<Offset> _clothingSlide;
  Animation<double> _clothingFade;

  Animation<double> _accessoriesPop;
  Animation<double> _shoppingListPop;
  Animation<double> _aboutPop;


  @override
  void initState() {
    super.initState();
//    PushNotificationService _pushNotification = PushNotificationService();
//    _pushNotification.init(context);

    _aController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );

    /////////hi /////////////

    _textHeader1Slide = Tween<Offset>(
      begin: Offset(0, .4),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _aController,
      curve: Interval(.1, .3, curve: Curves.easeOut),
    ));

    _textHeader1Fade = CurvedAnimation(
      parent: _aController,
      curve: Interval(
        .1,
        .5,
        curve: Curves.easeOut,
      ),
    );

/////// welcome //////////
    _textHeader2Slide = Tween<Offset>(
      begin: Offset(0, .4),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _aController,
      curve: Interval(.3, .5, curve: Curves.easeOut),
    ));

    _textHeader2Fade = CurvedAnimation(
      parent: _aController,
      curve: Interval(
        0.3,
        .7,
        curve: Curves.easeOut,
      ),
    );

////////// groceries card  ////////////

    _groceriesSlide = Tween<Offset>(
      begin: Offset(1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _aController,
      curve: Interval(.6, .8, curve: Curves.easeOut),
    ));

    _groceriesFade = CurvedAnimation(
      parent: _aController,
      curve: Interval(
        .6,
        .9,
        curve: Curves.easeOut,
      ),
    );

////////// clothing card  ///////////

    _clothingSlide = Tween<Offset>(
      begin: Offset(-1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _aController,
      curve: Interval(.6, .8, curve: Curves.easeOut),
    ));

    _clothingFade = CurvedAnimation(
      parent: _aController,
      curve: Interval(
        .6,
        .9,
        curve: Curves.easeOut,
      ),
    );

////////// PoPs  ///////////

    //  accessories
    _accessoriesPop = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _aController,
      curve: Interval(
        0.7,
        .8,
        curve: Curves.easeIn,
      ),
    ));

    //  shoppingList
    _shoppingListPop = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _aController,
      curve: Interval(
        0.8,
        .9,
        curve: Curves.easeIn,
      ),
    ));

    //  about
    _aboutPop = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _aController,
      curve: Interval(
        0.9,
        1,
        curve: Curves.easeIn,
      ),
    ));

    _aController.forward();
    _aController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _aController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    final screenHeight10p = screenHeight * (10 / MediaQuery
        .of(context)
        .size
        .height);
    final screenWidth10p = screenWidth * (10 / MediaQuery
        .of(context)
        .size
        .width);

    final topBottomMargin = screenHeight10p * 2;
    final _extraSpace = SizedBox(height: screenHeight10p * 4,);

    final TextStyle textStyle = Theme
        .of(context)
        .textTheme
        .bodyText2;

    final _mainTextStyle = TextStyle(
        color: kTextColor,
        fontSize: screenWidth10p * 3.3,
        fontFamily: "Montserrat",
        decoration: TextDecoration.none,
        fontWeight: FontWeight.w600);

    final List<Widget> aboutBoxChildren = <Widget>[
      SizedBox(height: 24),
      RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
                style: textStyle,
                text:
                'Welcome to Savvy Shopper, a smart app that\'s going to help you save.'
                    ' \nThis application helps you find the best deals '
                    'on products from stores all around South Africa \n\n'),
            TextSpan(
                style: textStyle,
                text: 'Designed and Created by: Takuonline\n'
                    'Email: takuonline365@gmail.com\n'),
            TextSpan(
                style: textStyle,
                text: 'Artwork by: Brgfx and Macrovector on freepik.\n'
                    'Images by unsplash.com: Judeus Samson, Alex Iby,'
                    ' Joseph Barrientos, Irene Kredenets and ruthson-zimmerman'


            ),
          ],
        ),
      ),
    ];

    return Container(
      color: kTextFieldBgGrey,
//      padding: EdgeInsets.only(bottom: 40),
      child: ListView(
        shrinkWrap: true,
        controller: _scrollController,
        children: [
          SizedBox(
            height: screenHeight10p * 1,
          ),
          Container(
            width: double.infinity,
            height: screenHeight * .215,
            padding: EdgeInsets.symmetric(
                vertical: screenHeight10p * 2, horizontal: screenWidth10p * 1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                FadeTransition(
                  opacity: _textHeader1Fade,
                  child: SlideTransition(
                      position: _textHeader1Slide
                      ,
                      child: Text("Hello,", style: _mainTextStyle)
                  ),
                ),
                FadeTransition(
                  opacity: _textHeader2Fade,
                  child: SlideTransition(
                      position: _textHeader2Slide
                      ,
                      child: Text("Welcome", style: _mainTextStyle)
                  ),
                ),

//                Transform.translate(
//                  offset: Offset(0, -2),
//                  child: Padding(
//                    padding: EdgeInsets.only(
//                      right: screenWidth * .77,
//                    ),
//                    child: Divider(
//                      color: Colors.black,
//                      thickness: 3,
////                    indent: screenWidth*.7,
//                    ),
//                  ),
//                )
              ],
            ),
          ),
//          _extraSpace,
//          SizedBox(
//            height: screenHeight10p * 1,
//          ),
          GestureDetector(
              onTap: () async {
                if (await TestConnection.checkForConnection()) {
                  GroceryStoresProviderMethods.checkNullAndGetAllProductData(
                      context);
//              if(Provider.of<ShopriteAllProductList>(context, listen: false).data==null){
//                Provider.of<ShopriteAllProductList>(context, listen: false)
//                    .getItems();
//              }
//
//              if(Provider.of<PnPAllProductList>(context, listen: false).data==null){
//                Provider.of<PnPAllProductList>(context, listen: false).getItems();
//              }
//
//              if(Provider.of<WooliesAllProductList>(context, listen: false).data==null){
//                Provider.of<WooliesAllProductList>(context, listen: false).getItems();
//              }
                  Navigator.of(context).pushNamed(GroceriesHomePage.id);
                }

                else {
                  TestConnection.showNoNetworkDialog(context);
                }
              },
              child:
              FadeTransition(
                opacity: _groceriesFade,
                child: SlideTransition(
                  position: _groceriesSlide,
                  child:
                  Container(
                    margin: EdgeInsets.only(
                        left: screenWidth10p, right: screenWidth10p),
                    decoration:
                    BoxDecoration(color: kHomeBg, borderRadius: _borderRadius),
                    height: screenHeight * .35,
                    width: screenWidth * 1,
                    child: ClipRRect(
                      borderRadius: _borderRadius,
                      child: Stack(
                        children: [
                          Positioned.fill(
//                      right: screenWidth10p * 0,
//                      bottom: screenHeight10p * .2,
                            child: SvgPicture.asset(
                              "assets/main_menu/grocery_shoppinglist_bg.svg",
                              width: screenWidth * 1.3,
                              fit: BoxFit.cover,

//                        fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            height: double.infinity,
                            width: double.infinity,
                            color: Colors.black.withOpacity(.2),
                          ),
                          Positioned(
                            bottom: screenHeight10p * 3,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth10p * 3,
                                  vertical: screenHeight10p),
                              child: Text(
                                "Groceries",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: screenWidth10p * 4,
                                  fontWeight: FontWeight.w700,
                                  decoration: TextDecoration.none,
                                  fontFamily: "Montserrat",
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),),
              )
          ),
          SizedBox(
            height: screenHeight10p * 3,
          ),
          FadeTransition(
            opacity: _clothingFade,
            child: SlideTransition(
              position: _clothingSlide,
              child:
              Container(
                margin: EdgeInsets.only(
                    top: topBottomMargin,
                    left: screenWidth10p,
                    right: screenWidth10p),
//            color: kHomeBg,
                height: screenHeight * .25,
                width: screenWidth,
//            decoration: BoxDecoration(
//                borderRadius: _borderRadius,
//                image: DecorationImage(
//                    image: AssetImage('assets/images/atikh.jpg'),
//                    fit: BoxFit.cover,
//                    scale: 2,
//                    colorFilter: ColorFilter.mode(
//                        Colors.black.withOpacity(.2), BlendMode.multiply),
//                    alignment: Alignment.lerp(
//                        Alignment.topLeft, Alignment.bottomLeft, .1),)

//              ),
                child: ClipRRect(
                  borderRadius: _borderRadius,
                  child: GestureDetector(
                    onTap: () async {
                      if (await TestConnection.checkForConnection()) {
//                        final FirebaseMessaging _fcm = FirebaseMessaging();
//                        _fcm.getToken().then((token){
//                          print("token herrrr");
//                          print(token);
//                          print("token herrrr");
//                        });

                        if (Provider.of<FoschiniAllProductList>(context,
                                    listen: false)
                                .data ==
                            null) {
                          Provider.of<FoschiniAllProductList>(context,
                                  listen: false)
                              .getItems();
                        }

                        if (Provider.of<MarkhamAllProductList>(context, listen: false)
                            .data == null) {
                          Provider.of<MarkhamAllProductList>(
                              context, listen: false)
                              .getItems();
                        }

                        if (Provider
                            .of<SportsceneAllProductList>(context, listen: false)
                            .data == null) {
                          Provider.of<SportsceneAllProductList>(
                              context, listen: false)
                              .getItems();
                        }


                        if (Provider
                            .of<SuperbalistAllProductList>(context, listen: false)
                            .data == null) {
                          Provider.of<SuperbalistAllProductList>(
                              context, listen: false)
                              .getItems();
                        }


                        if (Provider
                            .of<WoolworthsClothingAllProductList>(context,
                            listen: false)
                            .data == null) {
                          Provider.of<WoolworthsClothingAllProductList>(context,
                              listen: false)
                              .getItems();
                        }

                        Navigator.pushNamed(context, ClothingHome.id);
                      }
                      else {
                        TestConnection.showNoNetworkDialog(context);
                      }


                      print("clothing");
                    },
                    child: Stack(
                      children: [
                        Positioned.fill(

                          child: SvgPicture.asset(
                            "assets/main_menu/clothing_bg.svg",
                            width: screenWidth * 4,

                            fit: BoxFit.cover,

                          ),
                        ),
                        Container(
                          height: double.infinity,
                          width: double.infinity,
                          color: Colors.black.withOpacity(.2),
                        ),
                        Positioned(
                          bottom: screenHeight10p * 3,
                          right: screenWidth10p * 2,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: screenWidth10p * 3,
                            ),
                            child: Text(
                              "Clothing",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: screenWidth10p * 3.5,
                                fontWeight: FontWeight.w700,
                                decoration: TextDecoration.none,
                                fontFamily: "Montserrat",
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),),),

          _extraSpace,
          SizedBox(
            height: topBottomMargin - 10,
          ),


          Container(
            width: screenWidth,
            margin: EdgeInsets.only(right: screenWidth10p * 1),
            height: screenHeight * .33,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 0, left: 10, bottom: 0),
//                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 25),
                    child: Column(
                      children: [
                        Flexible(
                          flex: 5,
                          child: GestureDetector(
                            onTap: () async {
//                                 if(await TestConnection.checkForConnection() )  {
//
//
//                                   Provider.of<WooliesAllProductList>(context, listen: false)
//                                       .getItems();
//                                   Provider.of<PnPAllProductList>(context, listen: false).getItems();
//                                   Provider.of<ShopriteAllProductList>(context, listen: false)
//                                       .getItems();
                              Navigator.pushNamed(context, ShoppingList.id);
//                                 }else{
//                                   TestConnection.showNoNetworkDialog(context);
//                                 }
                            },
                            child:
                            Transform.scale(
                              scale: _shoppingListPop.value,
                              child:
                              LayoutBuilder(
                                builder: (_, constraints) {
                                  final headerStyle = TextStyle(
                                      color: Colors.white,
                                      fontSize: constraints.maxWidth * .08,
                                      decoration: TextDecoration.none);


                                  return Container(
                                      width: double.infinity,
                                      margin:
                                      EdgeInsets.only(bottom: topBottomMargin),
                                      decoration: BoxDecoration(
//                                    color: Colors.blue,
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.blue,
                                              Colors.lightBlue
                                            ],
                                          ),
                                          borderRadius: _borderRadiusSmaller),
                                      child: Column(
                                        children: [
                                          Expanded(
                                            flex: 4,
                                            child: Container(
                                              margin: EdgeInsets.symmetric(
                                                  vertical: screenHeight10p *
                                                      2),
//                                    padding: EdgeInsets.all(screenWidth10p*.7),
                                              decoration: BoxDecoration(

//                                        color: Colors.white.withOpacity(.1),
//                                        borderRadius: _borderRadiusSmaller
                                              ),

                                              child: Icon(
                                                Icons.shopping_cart,
                                                color: Colors.white,
                                                size: constraints.maxWidth *
                                                    .19,
                                              ),
                                            ),
                                          ),

                                          Flexible(
                                            flex: 1,
                                            child: SizedBox(
                                              height: constraints.maxHeight *
                                                  .1,
                                            ),),
                                          Flexible(
                                            flex: 2,
                                            child: Text(
                                              "Groceries",
                                              style: headerStyle,
                                            ),
                                          ),
                                          Flexible(
                                            flex: 2,
                                            child: Text(
                                              "Shopping List",
                                              style: headerStyle,
                                            ),
                                          )
                                        ],
                                      ));
                                },

                              ),),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: GestureDetector(
                              onTap: () {
                                showAboutDialog(
                                  context: context,
                                  applicationIcon: Center(
                                    child: SvgPicture.asset(
                                      "assets/logo_bg.svg",
                                      width: screenWidth * .09,
                                      fit: BoxFit.cover,

                                    ),
                                  ),
                                  applicationName: 'Savvy Shopper',
                                  applicationVersion: 'January 2021',
                                  applicationLegalese: '\u{a9} 2021 Takuonline',
                                  children: aboutBoxChildren,
                                );
                              },
                              child:

                              Transform.scale(
                                scale: _aboutPop.value,
                                child:
                                Container(
//                            height:30,
//                            margin: EdgeInsets.symmetric(vertical: 10),
                                  padding: EdgeInsets.only(
                                      left: screenWidth10p * 2,
                                      right: screenWidth10p * 2,
                                      top: topBottomMargin,
                                      bottom: screenHeight10p * 2),
                                  decoration: BoxDecoration(
//                                  color:Colors.blue,
                                      gradient: LinearGradient(
                                        colors: [
                                          Colors.blue,
                                          Colors.lightBlue
                                        ],

                                      ),
                                      borderRadius: _borderRadiusSmaller),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.info,
                                        color: Colors.white,
                                        size: screenWidth10p * 3,
                                      ),
                                      Flexible(
                                        child: SizedBox(
                                          width: screenWidth10p,
                                        ),
                                      ),
                                      Text(
                                        'About',
                                        style: TextStyle(
                                          color: Colors.white,
                                          decoration: TextDecoration.none,
                                          fontSize: screenWidth10p * 1.7,
                                        ),
                                      )
                                    ],
                                  ),
                                ),)
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: topBottomMargin - 10,
                ),
                Flexible(
                  child: GestureDetector(
                      onTap: () => showIsComingDialog(context),
                      child: Transform.scale(
                        scale: _accessoriesPop.value,
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.blue,
                                    Colors.lightBlue
                                  ],

                                ),
                                borderRadius: _borderRadius),
                            child: Stack(
                              children: [
                                Positioned(

                                  left: screenWidth10p * 4,
                                  top: screenHeight10p * 2,
                                  child: Transform.rotate(
                                    angle: 57,
                                    child: Container(

                                      child: SvgPicture.asset(
                                        "assets/headphone_bg.svg",
                                        width: screenWidth * .27,


//                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),

                                Positioned(
                                  bottom: 0,
                                  right: 0,
                                  left: 0,
                                  child: Container(

//                          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 25),
                                    child: FittedBox(
                                      child: Text(
                                        "Accessories",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: screenWidth10p * 1.5,
                                            decoration: TextDecoration.none),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                        ),)
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: screenHeight10p * 2,
          )
        ],
      ),
    );
  }


  Future<void> showIsComingDialog(BuildContext context) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: Center(child: Text('Coming soon...',
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.white,
                  decoration: TextDecoration.none,

                )

            )),
          );
        });
  }


}
