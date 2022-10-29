import 'dart:convert';

import 'package:e_grocery/src/components/product_item.dart';
import 'package:e_grocery/src/constants/constants.dart';
import 'package:e_grocery/src/networking/connection_test.dart';
import 'package:flutter/material.dart';

mixin ClothingHomePageMixin<T extends StatefulWidget> on State<T> {
  final textController = TextEditingController();
  final gridScrollController = ScrollController();
  ScrollController scrollController = ScrollController();
  TabController tabController;

  bool isDataLoaded = false;

  bool isLoading = false;
  dynamic data;
  final double horizontalPadding = 20.0;

  List<ProductItem> cheap = [];
  List<ProductItem> expensive = [];
  List<ProductItem> allProducts = [];

  bool isGridOff = false;
  final nullImageUrl =
      'https://image.tfgmedia.co.za/image/1/process/452x57?source=http://cdn.tfgmedia.co.za/00/BrandImage/foschini.png';

  void loadData(BuildContext context) {
    if (data != null && !isDataLoaded) {
      cleanCheap(jsonDecode(data["cheap"]));
      cleanExpensive(jsonDecode(data["expensive"]));

      setState(() => isLoading = false);
      setState(() => isDataLoaded = true);
    } else {
      setState(() => isLoading = true);
    }
  }

  void toggleGrid() => setState(() => isGridOff = !isGridOff);

  Future<void> showNetworkDialog(BuildContext context, storeProvider) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Please check your Network'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'An internet connection is required for this app, please make sure you are'
                  ' connected to a network and try again',
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
                'Retry',
                style: TextStyle(color: kBgFoschini),
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                if (await TestConnection.checkForConnection()) {
                  storeProvider.getItems();
                } else {
                  showNetworkDialog(context, storeProvider);
                }
              },
            ),
          ],
        );
      },
    );
  }

  void testConnection(storeProvider) async {
    if (await TestConnection.checkForConnection()) {
      await Future.delayed(Duration(seconds: 15));
      if (storeProvider.data == null) {
        setState(() {
          isLoading = true;
        });
        await storeProvider.getItems();
        setState(() {
          isLoading = false;
        });
      }
    } else {
      await showNetworkDialog(context, storeProvider);
    }
  }

  void cleanExpensive(List<dynamic> items) {
    for (var i in items) {
      List<DateTime> tempDateList = [];

      List<dynamic> datesList = i[i.keys.elementAt(0).toString()]['dates'];

      for (var dateString in datesList) {
        tempDateList.add((DateTime.parse(dateString)));
      }

      ProductItem _productItem = ProductItem(
          i[i.keys.elementAt(0).toString()]['image_url'],
          i[i.keys.elementAt(0).toString()]['prices_list'],
          tempDateList,
          i.keys.elementAt(0).toString(),
          i[i.keys.elementAt(0).toString()]['change']);

      expensive.add(_productItem);
    }

    setState(() {});
  }

  void cleanCheap(List<dynamic> items) {
    for (var i in items) {
      List<DateTime> tempDateList = [];

      List<dynamic> datesList = i[i.keys.elementAt(0).toString()]['dates'];

      for (var dateString in datesList) {
        tempDateList.add((DateTime.parse(dateString)));
      }

      ProductItem _productItem = ProductItem(
          i[i.keys.elementAt(0).toString()]['image_url'],
          i[i.keys.elementAt(0).toString()]['prices_list'],
          tempDateList,
          i.keys.elementAt(0).toString(),
          i[i.keys.elementAt(0).toString()]['change']);

      cheap.add(_productItem);
    }

    setState(() {});
  }

  Future<void> getDataOnRefresh(storeProvider) async {
    if (await TestConnection.checkForConnection()) {
      print('refreshing');
      setState(() => isLoading = true);
      setState(() => isDataLoaded = false);

      await storeProvider.getItems();

      cheap = [];
      expensive = [];
      allProducts = [];

      data = storeProvider.data;

      print(data);
      print(isDataLoaded);

      cleanCheap(jsonDecode(data["cheap"]));
      cleanExpensive(jsonDecode(data["expensive"]));

      setState(() => isLoading = false);
      setState(() => isDataLoaded = true);
    } else {
      showNetworkDialog(context, storeProvider);
    }
  }
}
