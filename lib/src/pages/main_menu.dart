import 'package:e_grocery/src/constants/constants.dart';
import 'package:e_grocery/src/pages/clothing_home.dart';
import 'package:e_grocery/src/pages/groceries_home.dart';
import 'package:e_grocery/src/pages/shopping_list.dart';
import 'package:e_grocery/src/providers/all_grocery_store_data_provider.dart';
import 'package:e_grocery/src/providers/clothing/foschini/foschini_product_provider.dart';
import 'package:e_grocery/src/providers/clothing/markham/markham_product_provider.dart';
import 'package:e_grocery/src/providers/clothing/sportscene/sportscene_product_provider.dart';
import 'package:e_grocery/src/providers/clothing/superbalist/superbalist_product_provider.dart';
import 'package:e_grocery/src/providers/clothing/woolworths_clothing/woolworths_clothing_product_provider.dart';
import 'package:e_grocery/src/providers/pnp_product_provider.dart';
import 'package:e_grocery/src/providers/shoprite_product_provider.dart';
import 'package:e_grocery/src/providers/woolies_product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class MainMenu extends StatefulWidget {
  static const id = 'main-menu';

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  ScrollController _scrollController = ScrollController();

  final _borderRadius = BorderRadius.circular(15);
  final _borderRadiusSmaller = BorderRadius.circular(10);

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenHeight10p =
        screenHeight * (10 / MediaQuery.of(context).size.height);
    final screenWidth10p =
        screenWidth * (10 / MediaQuery.of(context).size.width);

    final topBottomMargin = screenHeight10p * 2;

    final _extraSpace = SizedBox(
      height: screenHeight10p * 4,
    );

    final TextStyle textStyle = Theme.of(context).textTheme.bodyText2;

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
                text: 'Artwork by: Brgfx and Macrovector on freepik.\n'),
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
          Container(
            width: double.infinity,
            height: screenHeight * .2,
            padding: EdgeInsets.symmetric(
                vertical: screenHeight10p * 2, horizontal: screenWidth10p * 1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Hi,", style: _mainTextStyle),
                Text("Welcome", style: _mainTextStyle),

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
          SizedBox(
            height: screenHeight10p * 2,
          ),
          GestureDetector(
            onTap: () {
              Provider.of<WooliesAllProductList>(context, listen: false)
                  .getItems();
              Provider.of<PnPAllProductList>(context, listen: false).getItems();
              Provider.of<ShopriteAllProductList>(context, listen: false)
                  .getItems();

              Provider.of<AllGroceryStoresData>(context, listen: false)
                  .getAllStoresData();
              Navigator.of(context).pushNamed(GroceriesHomePage.id);
            },
            child: Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              decoration:
                  BoxDecoration(color: kHomeBg, borderRadius: _borderRadius),
              height: screenHeight * .35,
              width: screenWidth * 1,
              child: ClipRRect(
                borderRadius: _borderRadius,
                child: Stack(
                  children: [
                    Positioned(
                      right: screenWidth10p * 0,
                      bottom: screenHeight10p * .2,
                      child: SvgPicture.asset(
                        "assets/main_menu/grocery_shoppinglist_bg.svg",
                        width: screenWidth * 1.3,

//                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      height: double.infinity,
                      width: double.infinity,
                      color: Colors.black.withOpacity(.1),
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
            ),
          ),
          SizedBox(
            height: screenHeight10p * 3,
          ),
          Container(
            margin: EdgeInsets.only(top: topBottomMargin, left: 10, right: 10),
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
                onTap: () {
                  Provider.of<FoschiniAllProductList>(context, listen: false)
                      .getItems();
                  Provider.of<MarkhamAllProductList>(context, listen: false)
                      .getItems();
                  Provider.of<SportsceneAllProductList>(context, listen: false)
                      .getItems();
                  Provider.of<SuperbalistAllProductList>(context, listen: false)
                      .getItems();
                  Provider.of<WoolworthsClothingAllProductList>(context,
                          listen: false)
                      .getItems();
                  Navigator.pushNamed(context, ClothingHome.id);

                  print("clothing");
                },
                child: Stack(
                  children: [
//Image.asset("assets/images/atikh.jpg",fit: BoxFit.fill,width: screenHeight*.5),
                    Positioned(
//                  bottom: screenHeight10p * 0,
//                  right: screenWidth10p * 0,
                      child: SvgPicture.asset(
                        "assets/main_menu/clothing_bg.svg",
                        width: screenWidth * 4,

                        fit: BoxFit.cover,
// color: Colors.black.withOpacity(.2),

//                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      height: double.infinity,
                      width: double.infinity,
                      color: Colors.black.withOpacity(.1),
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
          ),
          _extraSpace,
          SizedBox(
            height: topBottomMargin - 10,
          ),
          Container(
            width: screenWidth,
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
                            onTap: () =>
                                Navigator.pushNamed(context, ShoppingList.id),
                            child: Container(
                                width: double.infinity,
                                margin:
                                    EdgeInsets.only(bottom: topBottomMargin),
                                decoration: BoxDecoration(
//                                    color: Colors.blue,
                                    gradient: LinearGradient(
                                      colors: [Colors.blue, Colors.lightBlue],
                                    ),
                                    borderRadius: _borderRadiusSmaller),
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            vertical: screenHeight10p * 2),
//                                    padding: EdgeInsets.all(screenWidth10p*.7),
                                        decoration: BoxDecoration(

//                                        color: Colors.white.withOpacity(.1),
//                                        borderRadius: _borderRadiusSmaller
                                        ),


                                        child: Icon(
                                          Icons.shopping_cart,
                                          color: Colors.white,
                                          size: screenWidth10p * 3.3,
                                        ),
                                      ),
                                    ),

                                    Flexible(
                                        flex: 2,
                                        child: SizedBox(
                                          height: screenHeight10p * 1.7,
                                        )),
                                    Expanded(
                                      flex: 4,
                                      child: Text(
                                        "Shopping List",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: screenWidth10p * 1.6,
                                            decoration: TextDecoration.none),
                                      ),
                                    )
                                  ],
                                )),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: GestureDetector(
                            onTap: () {
                              showAboutDialog(
                                context: context,
                                applicationIcon: FlutterLogo(),
                                applicationName: 'Savvy Shopper',
                                applicationVersion: 'January 2021',
                                applicationLegalese: '\u{a9} 2021 Takuonline',
                                children: aboutBoxChildren,
                              );
                            },
                            child: Container(
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
                                children: [
                                  Icon(
                                    Icons.info,
                                    color: Colors.white,
                                    size: screenWidth10p * 3,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    'About',
                                    style: TextStyle(
                                      color: Colors.white,
                                      decoration: TextDecoration.none,
                                      fontSize: screenWidth10p * 1.8,
                                    ),
                                  )
                                ],
                              ),
                            ),
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
                          child: Container(

//                          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 25),
                            child: FittedBox(
                              child: Text(
                                "Pc Accessories",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: screenWidth10p * 2,
                                    decoration: TextDecoration.none),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
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
}
