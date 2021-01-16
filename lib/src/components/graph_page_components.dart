import 'dart:convert';

import 'package:e_grocery/src/components/product_item.dart';
import 'package:e_grocery/src/networking/connection_test.dart';
import 'package:e_grocery/src/networking/pnp_data.dart';
import 'package:e_grocery/src/networking/shoprite_data.dart';
import 'package:e_grocery/src/networking/woolies_data.dart';
import 'package:e_grocery/src/pages/clothing/foschini_product_graph.dart';
import 'package:e_grocery/src/pages/clothing/woolworths_clothing_product_graph.dart';
import 'package:e_grocery/src/providers/pnp_product_name_provider.dart';
import 'package:e_grocery/src/providers/pnp_product_provider.dart';
import 'package:e_grocery/src/providers/shoprite_product_name_provider.dart';
import 'package:e_grocery/src/providers/shoprite_product_provider.dart';
import 'package:e_grocery/src/providers/woolies_product_name_provider.dart';
import 'package:e_grocery/src/providers/woolies_product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:string_similarity/string_similarity.dart';

class GraphGetRecommendation {
  static Future<Map> getRecommendations(
      BuildContext context,

// List<String>  finalPnPProducts ,
//      List finalPnPProductItems ,
//      List<String> finalShopriteProducts ,
//      List finalShopriteProductItems ,
//      List<String> finalWooliesProducts ,
//      List finalWooliesProductItems ,
      String productTitle) async {
//    finalPnPProductItems = [];
//    finalPnPProducts = [];
//
//    finalWooliesProducts = [];
//    finalWooliesProductItems = [];
//
//    finalShopriteProducts = [];
//    finalShopriteProductItems = [];

    var dataPnP = Provider.of<PnPAllProductList>(context, listen: false).data;
    Provider.of<PnPProductNameList>(context, listen: false)
        .getProductNameList(dataPnP, context);
    List<String> pnpList =
        Provider.of<PnPProductNameList>(context, listen: false).titles;

    var dataShoprite =
        Provider.of<ShopriteAllProductList>(context, listen: false).data;
    Provider.of<ShopriteProductNameList>(context, listen: false)
        .getProductNameList(dataShoprite, context);
    List<String> shopriteList =
        Provider.of<ShopriteProductNameList>(context, listen: false).titles;

    var dataWoolies =
        Provider.of<WooliesAllProductList>(context, listen: false).data;
    Provider.of<WooliesProductNameList>(context, listen: false)
        .getProductNameList(dataWoolies, context);
    List<String> wooliesList =
        Provider.of<WooliesProductNameList>(context, listen: false).titles;

/////////

//    var dataWoolies =
//        Provider.of<WooliesAllProductList>(context, listen: false).data;
//    List<String> wooliesList = Provider.of<PnPProductNameList>(
//        context, listen: false).getProductNameList(
//        data['woolies'], context);
//    List<String> shopriteList = Provider.of<AllGroceryStoresData>(
//        context, listen: false).getStoreProductNameList(
//        data['shoprite'], context);

    try {
      ////////////////////////////// shoprite  ////////////////////////////////
//      runBestMatch(shopriteList, finalShopriteProducts, 3, widget.productItem.title);
//      ShopriteData _pnpNetworkData = ShopriteData();
//
//      for (String i in finalShopriteProducts) {
//        ProductItem result = await RecommendationDataGetProduct.getProduct(
//            i, context, _pnpNetworkData);
//        setState(() {
//          finalShopriteProductItems.add(result);
//        });
//      }

      Future<List<ProductItem>> resultShoprite = runBestMatchHelper(
        shopriteList,
        3,
        ShopriteData(),
        context,
        productTitle,
      );

      ////////////////////////////// pnp  ////////////////////////////////

//      runBestMatch(pnpList, finalPnPProducts, 3, widget.productItem.title);
//      PnPData _pnpNetworkData = PnPData();
//
//      for (String i in finalPnPProducts) {
//        ProductItem result = await RecommendationDataGetProduct.getProduct(
//            i, context, _pnpNetworkData);
//        setState(() {
//          finalPnPProductItems.add(result);
//        });
//      }
//      print(finalPnPProductItems);
//      setState(() {});

      Future<List<ProductItem>> resultPnP = runBestMatchHelper(
        pnpList,
        3,
        PnPData(),
        context,
        productTitle,
      );

      ////////////////////////////// woolies  ////////////////////////////////

//      runBestMatch(
//          wooliesList, finalWooliesProducts, 3, widget.productItem.title);
//      WooliesData _wooliesNetworkData = WooliesData();
//
//      for (String i in finalWooliesProducts) {
//        WooliesProductItem resultWoolies = await RecommendationDataGetProduct
//            .getProductNoImage(i, context, _wooliesNetworkData);
//        setState(() {
//          finalWooliesProductItems.add(resultWoolies);
//        });
//      }
//      print(finalWooliesProductItems);
//      setState(() {});

      Future<List<WooliesProductItem>> resultWoolies =
          runBestMatchHelperNoImage(
              wooliesList, 3, WooliesData(), context, productTitle);

//
//    } on NoSuchMethodError {
//      setState(() {
//        _isLoadingRecommendations = false;
//      });
//      print("noooooooooooo such  methoddddddddddddddddd in get recommendations ");
//
//    } catch (e) {
//      print(e);
//      setState(() => _isLoadingRecommendations = false);

      return {
        "shoprite": resultShoprite,
        "pnp": resultPnP,
        "woolies": resultWoolies,
      };
    } catch (e) {
      print(e);
    }
  }

//  static  Future<List<ProductItem>> runAll(
//      List<String> listOfProducts,
//      int num,
//      networkData,
//      BuildContext context,
//     String productTitle)async{
//
//  return await runBestMatchHelper(
//        listOfProducts,
//        num,
//        networkData,
//        context,
//        productTitle);
//
//  }

//  static Future<List<WooliesProductItem>> runAllNoImage(
//      List<String> listOfProducts,
//      int num,
//      networkData,
//      BuildContext context,
//      String productTitle)async{
//
//    return await runBestMatchHelperNoImage(
//        listOfProducts,
//        num,
//        networkData,
//        context,
//        productTitle);
//
//  }

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

class RecommendationListViewBuilderNoImage extends StatelessWidget {
  const RecommendationListViewBuilderNoImage({
    Key key,
    @required this.finalStoreProductItems,
    @required String nullImageUrl,
  })  : _nullImageUrl = nullImageUrl,
        super(key: key);

