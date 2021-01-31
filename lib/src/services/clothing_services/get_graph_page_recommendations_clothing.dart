import 'package:e_grocery/src/components/graph_page_components.dart';
import 'package:e_grocery/src/components/product_item.dart';
import 'package:e_grocery/src/networking/clothing/foschini_data.dart';
import 'package:e_grocery/src/networking/clothing/markham_data.dart';
import 'package:e_grocery/src/networking/clothing/sportscene_data.dart';
import 'package:e_grocery/src/networking/clothing/superbalist_data.dart';
import 'package:e_grocery/src/networking/clothing/woolworths_clothing_data.dart';
import 'package:e_grocery/src/providers/clothing/foschini_product_provider.dart';
import 'package:e_grocery/src/providers/clothing/markham_product_provider.dart';
import 'package:e_grocery/src/providers/clothing/sportscene_product_provider.dart';
import 'package:e_grocery/src/providers/clothing/superbalist_product_provider.dart';
import 'package:e_grocery/src/providers/clothing/woolworths_clothing_product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:string_similarity/string_similarity.dart';

class GetGraphPageRecommendationsClothing {
  static Future<Map> getRecommendations(
      BuildContext context, String productTitle) async {
    ////  foschini  ///////
    List<String> foschiniList =
        Provider.of<FoschiniAllProductList>(context, listen: false).items;

    ////  markham  ///////
    List<String> markhamList =
        Provider.of<MarkhamAllProductList>(context, listen: false).items;

    //// sportscene  ///////
    List<String> sportsceneList =
        Provider.of<SportsceneAllProductList>(context, listen: false).items;

    //// superbalist  ///////
    List<String> superbalistList =
        Provider.of<SuperbalistAllProductList>(context, listen: false).items;

    //// woolworths  ///////
    List<String> woolworthsClothingList =
        Provider.of<WoolworthsClothingAllProductList>(context, listen: false)
            .items;

    try {
      Future<List<ProductItem>> resultFoschini = runBestMatchHelper(
        foschiniList,
        3,
        FoschiniData(),
        context,
        productTitle,
      );

      Future<List<ProductItem>> resultMarkham = runBestMatchHelper(
        markhamList,
        3,
        MarkhamData(),
        context,
        productTitle,
      );

      Future<List<ProductItem>> resultSportscene = runBestMatchHelper(
        sportsceneList,
        3,
        SportsceneData(),
        context,
        productTitle,
      );

      Future<List<ProductItem>> resultSuperbalist = runBestMatchHelper(
        superbalistList,
        3,
        SuperbalistData(),
        context,
        productTitle,
      );

      Future<List<WooliesProductItem>> resultWoolworthsClothing =
          runBestMatchHelperNoImage(woolworthsClothingList, 3,
              WoolworthsClothingData(), context, productTitle);

      return {
        "foschini": resultFoschini,
        "markham": resultMarkham,
        "sportscene": resultSportscene,
        "superbalist": resultSuperbalist,
        "woolworthsClothing": resultWoolworthsClothing
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
