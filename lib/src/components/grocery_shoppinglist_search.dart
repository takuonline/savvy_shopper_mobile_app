import 'dart:convert';

import 'package:e_grocery/src/components/is_loading_dialog.dart';
import 'package:e_grocery/src/components/product_item.dart';
import 'package:e_grocery/src/networking/connection_test.dart';
import 'package:e_grocery/src/networking/shoprite_data.dart';
import 'package:e_grocery/src/pages/shoprite_product_graph.dart';
import 'package:e_grocery/src/providers/shoprite_product_name_provider.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

class GroceryShoppingListSearch extends SearchDelegate {
  @override
  TextStyle get searchFieldStyle => TextStyle(
        color: Colors.white,
      );

  @override
  TextInputAction get textInputAction => TextInputAction.unspecified;

  @override
  ThemeData appBarTheme(BuildContext context) {
    Map<int, Color> color = {
      50: Color.fromRGBO(207, 15, 20, .1),
      100: Color.fromRGBO(207, 15, 20, .2),
      200: Color.fromRGBO(207, 15, 20, .3),
      300: Color.fromRGBO(207, 15, 20, .4),
      400: Color.fromRGBO(207, 15, 20, .5),
      500: Color.fromRGBO(207, 15, 20, .6),
      600: Color.fromRGBO(207, 15, 20, .7),
      700: Color.fromRGBO(207, 15, 20, .8),
      800: Color.fromRGBO(207, 15, 20, .9),
      900: Color.fromRGBO(207, 15, 20, 1),
    };

    MaterialColor colorCustom = MaterialColor(0xffcf0f14, color);

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
          Navigator.pop(context);
//          Navigator.pushReplacementNamed(context, MenuPage.id);
        },
      ),
    );
  }

  @override
  Widget buildResults(
    BuildContext context,
  ) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var _providerData = Provider.of<ProductNameList>(context);
    final results = _providerData.items
        .where(
          (product) => product.toLowerCase().contains(
                query.toLowerCase(),
              ),
        )
        .toList();

    return ((query == '')
        ? Container()
        : ListView.builder(
            itemCount: results.length,
            itemBuilder: (context, index) => CheckboxListTile(
                  onChanged: (bool value) => print(" item $value"),
                  title: GestureDetector(
                    onTap: () {
                      getProduct(results[index], context);
                    },
                    child: Text(
                      results[index],
                      style: TextStyle(color: Colors.black87),
                    ),
                  ),
                  value: false,
                )));
  }

  void getProduct(dynamic result, BuildContext context) async {
    ShopriteData _shopriteData = ShopriteData();

    if (result != null) {
      if (await TestConnection.checkForConnection()) {
        IsLoading.showIsLoadingDialog(context);

        dynamic response = await _shopriteData.getSingleProductData(result);
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
                ShopriteProductGraph(productItem: _parsedProductItem),
          ),
        );
      } else {
        await TestConnection.showNetworkDialog(context);
      }
    } else {
      close(context, result);
    }
  }
}
