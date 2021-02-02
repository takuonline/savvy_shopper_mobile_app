import 'package:e_grocery/src/components/graph_page_components.dart';
import 'package:e_grocery/src/components/product_item.dart';
import 'package:e_grocery/src/networking/accessories/computermania_data.dart';
import 'package:e_grocery/src/networking/accessories/hifi_data.dart';
import 'package:e_grocery/src/networking/accessories/takealot_data.dart';
import 'package:e_grocery/src/providers/accessories/computermania_product_provider.dart';
import 'package:e_grocery/src/providers/accessories/hifi_product_provider.dart';
import 'package:e_grocery/src/providers/accessories/takealot_product_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:string_similarity/string_similarity.dart';

class AccessoriesGraphRecommendations {
  static Future<Map> getRecommendations(
      BuildContext context, String productTitle) async {
    List<String> takealotList =
        Provider.of<TakealotAllProductList>(context, listen: false).titles;


    List<String> hifiList =
        Provider.of<HifiAllProductList>(context, listen: false).titles;

    List<String> computermaniaList =
        Provider.of<ComputermaniaAllProductList>(context, listen: false).titles;

    try {
      Future<List<ProductItem>> resultTakealot = runBestMatchHelper(
        takealotList,
        3,
        TakealotData(),
        context,
        productTitle,
      );

      Future<List<ProductItem>> resultHifi = runBestMatchHelper(
        hifiList,
        3,
        HifiData(),
        context,
        productTitle,
      );

      Future<List<ProductItem>> resultComputermania = runBestMatchHelper(
        computermaniaList,
        3,
        ComputermaniaData(),
        context,
        productTitle,
      );

      return {
        "takealot": resultTakealot,
        "hifi": resultHifi,
        "computermania": resultComputermania,
      };
    } catch (e) {
      print(e);
    }
  }

  static Future<List<ProductItem>> runBestMatchHelper(
      List<String> listOfProducts,
      int num,
      networkData,
      context,
      productTitle) async {
    List<ProductItem> finalStoreProductItems = [];
    List<String> bestMatchResults =
        runBestMatch(listOfProducts, num, productTitle);

    try {
      for (String i in bestMatchResults) {
        ProductItem result = await RecommendationDataGetProduct.getProduct(
            i, context, networkData);
        finalStoreProductItems.add(result);
      }
      return finalStoreProductItems;
    } catch (e) {
      print(e);
      print(
          "error above is in run best mathcer $networkData ---  ${listOfProducts.length}   ");
      return finalStoreProductItems;
    }
  }

  static List<String> runBestMatch(
      List<String> storeList, int num, String title) {
    List<String> resultsList = [];

    for (int i = 0; i < num; i++) {
      BestMatch results = title.bestMatch(storeList);
      resultsList.add((results.bestMatch.target));
      storeList.removeAt(results.bestMatchIndex);
    }

    return resultsList;
  }
}
