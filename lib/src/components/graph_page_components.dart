import 'dart:convert';

import 'package:e_grocery/src/components/product_item.dart';
import 'package:e_grocery/src/networking/connection_test.dart';
import 'package:e_grocery/src/pages/clothing/foschini_product_graph.dart';
import 'package:e_grocery/src/pages/clothing/woolworths_clothing_product_graph.dart';
import 'package:flutter/material.dart';

class ProductData {
  DateTime time;
  double price;

  ProductData(this.time, this.price);
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

//  final graphPage;

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
                  finalPnPProductItems: finalStoreProductItems,
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
        await TestConnection.showNetworkDialog(context);
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
        await TestConnection.showNetworkDialog(context);
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
                      finalPnPProductItems[index].imageUrl ?? nullImageUrl,
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
                          "Price:  R${finalPnPProductItems[index].prices.last}",
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