  final List finalStoreProductItems;
  final String _nullImageUrl;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenHeight10p =
        screenHeight * (10 / MediaQuery.of(context).size.height);
    final screenWidth10p =
        screenWidth * (10 / MediaQuery.of(context).size.width);
    return Container(
        height: screenHeight * .19,
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: finalStoreProductItems.length,
          itemBuilder: (_, index) {
            return GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WoolworthsClothingProductGraph(
                      productItem: finalStoreProductItems[index]),
                ),
              ),
              child: RecommendationProductCardNoImage(
                  finalPnPProductItems: finalStoreProductItems,
                  nullImageUrl: _nullImageUrl,
                  index: index),
            );
          },
        ));
  }
}

class RecommendationListViewBuilder extends StatelessWidget {
  const RecommendationListViewBuilder({
    Key key,
    @required this.finalStoreProductItems,
//    @required this.graphPage,
    @required String nullImageUrl,
  })  : _nullImageUrl = nullImageUrl,
        super(key: key);

  final List finalStoreProductItems;
  final String _nullImageUrl;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenHeight10p =
        screenHeight * (10 / MediaQuery.of(context).size.height);
    final screenWidth10p =
        screenWidth * (10 / MediaQuery.of(context).size.width);
    return Container(
        height: screenHeight * .35,
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: finalStoreProductItems.length,
          itemBuilder: (_, index) {
            return GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FoschiniProductGraph(
                      productItem: finalStoreProductItems[index]),
                ),
              ),
              child: RecommendationProductCard(
                  finalStoreProductItems: finalStoreProductItems,
                  nullImageUrl: _nullImageUrl,
                  index: index),
            );
          },
        ));
  }
}

