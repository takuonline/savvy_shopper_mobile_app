import 'dart:convert';
import 'dart:io';

import 'package:e_grocery/src/components/grocery_shoppinglist/grocery_shoppinglist_item.dart';
import 'package:e_grocery/src/components/is_loading_dialog.dart';
import 'package:e_grocery/src/components/product_item.dart';
import 'package:e_grocery/src/constants/constants.dart';
import 'package:e_grocery/src/networking/connection_test.dart';
import 'package:e_grocery/src/networking/pnp_data.dart';
import 'package:e_grocery/src/networking/shoprite_data.dart';
import 'package:e_grocery/src/networking/woolies_data.dart';
import 'file:///C:/Users/Taku/AndroidStudioProjects/e_grocery/lib/src/pages/groceries_product_graph/pnp_product_graph.dart';
import 'file:///C:/Users/Taku/AndroidStudioProjects/e_grocery/lib/src/pages/groceries_product_graph/shoprite_product_graph.dart';
import 'file:///C:/Users/Taku/AndroidStudioProjects/e_grocery/lib/src/pages/groceries_product_graph/woolies_product_graph.dart';
import 'package:e_grocery/src/providers/grocery_shopping_list.dart';
import 'package:e_grocery/src/providers/pnp_product_name_provider.dart';
import 'package:e_grocery/src/providers/shoprite_product_name_provider.dart';
import 'package:e_grocery/src/providers/woolies_product_name_provider.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

