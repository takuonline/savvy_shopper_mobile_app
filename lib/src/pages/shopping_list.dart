import 'dart:io';

import 'package:e_grocery/src/components/grocery_shoppinglist/filter_dialog.dart';
import 'package:e_grocery/src/components/grocery_shoppinglist/grocery_shoppinglist_card.dart';
import 'package:e_grocery/src/components/grocery_shoppinglist/grocery_shoppinglist_item.dart';
import 'package:e_grocery/src/components/grocery_shoppinglist/grocery_shoppinglist_search.dart';
import 'package:e_grocery/src/components/grocery_stores_provider_aggregate_methods.dart';
import 'package:e_grocery/src/constants/constants.dart';
import 'package:e_grocery/src/networking/connection_test.dart';
import 'package:e_grocery/src/providers/grocery_shopping_list.dart';
import 'package:e_grocery/src/providers/shoppinglist_filter.dart';
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
  bool _isLoading = false;

  bool _isPnPChecked = true;
  bool _isShopriteChecked = true;
  bool _isWooliesChecked = true;

  List<GroceryShoppingListItem> _productsList = [];

  void _dropItem(int index) {
    Provider.of<GroceryShoppingList>(context, listen: false)
        .dropItemGroceryShoppingList(index);
    setState(() => _calculateBalance());
  }

  void _clearAllProducts() {
    Provider.of<GroceryShoppingList>(context, listen: false)
        .clearGroceryShoppingList();
    setState(() => _calculateBalance());

  }

  void _calculateBalance() {
    balance = 0;
    for (GroceryShoppingListItem i in _productsList) {
      balance += i.prices.last * i.quantity;
    }
    setState(() {});
  }

  Future<void> _onRefresh() async {
    setState(() => _isLoading = true);
    await GroceryStoresProviderMethods.checkNullAndGetAllProductData(context);
    setState(() => _isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    _getNetworkData();
  }

  Future<void> _getNetworkData() async {
    setState(() => _isLoading = true);

    if (await TestConnection.checkForConnection()) {
      try {
        await GroceryStoresProviderMethods.checkNullAndGetAllProductData(
            context);
      } on SocketException {
        TestConnection.showNoNetworkDialog(context);
      } catch (e) {
        setState(() => _isLoading = true);
        print(e);
      }

      setState(() => _isLoading = false);
    } else {
      TestConnection.showNoNetworkDialog(context);
    }
  }

  Future<void> _showFilterDialog() async {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenHeight10p =
        screenHeight * (10 / MediaQuery.of(context).size.height);
    final screenWidth10p =
        screenWidth * (10 / MediaQuery.of(context).size.width);

    return (await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Container(

          margin: EdgeInsets.symmetric(
            vertical: screenHeight * .27,
            horizontal: screenWidth * .15,
          ),
          child: FilterDialog(
              _isShopriteChecked, _isPnPChecked, _isWooliesChecked),
        );
      },
    ));
  }


  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenHeight10p =
        screenHeight * (10 / MediaQuery
            .of(context)
            .size
            .height);
    final screenWidth10p =
        screenWidth * (10 / MediaQuery
            .of(context)
            .size
            .width);

    _productsList = Provider
        .of<GroceryShoppingList>(context, listen: true)
        .items
        .toSet()
        .toList();

    _isShopriteChecked = Provider
        .of<GroceryShoppingListFilter>(context)
        .getData['shoprite'];
    _isPnPChecked = Provider
        .of<GroceryShoppingListFilter>(context)
        .getData['pnp'];
    _isWooliesChecked = Provider
        .of<GroceryShoppingListFilter>(context)
        .getData['woolies'];

    _calculateBalance();

    return RefreshIndicator(
      onRefresh: () => _onRefresh(),
      child: Scaffold(
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
                    onTap: () {},
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
                      if (_isLoading)
                        Column(
                          children: [
                            Center(
                              child: CircularProgressIndicator(),
                            ),
                            SizedBox(
                              height: screenHeight10p * 2,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth10p * 2),
                              child: Text(
                                "Please wait. This might take some time",
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(
                              height: screenHeight10p,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth10p * 2),
                              child: Text(
                                "Pull down to refresh the screen if this takes too long",
                                textAlign: TextAlign.center,
                              ),
                            )
                          ],
                        ),
                      if (!_isLoading)
                        Row(
                          children: [
                            Flexible(
                              flex: 10,
                              child: GestureDetector(
                                onTap: () async {
                                  if (await TestConnection
                                      .checkForConnection()) {
                                    try {
//                          get client data with all the info stored in provider
//                                      final _dataShoprite =
//                                          Provider
//                                              .of<ShopriteAllProductList>(
//                                              context,
//                                              listen: false)
//                                              .data;
//
//                                      final _dataPnP =
//                                          Provider
//                                              .of<PnPAllProductList>(
//                                              context,
//                                              listen: false)
//                                              .data;

//                                      final _dataWoolies =
//                                          Provider
//                                              .of<WooliesAllProductList>(
//                                              context,
//                                              listen: false)
//                                              .data;

                                      //                          only get the Title data from all the info
//                                      Provider.of<ShopriteAllProductList>(
//                                          context,
//                                          listen: false)
//                                          .getProductNameList(
//                                           );

//                                      Provider.of<PnPProductNameList>(context,
//                                          listen: false)
//                                          .getProductNameList(
//                                          _dataPnP, context);

//                                      Provider.of<WooliesProductNameList>(
//                                          context,
//                                          listen: false)
//                                          .getProductNameList(
//                                          _dataWoolies, context);
                                    } on Exception {
                                      TestConnection.showOtherErrorDialog(
                                          context);
                                    }

                                    Provider.of<GroceryShoppingListFilter>(
                                        context, listen: false).getCombinedList(
                                        context);

                                    final result = await showSearch(
                                        context: context,
                                        delegate: GroceryShoppingListSearch());
                                    print(result);

//                            Provider
//                                .of<GroceryShoppingList>(context,
//                                listen: false).setItems = result;

//                            if (result != null) {
//                              setState(() {
//                                _productsList =
//                                    (_productsList + result).toSet().toList();
//                              });
//                            } else {
//                              _productsList = _productsList.toSet().toList();
//
                                  } else {
                                    await TestConnection.showNoNetworkDialog(
                                        context);
                                  }
                                },
                                child: Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: screenWidth10p * 1.5),
                                  decoration: BoxDecoration(
                                      color: kHomeBg.withOpacity(.2),
                                      borderRadius: BorderRadius.circular(
                                          screenWidth10p)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.search,
                                        color: Colors.black,
                                        size: screenWidth10p * 2.3,
                                      ),

                                      Flexible(
                                        child: SizedBox(
                                          width: screenWidth * .04,
                                        ),
                                      ),

                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: screenWidth10p * .2,
                                            vertical: screenHeight10p * 2),
                                        child: FittedBox(
                                          child: Text(
                                            "Search Product",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: "Montserrat",
                                                decoration: TextDecoration.none,
                                                color: kTextColor,
                                                fontWeight: FontWeight.w500,
                                                fontSize: screenWidth10p * 1.7),
                                          ),
                                        ),
                                      ),


                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Flexible(
                                flex: 2,
                                child: GestureDetector(
                                  onTap: () {
                                    _showFilterDialog();
                                    print(_isShopriteChecked);
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                        color: kHomeBg.withOpacity(.2),
                                        borderRadius: BorderRadius.circular(
                                            screenWidth10p * 1.2)),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: screenWidth10p * .35,
                                        vertical: screenHeight10p * 1.7),
                                    child: Center(
                                      child: Icon(
                                        Icons.filter_alt_outlined,
                                        size: screenWidth10p * 2.6,
                                      ),
                                    ),
                                  ),
                                ))
                          ],
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
                                index: index,
                                productItem: _productsList[index],
                                calculateBalance: _calculateBalance,
                                dropItem: _dropItem);
                          }),
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
          height: screenHeight * .21,
          width: double.infinity,
          decoration: BoxDecoration(
              color: kTextFieldBgGrey,
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(screenWidth10p * 4))),
          child: LayoutBuilder(builder: (_, constraints) {
            return Column(
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
                Spacer(),
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
                SizedBox(
                  height: screenHeight10p * .5,
                ),
              ],
            );
          }),
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


