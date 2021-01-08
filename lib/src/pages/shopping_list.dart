import 'package:e_grocery/src/components/grocery_shoppinglist/grocery_shoppinglist_card.dart';
import 'package:e_grocery/src/components/grocery_shoppinglist/grocery_shoppinglist_item.dart';
import 'package:e_grocery/src/components/grocery_shoppinglist/grocery_shoppinglist_search.dart';
import 'package:e_grocery/src/components/product_item.dart';
import 'package:e_grocery/src/constants/constants.dart';
import 'package:e_grocery/src/networking/connection_test.dart';
import 'package:e_grocery/src/providers/grocery_shopping_list.dart';
import 'package:e_grocery/src/providers/pnp_product_name_provider.dart';
import 'package:e_grocery/src/providers/pnp_product_provider.dart';
import 'package:e_grocery/src/providers/shoprite_product_name_provider.dart';
import 'package:e_grocery/src/providers/shoprite_product_provider.dart';
import 'package:e_grocery/src/providers/woolies_product_name_provider.dart';
import 'package:e_grocery/src/providers/woolies_product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShoppingList extends StatefulWidget {
  static const id = "shopping-list";

  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {
  ScrollController _scrollController = ScrollController();
  double balance = 0;

  List<GroceryShoppingListItem> _productsList = [];

  void _dropItem(int index) {
//    Provider.of<GroceryShoppingList>(context,listen: false).dropItemGroceryShoppingList(index);

    setState(() {
      _productsList.removeAt(index);
    });
  }

  void _clearAllProducts() {
//      Provider.of<GroceryShoppingList>(context,listen: false).clearGroceryShoppingList();

    setState(() {
      _productsList.clear();
    });
  }

  void _calculateBalance() {
    balance = 0;
    for (GroceryShoppingListItem i in _productsList) {
      balance += i.prices.last * i.quantity;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenHeight10p =
        screenHeight * (10 / MediaQuery.of(context).size.height);
    final screenWidth10p =
        screenWidth * (10 / MediaQuery.of(context).size.width);
    _calculateBalance();

    return Scaffold(
      backgroundColor: kTextFieldBgGrey,
      extendBody: true,
      body: Container(
        color: kTextFieldBgGrey,
        child: ListView(
          controller: _scrollController,
          shrinkWrap: true,
          children: [
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: screenWidth10p * 1),
                child: GestureDetector(
                  onTap: () {
                    Provider.of<PnPAllProductList>(context, listen: false)
                        .getItems();

                    Provider.of<WooliesAllProductList>(context, listen: false)
                        .getItems();

                    Provider.of<ShopriteAllProductList>(context, listen: false)
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
              height: _productsList.isEmpty ? screenHeight : null,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(screenWidth10p * 4)),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: screenWidth10p * 2),
                child: ListView(
                  controller: _scrollController,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (await TestConnection.checkForConnection()) {
                          try {
//                          get client data with all the info stored in provider
                            final _dataShoprite = Provider
                                .of<ShopriteAllProductList>(context,
                                listen: false)
                                .data;

                            final _dataPnP = Provider
                                .of<PnPAllProductList>(context,
                                listen: false)
                                .data;

                            final _dataWoolies = Provider
                                .of<WooliesAllProductList>(context,
                                listen: false)
                                .data;

                            //                          only get the Title data from all the info
                            Provider.of<ShopriteProductNameList>(
                                context, listen: false)
                                .getProductNameList(_dataShoprite, context);

                            Provider.of<PnPProductNameList>(
                                context, listen: false)
                                .getProductNameList(_dataPnP, context);

                            Provider.of<WooliesProductNameList>(
                                context, listen: false)
                                .getProductNameList(_dataWoolies, context);
                          } on Exception {
                            TestConnection.showOtherErrorDialog(context);
                          }

                          final result = await showSearch(
                              context: context,
                              delegate: GroceryShoppingListSearch());
                          print(result);

                          if (result != null) {
                            setState(() {
                              _productsList =
                                  (_productsList + result).toSet().toList();
                            });
                          } else {
                            _productsList = _productsList.toSet().toList();
                          }
                        } else {
                          await TestConnection.showNetworkDialog(context);
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: screenWidth10p * 3),
                        decoration: BoxDecoration(
                            color: kHomeBg.withOpacity(.2),
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


                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: _productsList.length,
                        controller: _scrollController,
                        itemBuilder: (BuildContext _, int index) {
                          return ShoppingListCard(
                              index: index, productItem: _productsList[index]
                              ,
                              calculateBalance: _calculateBalance,
                              dropItem: _dropItem
                          );
                        }
                    ),

                    SizedBox(
                      height: screenHeight * .27,
                    ),
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
                  '${_productsList.length}',
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
                  'R${balance.toStringAsFixed(2)}',
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
              onTap: () => showClearAllDialog(context, _clearAllProducts),
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

  static Future<void> showClearAllDialog(BuildContext context,
      Function clearAllProducts) async {
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
                  'Are you sure you want to remove all items from your shopping list?',
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
                clearAllProducts();
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }
}