class RecommendationDataGetProduct {
  static Future<ProductItem> getProduct(
      String result, BuildContext context, networkData) async {
    if (result != null) {
      if (await TestConnection.checkForConnection()) {
        dynamic response = await networkData.getSingleProductData(result);
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

        return _parsedProductItem;

//        Navigator.push(
//          context,
//          MaterialPageRoute(
//            builder: (context) =>
//                ShopriteProductGraph(
//                    productItem:
//                    _parsedProductItem),
//          ),
//        );
      } else {
        await TestConnection.showNoNetworkDialog(context);
      }
    }
  }

  static Future<WooliesProductItem> getProductNoImage(
      String result, BuildContext context, networkData) async {
    if (result != null) {
      if (await TestConnection.checkForConnection()) {
        dynamic response = await networkData.getSingleProductData(result);
        dynamic parsedResponse = jsonDecode(response);

        List<DateTime> tempDateList = [];

        List<dynamic> datesList =
            parsedResponse[parsedResponse.keys.elementAt(0).toString()]
                ['dates'];

        for (var dateString in datesList) {
          tempDateList.add((DateTime.parse(dateString)));
        }

        WooliesProductItem _parsedProductItem = WooliesProductItem(
//            parsedResponse[parsedResponse.keys.elementAt(0)
//                .toString()]['image_url'],
            parsedResponse[parsedResponse.keys.elementAt(0).toString()]
                ['prices_list'],
            tempDateList,
            parsedResponse.keys.elementAt(0).toString(),
            parsedResponse[parsedResponse.keys.elementAt(0).toString()]
                ['change']);

        return _parsedProductItem;

//        Navigator.push(
//          context,
//          MaterialPageRoute(
//            builder: (context) =>
//                ShopriteProductGraph(
//                    productItem:
//                    _parsedProductItem),
//          ),
//        );
      } else {
        await TestConnection.showNoNetworkDialog(context);
      }
    }
  }
}

class MaxMinCard extends StatelessWidget {
  final String title;

  final double priceValue;

  final Color headerColor;
  final Color textColor;
  final Color bgColor;

  MaxMinCard(
      {this.title,
      this.priceValue,
      this.headerColor,
      this.textColor,
      this.bgColor});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final screenHeight10p =
        screenHeight * (10 / MediaQuery.of(context).size.height);
    final screenWidth10p =
        screenWidth * (10 / MediaQuery.of(context).size.width);

