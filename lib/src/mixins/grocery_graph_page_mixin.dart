import 'package:e_grocery/src/components/graph_page_components.dart';
import 'package:e_grocery/src/providers/grocery/pnp_product_provider.dart';
import 'package:e_grocery/src/providers/grocery/shoprite_product_provider.dart';
import 'package:e_grocery/src/providers/grocery/woolies_product_provider.dart';
import 'package:e_grocery/src/services/grocery_services/get_graph_page_recommendations_groceries.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

mixin GroceryGraphPageMixin<T extends StatefulWidget> on State<T> {
  bool isLoadingRecommendations = false;
  List finalPnPProductItems = [];
  List finalShopriteProductItems = [];
  List finalWooliesProductItems = [];

  final nullImageUrl =
      'https://play-lh.googleusercontent.com/tTcm_kToEtUvXdVGytgjB2Lc-qQiNo5fxcagB7c7MX_UJsO43OFKkeOJOZZiOL1VO6c=s180-rw';

  Future<void> getProductData() async {
    Provider.of<ShopriteAllProductList>(context, listen: false).getItems();
    Provider.of<PnPAllProductList>(context, listen: false).getItems();
    Provider.of<WooliesAllProductList>(context, listen: false).getItems();
  }

  List<ProductData> getData(productItem) {
    List<ProductData> temp = [];
    for (int i = 0; i < productItem.prices.length; i++) {
      temp.add(ProductData(productItem.dates[i], productItem.prices[i]));
    }
    return temp;
  }

  Future<void> onRefresh(String productItemTitle) async {
    print("is getting data");
    setState(() {
      isLoadingRecommendations = true;
    });
    try {
      Map dataMap =
          await GetGraphPageRecommendationGroceries.getRecommendations(
              context, productItemTitle);

      finalPnPProductItems = await dataMap['pnp'];
      finalShopriteProductItems = await dataMap['shoprite'];
      finalWooliesProductItems = await dataMap['woolies'];
      setState(() {});

      setState(() {
        isLoadingRecommendations = false;
      });
    } on NoSuchMethodError {
      print("noooooooooooo such  methoddddddddddddddddd  in refreshing data ");

//      setState(() {
//        _isLoadingRecommendations = true;
//      });
//      _getProductData();
////      WidgetsBinding.instance.addPostFrameCallback((_) async{
//
//      Map dataMap = await GetGraphPageRecommendationGroceries
//          .getRecommendations(
//          context, widget.productItem.title);
//
//      finalPnPProductItems = dataMap['pnp'];
//      finalShopriteProductItems = dataMap['shoprite'];
//      finalWooliesProductItems = dataMap['woolies'];
//      setState(() {});

      setState(() {
        isLoadingRecommendations = false;
      });
    } on RangeError {
      print("range errrrrrrrrrrrrrrrrrrrror in refreshing data");
//      setState(() {
//        _isLoadingRecommendations = true;
//      });
//
//      _getProductData();
//
//      Map dataMap = await GetGraphPageRecommendationGroceries
//          .getRecommendations(
//          context, widget.productItem.title);
//
//      finalPnPProductItems = dataMap['pnp'];
//      finalShopriteProductItems = dataMap['shoprite'];
//      finalWooliesProductItems = dataMap['woolies'];
//      setState(() {});

      setState(() {
        isLoadingRecommendations = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        isLoadingRecommendations = false;
      });
    }
  }

  List<ProductData> processData(productItem) {
    List<ProductData> temp = [];
    for (int i = 0; i < productItem.prices.length; i++) {
      temp.add(ProductData(productItem.dates[i], productItem.prices[i]));
    }
    return temp;
  }
}
