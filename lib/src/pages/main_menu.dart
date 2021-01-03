import 'package:e_grocery/src/constants/constants.dart';
import 'package:e_grocery/src/pages/home.dart';
import 'package:e_grocery/src/pages/shopping_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MainMenu extends StatefulWidget {
  static const id = 'main-menu';

  @override
  _MainMenuState createState() => _MainMenuState();
}

class _MainMenuState extends State<MainMenu> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenHeight10p =
        screenHeight * (10 / MediaQuery.of(context).size.height);
    final screenWidth10p =
        screenWidth * (10 / MediaQuery.of(context).size.width);

    final _borderRadius = BorderRadius.circular(15);
    final _borderRadiusSmaller = BorderRadius.circular(10);

    ScrollController _scrollController = ScrollController();

    return Container(
      color: kTextFieldBgGrey,
      child: ListView(
        shrinkWrap: true,
        controller: _scrollController,
        children: [
          Container(
            width: double.infinity,
            height: screenHeight * .3,
            child: Row(children: <Widget>[
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                      color: kHomeBg,
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(30))),
                ),
              ),
              Expanded(
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ]),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(HomePage.id),
            child: Container(
              margin: EdgeInsets.only(top: 50, left: 10, right: 10),
              decoration:
                  BoxDecoration(color: kHomeBg, borderRadius: _borderRadius),
              height: screenHeight * .35,
              width: screenWidth * 1,
              child: Stack(
                children: [
                  Positioned(
                    left: screenWidth10p * 7.5,
                    top: screenHeight10p * 2.3,
                    child: Opacity(
                      opacity: .0,
                      child: SvgPicture.asset(
                        "assets/shoprite/shoprite_w_1.svg",
                        width: screenHeight * .3,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: screenHeight10p * 3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      child: Text(
                        "Groceries",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: screenWidth10p * 5,
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
          Container(
            margin: EdgeInsets.only(top: 10, left: 10, right: 10),
//            color: kHomeBg,
            height: screenHeight * .25,
            width: screenWidth,
            decoration: BoxDecoration(
                borderRadius: _borderRadius,
                image: DecorationImage(
                    image: AssetImage('assets/images/atikh.jpg'),
                    fit: BoxFit.cover,
                    scale: 2,
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(.2), BlendMode.multiply),
                    alignment: Alignment.lerp(
                        Alignment.topLeft, Alignment.bottomLeft, .1))),
            child: Stack(
              children: [
//Image.asset("assets/images/atikh.jpg",fit: BoxFit.fill,width: screenHeight*.5),
                Positioned(
                  bottom: screenHeight10p * 3,
                  right: screenWidth10p * 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 10),
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
          Container(
            width: screenWidth,
            height: screenHeight * .33,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(top: 10, left: 10, bottom: 10),
//                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 25),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 5,
                          child: GestureDetector(
                            onTap: () =>
                                Navigator.pushNamed(context, ShoppingList.id),
                            child: Container(
                                width: double.infinity,
                                margin: EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: _borderRadiusSmaller),
                                child: Column(
                                  children: [
                                    Expanded(
                                      flex: 4,
                                      child: Container(
                                        margin:
                                            EdgeInsets.symmetric(vertical: 20),
//                                    padding: EdgeInsets.all(screenWidth10p*.7),
                                        decoration: BoxDecoration(
//                                        color: Colors.white.withOpacity(.1),
//                                        borderRadius: _borderRadiusSmaller
                                            ),
                                        child: Icon(
                                          Icons.shopping_cart,
                                          color: Colors.white,
                                          size: screenWidth10p * 4,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                        flex: 2,
                                        child: SizedBox(
                                          height: 10,
                                        )),
                                    Expanded(
                                        flex: 4,
                                        child: Text(
                                          "Shopping List",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: screenWidth10p * 2,
                                              decoration: TextDecoration.none),
                                        ))
                                  ],
                                )),
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Container(
//                            height:30,
//                            margin: EdgeInsets.symmetric(vertical: 10),
                            padding: EdgeInsets.all(screenWidth10p * 2),
                            decoration: BoxDecoration(
                                color: Colors.black,
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
                                    fontSize: screenWidth10p * 2,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: kHomeBg, borderRadius: _borderRadiusSmaller),
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(.15),
                                borderRadius: BorderRadius.circular(300)),
                            padding: EdgeInsets.symmetric(
                                horizontal: screenWidth10p * 1.5,
                                vertical: screenHeight10p * 1.5),
                            child: Icon(
                              Icons.computer,
                              color: Colors.white,
                              size: screenWidth10p * 5,
                              semanticLabel: 'Pc components',
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: SizedBox(
                              height: 10,
                            )),
                        Expanded(
                          flex: 4,
                          child: Text(
                            "Pc Compontents",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: screenWidth10p * 2,
                                decoration: TextDecoration.none),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
