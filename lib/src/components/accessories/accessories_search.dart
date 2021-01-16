import 'dart:convert';
import 'dart:io';

import 'package:e_grocery/src/components/is_loading_dialog.dart';
import 'package:e_grocery/src/components/product_item.dart';
import 'package:e_grocery/src/networking/connection_test.dart';
import 'package:e_grocery/src/pages/accessories_product_graph/accessories_product_graph.dart';
import 'package:e_grocery/src/pages/clothing/foschini_product_graph.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

class AccessoriesProductSearch extends SearchDelegate {
  List items;
  final networkData;
  Color bgColor;

  AccessoriesProductSearch({this.items, this.networkData, this.bgColor});

  @override
  TextStyle get searchFieldStyle => TextStyle(
        color: Colors.white,
      );

  @override
  TextInputAction get textInputAction => TextInputAction.unspecified;

  @override
  ThemeData appBarTheme(BuildContext context) {
    Map<int, Color> color = {
      50: Color.fromRGBO(0, 0, 0, .1),
      100: Color.fromRGBO(0, 0, 0, .2),
      200: Color.fromRGBO(0, 0, 0, .3),
      300: Color.fromRGBO(0, 0, 0, .4),
      400: Color.fromRGBO(0, 0, 0, .5),
      500: Color.fromRGBO(0, 0, 0, .6),
      600: Color.fromRGBO(0, 0, 0, .7),
      700: Color.fromRGBO(0, 0, 0, .8),
      800: Color.fromRGBO(0, 0, 0, .9),
      900: Color.fromRGBO(0, 0, 0, 1),
    };
    MaterialColor colorCustom = MaterialColor(0xff000000, color);

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
    List<String> _providerData = items;
    final results = _providerData
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
                  getProduct(results[index], context, networkData);
                } on SocketException {
                  print(" error, not connected to the internet");
                  TestConnection.showNoNetworkDialog(context);
                } on NoSuchMethodError {
                  print("is no such methodddddd");
                  TestConnection.showOtherErrorDialog(context);
                } catch (error) {
                  print(error);
                  print("unkown errrrrrrror");
                  TestConnection.showProductErrorDialog(context);
                }
              },
              focusColor: Colors.red,
            ),
          ));
  }

  void getProduct(dynamic result, BuildContext context, _networkData) async {
    if (result != null) {
      if (await TestConnection.checkForConnection()) {
        IsLoading.showIsLoadingDialog(context);

        dynamic response = await _networkData.getSingleProductData(result);
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
            builder: (context) => AccessoriesProductGraph(
              productItem: _parsedProductItem,
              graphBgColor: bgColor,
            ),
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