class GroceryShoppingListSearch
    extends SearchDelegate<List<GroceryShoppingListItem>> {
  List<GroceryShoppingListItem> _resultsList = [];

  @override
  TextStyle get searchFieldStyle => TextStyle(
        color: Colors.white,
      );

  @override
  TextInputAction get textInputAction => TextInputAction.unspecified;

  @override
  ThemeData appBarTheme(BuildContext context) {
    Map<int, Color> color = {
      50: Color.fromRGBO(0, 51, 89, .1),
      100: Color.fromRGBO(0, 51, 89, .2),
      200: Color.fromRGBO(0, 51, 89, .3),
      300: Color.fromRGBO(0, 51, 89, .4),
      400: Color.fromRGBO(0, 51, 89, .5),
      500: Color.fromRGBO(0, 51, 89, .6),
      600: Color.fromRGBO(0, 51, 89, .7),
      700: Color.fromRGBO(0, 51, 89, .8),
      800: Color.fromRGBO(0, 51, 89, .9),
      900: Color.fromRGBO(0, 51, 89, 1),
    };

    MaterialColor colorCustom = MaterialColor(0xff003359, color);

    return ThemeData(
      primarySwatch: colorCustom,
      textTheme: TextTheme(
          headline6: TextStyle(
              fontFamily: "Montserrat", fontSize: 16, color: Colors.white)),
      appBarTheme: AppBarTheme(elevation: 0, shadowColor: Colors.transparent),
    );
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return Container(
      child: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          close(context, _resultsList);
        },
      ),
    );
  }

  @override
  Widget buildResults(BuildContext context,) {
    return Container();
  }

  @override
  void showResults(BuildContext context) {
    close(context, _resultsList);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List <StoreAndTitle> _combinedList = getCombinedList(context);


    final results = _combinedList
        .where(
          (storeAndTitle) =>
          storeAndTitle.title.toLowerCase().contains(
            query.toLowerCase(),
          ),
    )
        .toList();


    return query == ''
        ? Container()
        : StatefulBuilder(

      builder: (BuildContext context, StateSetter setState) {
        return ListView.builder(
          itemCount: results == null ? 0 : results.length,
          itemBuilder: (context, index) =>
              ListTile(
                onTap: () {
                  getProduct(results[index], context);
                },
                subtitle: Text(results[index].store,
                    style: TextStyle(color: Colors.black54,
                      fontFamily: "Montserrat",
                      fontStyle: FontStyle.italic,

                    )

                ),
                trailing: GestureDetector(
                  onTap: () async {
                    try {
                      _resultsList.add(
                          await addToShoppingList(results[index], context));
                      _showSnackBar(context,
                          " Added ${results[index].title} to shopping list");
                    } on NoSuchMethodError {
                      Navigator.pop(context);
                      TestConnection.showProductErrorDialog(context);
                      print("is no such methodddddd");
                    } on SocketException catch (_) {
                      Navigator.pop(context);
                      TestConnection.showNetworkDialog(context);
                    } catch (error) {
                      print(error);
                      Navigator.pop(context);
                      TestConnection.showProductErrorDialog(context);
                    }
                  },
                  child: Text(
                    "add", style: TextStyle(
                      color: Colors.red,
                      fontFamily: "Montserrat",
                      fontSize: 15
                  ),
                  ),
                ),
                title: Text(
                  results[index].title,
                  style: TextStyle(color: Colors.black87),
                ),

              ),
        );
      },
    )
    ;
  }

  List<StoreAndTitle> getCombinedList(BuildContext context) {
    var _pnpProviderData = Provider.of<PnPProductNameList>(context);
    var _shopriteProviderData = Provider.of<ShopriteProductNameList>(context);
    var _wooliesProviderData = Provider.of<WooliesProductNameList>(context);


    List<StoreAndTitle> _pnpTitles = _pnpProviderData.items.map((e) =>
        StoreAndTitle("Pick n Pay", e)).toList();
    List<StoreAndTitle> _shopriteTitles = _shopriteProviderData.items.map((e) =>
        StoreAndTitle("Shoprite", e)).toList();
    List<StoreAndTitle> _wooliesTitles = _wooliesProviderData.items.map((e) =>
        StoreAndTitle("Woolworths", e)).toList();


    return _pnpTitles + _shopriteTitles + _wooliesTitles;
  }

  void openGraph(BuildContext context, _networkData,
      StoreAndTitle result) async {
    IsLoading.showIsLoadingDialog(context);

    dynamic response = await _networkData.getSingleProductData(result.title);
    dynamic parsedResponse = jsonDecode(response);

    List<DateTime> tempDateList = [];

    List<dynamic> datesList =
    parsedResponse[parsedResponse.keys.elementAt(0).toString()]
    ['dates'];
    for (var dateString in datesList) {
      tempDateList.add((DateTime.parse(dateString)));
    }

    ProductItem _parsedProductItem = ProductItem(
        parsedResponse[parsedResponse.keys.elementAt(0).toString()]
        ['image_url'],
        parsedResponse[parsedResponse.keys.elementAt(0).toString()]
        ['prices_list'],
        tempDateList,
        parsedResponse.keys.elementAt(0).toString(),
        parsedResponse[parsedResponse.keys.elementAt(0).toString()]
        ['change']);

    Navigator.pop(context);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            PnPProductGraph(productItem: _parsedProductItem),
      ),
    );
  }

  void openGraphNoImage(BuildContext context, _networkData,
      StoreAndTitle result) async {
    IsLoading.showIsLoadingDialog(context);

    dynamic response = await _networkData.getSingleProductData(result.title);
    dynamic parsedResponse = jsonDecode(response);

    List<DateTime> tempDateList = [];

    List<dynamic> datesList =
    parsedResponse[parsedResponse.keys.elementAt(0).toString()]
    ['dates'];
    for (var dateString in datesList) {
      tempDateList.add((DateTime.parse(dateString)));
    }

    WooliesProductItem _parsedProductItem = WooliesProductItem(
        parsedResponse[parsedResponse.keys.elementAt(0).toString()]
        ['prices_list'],
        tempDateList,
        parsedResponse.keys.elementAt(0).toString(),
        parsedResponse[parsedResponse.keys.elementAt(0).toString()]
        ['change']);

    Navigator.pop(context);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            WooliesProductGraph(productItem: _parsedProductItem),
      ),
    );
  }

  void getProduct(StoreAndTitle result, BuildContext context) async {
    if (result != null) {
      if (await TestConnection.checkForConnection()) {
        if (result.store == "Pick n Pay") {
          PnPData _networkData = PnPData();
          return openGraph(context, _networkData, result);
        }
        else if (result.store == "Shoprite") {
          ShopriteData _networkData = ShopriteData();
          return openGraph(context, _networkData, result);
        }
        else if (result.store == "Woolworths") {
          WooliesData _networkData = WooliesData();
          return openGraphNoImage(context, _networkData, result);
        }
      } else {
        await TestConnection.showNetworkDialog(context);
      }
    } else {
      close(context, _resultsList);
    }
  }


  Future<GroceryShoppingListItem> addToShoppingList(StoreAndTitle result,
      BuildContext context) async {
    if (result != null) {
      if (await TestConnection.checkForConnection()) {
        IsLoading.showIsLoadingDialog(context);

        if (result.store == "Pick n Pay") {
          PnPData _networkData = PnPData();
          return getDataFromNetwork(context, _networkData, result);
        }
        else if (result.store == "Shoprite") {
          ShopriteData _networkData = ShopriteData();
          return getDataFromNetwork(context, _networkData, result);
        }
        else if (result.store == "Woolworths") {
          WooliesData _networkData = WooliesData();
          return getDataFromNetworkNoImage(context, _networkData, result);
        } else {
          print(result.store);
        }
      } else {
        await TestConnection.showNetworkDialog(context);
      }
    } else {
      close(context, _resultsList);
    }
  }

  Future<GroceryShoppingListItem> getDataFromNetwork(context, _networkData,
      result) async {
    dynamic response = await _networkData.getSingleProductData(result.title);
    dynamic parsedResponse = jsonDecode(response);
    print("got data");

    List<DateTime> tempDateList = [];

    List<dynamic> datesList =
    parsedResponse[parsedResponse.keys.elementAt(0).toString()]
    ['dates'];
    for (var dateString in datesList) {
      tempDateList.add((DateTime.parse(dateString)));
    }

    ProductItem _parsedProductItem = ProductItem(
        parsedResponse[parsedResponse.keys.elementAt(0).toString()]
        ['image_url'],
        parsedResponse[parsedResponse.keys.elementAt(0).toString()]
        ['prices_list'],
        tempDateList,
        parsedResponse.keys.elementAt(0).toString(),
        parsedResponse[parsedResponse.keys.elementAt(0).toString()]
        ['change']);

    GroceryShoppingListItem _groceryItem = GroceryShoppingListItem(
        title: _parsedProductItem.title,
        store: result.store,
        prices: _parsedProductItem.prices,
        imageUrl: _parsedProductItem.imageUrl,
        change: _parsedProductItem.change,
        quantity: 1,
        productItem: _parsedProductItem
    );

    Provider.of<GroceryShoppingList>(context, listen: false)
        .addToGroceryShoppingList(_groceryItem);

    Navigator.pop(context);

    return _groceryItem;
  }


  Future<GroceryShoppingListItem> getDataFromNetworkNoImage(context,
      _networkData, result) async {
    dynamic response = await _networkData.getSingleProductData(result.title);
    dynamic parsedResponse = jsonDecode(response);
    print("got data");

    List<DateTime> tempDateList = [];

    List<dynamic> datesList =
    parsedResponse[parsedResponse.keys.elementAt(0).toString()]
    ['dates'];
    for (var dateString in datesList) {
      tempDateList.add((DateTime.parse(dateString)));
    }

    WooliesProductItem _parsedProductItem = WooliesProductItem(
        parsedResponse[parsedResponse.keys.elementAt(0).toString()]
        ['prices_list'],
        tempDateList,
        parsedResponse.keys.elementAt(0).toString(),
        parsedResponse[parsedResponse.keys.elementAt(0).toString()]
        ['change']);

    GroceryShoppingListItem _groceryItem = GroceryShoppingListItem(
        title: _parsedProductItem.title,
        store: result.store,
        prices: _parsedProductItem.prices,
        change: _parsedProductItem.change,
        quantity: 1,
        wooliesProductItem: _parsedProductItem
    );


    Provider.of<GroceryShoppingList>(context, listen: false)
        .addToGroceryShoppingList(_groceryItem);
    Navigator.pop(context);

    return _groceryItem;
  }


  void _showSnackBar(BuildContext context, String text) {
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.black87


        ),
      ),
      backgroundColor: Colors.orange,
    ));
  }

}


class StoreAndTitle {
  String store;
  String title;

  StoreAndTitle(this.store, this.title);
}