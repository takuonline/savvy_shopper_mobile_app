import 'package:e_grocery/src/components/graph_page_components.dart';
import 'package:e_grocery/src/components/product_item.dart';
import 'package:e_grocery/src/networking/grocery/pnp_data.dart';
import 'package:e_grocery/src/networking/grocery/shoprite_data.dart';
import 'package:e_grocery/src/networking/grocery/woolies_data.dart';
import 'package:e_grocery/src/providers/grocery/pnp_product_provider.dart';
import 'package:e_grocery/src/providers/grocery/shoprite_product_provider.dart';
import 'package:e_grocery/src/providers/grocery/woolies_product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:string_similarity/string_similarity.dart';

class GetGraphPageRecommendationGroceries {
  static Future<Map> getRecommendations(
      BuildContext context, String productTitle) async {
    List<String> pnpList =
        Provider.of<PnPAllProductList>(context, listen: false).titles;

    List<String> shopriteList =
        Provider.of<ShopriteAllProductList>(context, listen: false).titles;

    List<String> wooliesList =
        Provider.of<WooliesAllProductList>(context, listen: false).titles;

/////////

    try {
      ////////////////////////////// shoprite  ////////////////////////////////

      Future<List<ProductItem>> resultShoprite = runBestMatchHelper(
        shopriteList,
        3,
        ShopriteData(),
        context,
        productTitle,
      );

      ////////////////////////////// pnp  ////////////////////////////////

      Future<List<ProductItem>> resultPnP = runBestMatchHelper(
        pnpList,
        3,
        PnPData(),
        context,
        productTitle,
      );

      ////////////////////////////// woolies  ////////////////////////////////

      Future<List<WooliesProductItem>> resultWoolies =
          runBestMatchHelperNoImage(
              wooliesList, 3, WooliesData(), context, productTitle);

      return {
        "shoprite": resultShoprite,
        "pnp": resultPnP,
        "woolies": resultWoolies,
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

  static Future<List<WooliesProductItem>> runBestMatchHelperNoImage(
      List<String> listOfProducts,
      int num,
      networkData,
      context,
      productTitle) async {
    List<WooliesProductItem> finalStoreProductItems = [];
    List<String> bestMatchResults =
        runBestMatch(listOfProducts, num, productTitle);

    try {
      for (String i in bestMatchResults) {
        WooliesProductItem result =
            await RecommendationDataGetProduct.getProductNoImage(
                i, context, networkData);
        finalStoreProductItems.add(result);
      }

      return finalStoreProductItems;
    } catch (e) {
      print(e);
      print('above error found in run best match no image');
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