    return Card(
      color: bgColor,
      borderOnForeground: true,
      elevation: 20,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: screenWidth10p * 1.5, vertical: screenHeight10p * 2.5),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(
                  fontFamily: "Montserrat",
                  color: headerColor,
                  fontSize: screenWidth10p * 2,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: screenHeight10p,
            ),
            FittedBox(
              child: Text(
                "R$priceValue",
                style: TextStyle(
                    fontFamily: "Montserrat",
                    color: textColor,
                    fontSize: screenWidth10p * 1.5,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CurrentPriceCard extends StatelessWidget {
  final double priceValue;
  final Color headerColor;
  final Color textColor;
  final Color bgColor;

  const CurrentPriceCard(
      {this.priceValue, this.headerColor, this.textColor, this.bgColor});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    double gridCardBorderRadius = 10;
    final screenHeight10p =
        screenHeight * (10 / MediaQuery.of(context).size.height);
    final screenWidth10p =
        screenWidth * (10 / MediaQuery.of(context).size.width);

    return Center(
      child: Card(
        color: bgColor,
        elevation: 20,
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth10p * 2.5,
              vertical: screenHeight10p * 2.75),
          child: Column(
            children: [
              Text(
                "Current Price",
                style: TextStyle(
                    fontFamily: "Montserrat",
                    color: headerColor,
                    fontSize: screenWidth10p * 2,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: screenHeight10p,
              ),
              FittedBox(
                child: Text(
                  "R${priceValue}",
                  style: TextStyle(
                      fontFamily: "Montserrat",
                      color: textColor,
                      fontSize: screenWidth10p * 2,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RecommendationProductCard extends StatelessWidget {
  RecommendationProductCard({
    @required this.finalStoreProductItems,
    @required this.nullImageUrl,
    @required this.index,
  });

  final List finalStoreProductItems;
  final String nullImageUrl;
  final int index;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    double gridCardBorderRadius = 10;
    final screenHeight10p =
        screenHeight * (10 / MediaQuery.of(context).size.height);
    final screenWidth10p =
        screenWidth * (10 / MediaQuery.of(context).size.width);

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Card(
        elevation: 0,
        margin: EdgeInsets.only(
          top: screenHeight * .01,
          bottom: screenHeight * .01,
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(gridCardBorderRadius)),
        color: Colors.white,
        child: Container(
          alignment: Alignment.center,
          height: screenHeight * .35,
          width: screenWidth * .4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                flex: 10,
                child: Container(
                  width: screenWidth * .35,
                  child: Center(
                    child: Image.network(
                      finalStoreProductItems[index].imageUrl ?? nullImageUrl,
                      height: screenHeight * .3,
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 10,
                child: Column(
                  children: [
                    SizedBox(
                      height: screenHeight * .015,
                    ),
                    Flexible(
                      child: FittedBox(
                        child: Text(
                          "Price:  R${finalStoreProductItems[index].prices
                              .last}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w700,
                            fontSize: screenWidth10p * 1.5,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * .013,
                    ),
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth10p * 1),
                        child: Text(
                          "${finalStoreProductItems[index].title}",
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w400,
                            fontSize: screenWidth10p * 1.2,
                          ),
                        ),
                      ),
                    ),

//                SizedBox(
//                  height: screenHeight10p*,
//                ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RecommendationProductCardNoImage extends StatelessWidget {
  RecommendationProductCardNoImage({
    @required this.finalPnPProductItems,
    @required this.nullImageUrl,
    @required this.index,
  });

  final List finalPnPProductItems;
  final String nullImageUrl;
  final int index;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    double gridCardBorderRadius = 10;
    final screenHeight10p =
        screenHeight * (10 / MediaQuery.of(context).size.height);
    final screenWidth10p =
        screenWidth * (10 / MediaQuery.of(context).size.width);

    return Card(
      elevation: 0,
      margin: EdgeInsets.only(
          top: screenHeight * .01,
          bottom: screenHeight * .01,
          left: screenWidth10p * 1.5,
          right: screenWidth10p * 1.5),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(gridCardBorderRadius)),
      color: Colors.white,
      child: Container(
        alignment: Alignment.center,
        height: screenHeight * .2,
        width: screenWidth * .4,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: screenHeight * .015,
            ),
            Flexible(
              child: FittedBox(
                child: Text(
                  "Price:  R${finalPnPProductItems[index].prices.last}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w700,
                    fontSize: screenWidth10p * 1.7,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * .015,
            ),
            Flexible(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: screenWidth10p * 1),
                child: Text(
                  "${finalPnPProductItems[index].title}",
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w400,
                    fontSize: screenWidth10p * 1.2,
                  ),
                ),
              ),
            ),

//                SizedBox(
//                  height: screenHeight10p*,
//                ),
          ],
        ),
      ),
    );
  }
}

class RecommendationStoreName extends StatelessWidget {
  const RecommendationStoreName({
    Key key,
    @required this.color,
    @required this.title,
  }) : super(key: key);

  final Color color;
  final String title;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenHeight10p =
        screenHeight * (10 / MediaQuery.of(context).size.height);
    final screenWidth10p =
        screenWidth * (10 / MediaQuery.of(context).size.width);

    return Container(
      height: 5 * screenHeight10p,
      margin: EdgeInsets.symmetric(
          horizontal: screenWidth10p * 2, vertical: screenHeight10p * 2),
      alignment: Alignment.centerLeft,
      child: FittedBox(
        child: Text(
          title,
          style: TextStyle(
            fontFamily: "Montserrat",
            color: color,
            fontSize: screenWidth10p * 3,
            fontWeight: FontWeight.w700,
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }
}


class ProductData {
  DateTime time;
  double price;
  ProductData(this.time, this.price);
}