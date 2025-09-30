import 'package:e_grocery/src/components/graph_page_components.dart';
import 'package:e_grocery/src/networking/connection_test.dart';
import 'package:e_grocery/src/services/clothing_services/ClothingStoresProviderMethods.dart';
import 'package:e_grocery/src/services/clothing_services/get_graph_page_recommendations_clothing.dart';
import 'package:flutter/material.dart';

mixin ClothingGraphPageMixin<T extends StatefulWidget> on State<T> {
  final nullImageUrl =
      'https://play-lh.googleusercontent.com/tTcm_kToEtUvXdVGytgjB2Lc-qQiNo5fxcagB7c7MX_UJsO43OFKkeOJOZZiOL1VO6c=s180-rw';

  List finalFoschiniProductItems = [];
  List finalMarkhamProductItems = [];
  List finalSportsceneProductItems = [];
  List finalSuperbalistProductItems = [];
  List finalWoolworthsClothingProductItems = [];

  bool isLoadingRecommendations = false;

  Future<void> onRefresh(String productTitle) async {
    setState(() {
      isLoadingRecommendations = true;
    });
    try {
      Map recommendationDataMap =
          await GetGraphPageRecommendationsClothing.getRecommendations(
              context, productTitle);

      finalFoschiniProductItems = await recommendationDataMap["foschini"];
      finalMarkhamProductItems = await recommendationDataMap["markham"];
      finalSportsceneProductItems = await recommendationDataMap['sportscene'];
      finalSuperbalistProductItems = await recommendationDataMap['superbalist'];
      finalWoolworthsClothingProductItems =
          await recommendationDataMap['woolworthsClothing'];

      setState(() {
        isLoadingRecommendations = false;
      });
    } on NoSuchMethodError {
      print("noooooooooooo such  methoddddddddddddddddd  ");

//      setState(() {
//        isLoadingRecommendations = true;
//      });
//      _getProductData();
//      WidgetsBinding.instance.addPostFrameCallback((_) {
//        getRecommendations();
//      });
      setState(() {
        isLoadingRecommendations = false;
      });
    } on RangeError {
      print("range errrrrrrrrrrrrrrrrrrrror in clothing graph page mixin");
//      setState(() {
//        isLoadingRecommendations = true;
//      });
//
//      _getProductData();
//      WidgetsBinding.instance.addPostFrameCallback((_) {
//        getRecommendations();
//      });

      setState(() {
        isLoadingRecommendations = false;
      });
    } catch (e) {
      print(e);
    }
    setState(() {
      isLoadingRecommendations = false;
    });
  }

  Future<void> getProductData() async {
    if (await TestConnection.checkForConnection()) {
      ClothingStoresProviderMethods.checkNullAndGetAllProductData(context);
    } else {
      TestConnection.showNoNetworkDialog(context);
    }
  }

  List<ProductData> getData(productItem) {
    List<ProductData> temp = [];
    for (int i = 0; i < productItem.prices.length; i++) {
      temp.add(ProductData(productItem.dates[i], productItem.prices[i]));
    }
    return temp;
  }
}
