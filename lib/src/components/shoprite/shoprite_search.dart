import 'dart:convert';
import 'dart:io';

import 'package:e_grocery/src/components/is_loading_dialog.dart';
import 'package:e_grocery/src/components/product_item.dart';
import 'package:e_grocery/src/constants/constants.dart';
import 'package:e_grocery/src/networking/connection_test.dart';
import 'package:e_grocery/src/networking/grocery/shoprite_data.dart';
import 'package:e_grocery/src/pages/groceries_product_graph/shoprite_product_graph.dart';
import 'package:e_grocery/src/providers/grocery/shoprite_product_provider.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

class ProductSearch extends SearchDelegate {
  bool _isLoading = false;

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
//    var _providerData = ;
    final results = Provider.of<ShopriteAllProductList>(context)
        .titles
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
            itemBuilder: (context, index) => ListTile(
                  title: Text(
                    results[index],
                    style: TextStyle(color: Colors.black87),
                  ),
                  onTap: () {
                    try {
                      getProduct(results[index], context);
                    } on NoSuchMethodError {
                      Navigator.pop(context);
                      showErrorDialog(context);
                      print("is no such methodddddd");
                    } on SocketException catch (_) {
                      Navigator.pop(context);
                      TestConnection.showNoNetworkDialog(context);
                    } catch (error) {
                      print(error);
                      Navigator.pop(context);
                      showErrorDialog(context);
                    }
                  },
                  focusColor: Colors.red,
                )));
  }

  static Future<void> showErrorDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Product Infomation error'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'Sorry but it seems like we are having trouble'
                  ' getting infomation on this product',
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
                'Back',
                style: TextStyle(color: kBgShoprite),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void getProduct(dynamic result, BuildContext context) async {
    ShopriteData _shopriteData = ShopriteData();

    if (result != null) {
      _isLoading = true;

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

        _isLoading = false;
        Navigator.pop(context);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                ShopriteProductGraph(productItem: _parsedProductItem),
          ),
        );
      } else {
        await TestConnection.showNoNetworkDialog(context);
      }
    } else {
      close(context, result);
    }
  }
}
