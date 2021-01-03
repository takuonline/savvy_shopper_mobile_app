import 'package:e_grocery/src/components/grocery_shoppinglist_search.dart';
import 'package:e_grocery/src/constants/constants.dart';
import 'package:e_grocery/src/networking/connection_test.dart';
import 'package:e_grocery/src/providers/shoprite_product_name_provider.dart';
import 'package:e_grocery/src/providers/shoprite_product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShoppingList extends StatefulWidget {
  static const id = "shopping-list";

  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenHeight10p =
        screenHeight * (10 / MediaQuery.of(context).size.height);
    final screenWidth10p =
        screenWidth * (10 / MediaQuery.of(context).size.width);
    return Scaffold(
      body: Container(
        color: kTextFieldBgGrey,
        child: ListView(
          controller: _scrollController,
          shrinkWrap: true,
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: screenWidth10p * 3),
                child: GestureDetector(
                  onTap: () {
                    Provider.of<AllProductList>(context, listen: false)
                        .getItems();
                  },
                  child: Text(
                    "Shopping List",
                    style: TextStyle(
                        fontFamily: "ClickerScript",
                        fontSize: screenWidth10p * 5,
                        fontWeight: FontWeight.w500,
                        decoration: TextDecoration.none,
                        color: kBgPnP),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 0),
              width: screenWidth,
              height: screenHeight,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(screenWidth10p * 4)),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: screenWidth10p * 4),
                child: ListView(
//                physics: NeverScrollableScrollPhysics(),
                  controller: _scrollController,
                  shrinkWrap: true,
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (await TestConnection.checkForConnection()) {
                          final _data = Provider.of<AllProductList>(context,
                                  listen: false)
                              .data;
                          Provider.of<ProductNameList>(context, listen: false)
                              .getProductNameList(_data, context);
                          final result = await showSearch(
                              context: context,
                              delegate: GroceryShoppingListSearch());
                          print(result);
                        } else {
                          await TestConnection.showNetworkDialog(context);
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: screenWidth10p * 3),
                        decoration: BoxDecoration(
                            color: Colors.orange.withOpacity(.2),
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search,
                              color: Colors.black,
                            ),
                            SizedBox(
                              width: screenWidth * .05,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 20),
                              child: FittedBox(
                                child: Text(
                                  "Search Product",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: "Montserrat",
                                      decoration: TextDecoration.none,
                                      color: kTextColor,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    ShoppingListCard(),
                    ShoppingListCard(),
                    ShoppingListCard(),
                    SizedBox(
                      height: screenHeight * .27,
                    ),
//                  ShoppingListCard(screenWidth: screenWidth, screenHeight: screenHeight, screenWidth10p: screenWidth10p, screenHeight10p: screenHeight10p),
//                  ShoppingListCard(screenWidth: screenWidth, screenHeight: screenHeight, screenWidth10p: screenWidth10p, screenHeight10p: screenHeight10p),
//                  ShoppingListCard(screenWidth: screenWidth, screenHeight: screenHeight, screenWidth10p: screenWidth10p, screenHeight10p: screenHeight10p)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      bottomSheet: Container(
        padding: EdgeInsets.fromLTRB(
            screenWidth10p * 4, screenHeight10p * 2, screenWidth10p * 4, 0),
        height: screenHeight * .2,
        width: double.infinity,
        decoration: BoxDecoration(
            color: kTextFieldBgGrey,
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(screenWidth10p * 4))),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Item count',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Montserrat",
                      decoration: TextDecoration.none,
                      fontSize: screenWidth10p * 2),
                ),
                Text(
                  '3',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Montserrat",
                      fontSize: screenWidth10p * 2,
                      decoration: TextDecoration.none),
                ),
              ],
            ),
            Divider(
              color: kTextColor,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Balance',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Montserrat",
                      decoration: TextDecoration.none,
                      fontSize: screenWidth10p * 2),
                ),
                Text(
                  'R90',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Montserrat",
                      fontSize: screenWidth10p * 2,
                      decoration: TextDecoration.none),
                ),
              ],
            ),
            SizedBox(
              height: screenHeight10p,
            ),
            GestureDetector(
              onTap: () => showClearAllDialog(context),
              child: Container(
                color: Colors.black,
                child: Center(
                  child: Text(
                    "Clear All",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: "Montserrat",
                        fontSize: screenWidth10p * 2,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                width: double.infinity,
                height: screenHeight10p * 3,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Future<void> showClearAllDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Attention!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Are you sure you want to remove this item from your shopping list?',
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    color: Colors.black,
                  ),
                ),
//                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(color: kTextColor),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Ok',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}

class ShoppingListCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenHeight10p =
        screenHeight * (10 / MediaQuery.of(context).size.height);
    final screenWidth10p =
        screenWidth * (10 / MediaQuery.of(context).size.width);
    return Container(
      width: screenWidth * .7,
      height: screenHeight * .26,
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.only(left: 10, right: 0, top: 10, bottom: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: Colors.black,
            width: 5,
          )),
      child: Row(children: [
        Expanded(
          flex: 20,
          child: Column(
            children: [
              Text(
                'Ritebrand Salad Cream brand Salad Cream',
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                    fontFamily: "Montserrat",
                    decoration: TextDecoration.none,
                    fontSize: screenWidth10p * 2),
              ),
              SizedBox(
                height: screenHeight10p,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Quantity',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Montserrat",
                        decoration: TextDecoration.none,
                        fontSize: screenWidth10p * 2),
                  ),
                  Text(
                    '2',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Montserrat",
                        fontSize: screenWidth10p * 2,
                        decoration: TextDecoration.none),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Montserrat",
                        fontSize: screenWidth10p * 2,
                        decoration: TextDecoration.none),
                  ),
                  Text(
                    'R30',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontFamily: "Montserrat",
                        fontSize: screenWidth10p * 2,
                        decoration: TextDecoration.none),
                  ),
                ],
              ),
              SizedBox(
                height: screenHeight10p,
              ),
              Container(
                width: double.infinity,
                color: Colors.red,
                child: Text(
                  "Shoprite",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Montserrat",
                      fontSize: screenWidth10p * 2,
                      decoration: TextDecoration.none),
                ),
              )
            ],
          ),
        ),
        Expanded(
            flex: 6,
            child: Container(
              decoration: BoxDecoration(
                  color: kTextFieldBgGrey,
                  borderRadius: BorderRadius.circular(screenWidth10p * 1)),
              margin: EdgeInsets.symmetric(horizontal: screenHeight10p),
              padding: EdgeInsets.symmetric(horizontal: screenWidth10p),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Icon(
                      Icons.add,
                      size: screenWidth10p * 2,
                      color: kTextColor,
                    ),
                  ),
                  Expanded(
                    child: Icon(
                      Icons.remove,
                      size: screenWidth10p * 2,
                      color: kTextColor,
                    ),
                  ),
                  Expanded(
                    child: Icon(
                      Icons.delete,
                      size: screenWidth10p * 2,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ))
      ]),
    );
  }
}
