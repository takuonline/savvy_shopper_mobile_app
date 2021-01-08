import 'dart:math';

import 'package:e_grocery/src/components/graph_page_components.dart';
import 'package:e_grocery/src/components/product_item.dart';
import 'package:e_grocery/src/constants/constants.dart';
import 'package:e_grocery/src/networking/clothing/foschini_data.dart';
import 'package:e_grocery/src/networking/clothing/markham_data.dart';
import 'package:e_grocery/src/networking/clothing/sportscene_data.dart';
import 'package:e_grocery/src/networking/clothing/superbalist_data.dart';
import 'package:e_grocery/src/pages/clothing/foschini_product_graph.dart';
import 'package:e_grocery/src/pages/groceries_product_graph/pnp_product_graph.dart';
import 'package:e_grocery/src/pages/groceries_product_graph/shoprite_product_graph.dart';
import 'package:e_grocery/src/providers/all_grocery_store_data_provider.dart';
import 'package:e_grocery/src/providers/clothing/foschini/foschini_product_name_provider.dart';
import 'package:e_grocery/src/providers/clothing/foschini/foschini_product_provider.dart';
import 'package:e_grocery/src/providers/clothing/markham/markham_product_name_provider.dart';
import 'package:e_grocery/src/providers/clothing/markham/markham_product_provider.dart';
import 'package:e_grocery/src/providers/clothing/sportscene/sportscene_product_name_provider.dart';
import 'package:e_grocery/src/providers/clothing/sportscene/sportscene_product_provider.dart';
import 'package:e_grocery/src/providers/clothing/superbalist/superbalist_product_name_provider.dart';
import 'package:e_grocery/src/providers/clothing/superbalist/superbalist_product_provider.dart';
import 'package:e_grocery/src/providers/clothing/woolworths_clothing/woolworths_clothing_product_name_provider.dart';
import 'package:e_grocery/src/providers/clothing/woolworths_clothing/woolworths_clothing_product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:string_similarity/string_similarity.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:e_grocery/src/components/graph_page_components.dart';

class WoolworthsClothingProductGraph extends StatefulWidget {
  static const id = "/woolworthsClothingProductGraph";

  WooliesProductItem productItem;

  WoolworthsClothingProductGraph({this.productItem});

  @override
  _WoolworthsClothingProductGraphState createState() =>
      _WoolworthsClothingProductGraphState();
}

class _WoolworthsClothingProductGraphState
    extends State<WoolworthsClothingProductGraph> {
  List<String> finalFoschiniProducts = [];
  List finalFoschiniProductItems = [];

  List<String> finalMarkhamProducts = [];
  List finalMarkhamProductItems = [];

  List<String> finalSportsceneProducts = [];
  List finalSportsceneProductItems = [];

  List<String> finalSuperbalistProducts = [];
  List finalSuperbalistProductItems = [];

  bool _isLoadingRecommendations = false;

  final _nullImageUrl =
      'https://play-lh.googleusercontent.com/Yax2t5F5M_G2C8mE2GbMR40WqFjNeA1_hTp6Cc2jeTCvqWVdwwr31GSmGjyFPOqxmSQ=s180-rw';

  List<ProductData> _getData() {
    List<ProductData> temp = [];
    for (int i = 0; i < widget.productItem.prices.length; i++) {
      temp.add(ProductData(
          widget.productItem.dates[i], widget.productItem.prices[i]));
    }
    return temp;
  }

  @override
  void initState() {
    if (Provider.of<AllGroceryStoresData>(context, listen: false).data ==
        null) {
      Provider.of<AllGroceryStoresData>(context, listen: false)
          .getAllStoresData();
    }

    getRecommendations();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final screenHeight10p =
        screenHeight * (10 / MediaQuery.of(context).size.height);
    final screenWidth10p =
        screenWidth * (10 / MediaQuery.of(context).size.width);
    ;
    return Container(
      child: Scaffold(
        body: Container(
          color: kWooliesSecondary.withOpacity(.3),
          child: ListView(
            children: [
              SizedBox(
                height: screenHeight10p * 4,
              ),
              Stack(
                children: [
                  Center(
                    child: Container(
                      width: screenWidth * .8,
                      height: screenHeight * .1,
//                      child: Padding(
//                        padding:  EdgeInsets.symmetric(horizontal: screenHeight10p*1.5 ),
//                        child:
//                        widget.productItem.imageUrl == _badImageUrl ? Image.network(_pnpNullImageUrl) :
//                        Image.network(
//                          widget.productItem.imageUrl ?? _pnpNullImageUrl,
//                          fit: BoxFit.contain,
//                        ),
//                      ),
                    ),
                  ),
                  Positioned(
                    left: screenWidth10p * 2,
                    top: 0,
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: kWooliesSecondary.withOpacity(.7)),
                      width: screenWidth10p * 4.5,
                      height: screenHeight10p * 4.5,
                      child: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: kBgWoolies,
                          size: screenHeight10p * 3,
                        ),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
              ),
//              Padding(
//                padding:
//                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//                child: Row(
//                  children: [
//                    GestureDetector(
//                      onTap: () => Navigator.of(context).pop(),
//                      child: Card(
//                        color: kBgShoprite.withOpacity(1),
//                        shape: RoundedRectangleBorder(
//                          borderRadius: BorderRadius.circular(5),
//                        ),
//                        elevation: 10,
//                        child: Container(
//                          height: 50,
//                          width: 50,
//                          child: Icon(
//                            Icons.arrow_back,
//                            color: Colors.white,
//                            size: 30,
//                          ),
//                        ),
//                      ),
//                    )
//                  ],
//                ),
//              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: screenHeight10p * 1.5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(screenHeight10p * 5)),
                child: Material(
                  elevation: 20,
                  borderRadius: BorderRadius.circular(screenHeight10p * 2),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: screenHeight10p,
                        vertical: screenHeight10p * 2),
                    width: screenWidth,
                    height: screenHeight * .55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(screenHeight10p * 2),
                      color: kBgWoolies,
                    ),
                    child: SfCartesianChart(
                      plotAreaBorderWidth: 0,
                      crosshairBehavior: CrosshairBehavior(
                        enable: true,
                      ),
//borderColor: Colors.blue,

                      palette: [
//                      Colors.black,
                        kWooliesSecondary
                      ],
                      //set type for x and y axis
                      primaryXAxis: DateTimeAxis(
                        majorGridLines:
                            MajorGridLines(color: Colors.blue, width: 0),
                        labelStyle: TextStyle(color: Colors.white),
                        title: AxisTitle(
                            text: 'Date',
                            textStyle: TextStyle(color: Colors.white)),
                        intervalType: DateTimeIntervalType.days,
                      ),
                      primaryYAxis: NumericAxis(
                        labelStyle: TextStyle(color: Colors.white),
                        majorGridLines: MajorGridLines(
                            color: Colors.white.withOpacity(.1), width: .5),
                        title: AxisTitle(
                            text: 'Price',
                            textStyle: TextStyle(color: Colors.white)),

//                        labelFormat: 'R{value}'
//                    interval: 4
                      ),
                      //give chart title
                      title: ChartTitle(
                          text: widget.productItem.title,
                          textStyle: TextStyle(color: Colors.white)),
                      onMarkerRender: (args) {
//                      args.
                      },
                      legend: Legend(overflowMode: LegendItemOverflowMode.wrap),
                      tooltipBehavior: TooltipBehavior(enable: true),
                      backgroundColor: Colors.black.withOpacity(1),

                      series: <LineSeries>[
                        LineSeries(
                            dataSource: _getData(),
                            xValueMapper: (product, _) => product.time,
                            yValueMapper: (product, _) => product.price,
                            // Enable data label
                            dataLabelSettings:
                                DataLabelSettings(isVisible: false))
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Provider.of<AllGroceryStoresData>(context,
                                listen: false)
                            .getAllStoresData(),
                        child: MaxMinCard(
//                        widget: widget,
                          priceValue: widget.productItem.prices
                                  .map((e) => double.parse(e.toString()))
                                  .toList()
                                  .reduce(max) ??
                              0,
                          title: "Max",
                          bgColor: kBgWoolies,
                          textColor: Colors.white,
                          headerColor: Colors.white.withOpacity(.6),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => getRecommendations(),
                        child: MaxMinCard(
//                        widget: widget,
                          priceValue: widget.productItem.prices
                                  .map((e) => double.parse(e.toString()))
                                  .toList()
                                  .reduce(min) ??
                              0,
                          title: "Min",
                          bgColor: kBgWoolies,
                          textColor: Colors.white,
                          headerColor: Colors.white.withOpacity(.6),
                        ),
                      ),
                      MaxMinCard(
//                        widget: widget,
                        priceValue: (widget.productItem.prices
                                        .map((e) => double.parse(e.toString()))
                                        .reduce((a, b) => a + b) /
                                    widget.productItem.prices.length)
                                .roundToDouble() ??
                            0,
                        title: "Avg",
                        bgColor: kBgWoolies,
                        textColor: Colors.white,
                        headerColor: Colors.white.withOpacity(.6),
                      ),
                    ]),
              ),

              SizedBox(
                height: 2 * screenHeight10p,
              ),

              CurrentPriceCard(
                  bgColor: kBgWoolies,
                  textColor: Colors.white,
                  headerColor: Colors.white.withOpacity(.6),
                  priceValue: widget.productItem.prices.last),
              SizedBox(
                height: 2 * screenHeight10p,
              ),

              SizedBox(
                height: 3 * screenHeight10p,
              ),

              if (_isLoadingRecommendations)
                Center(
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(vertical: screenHeight10p * 3),
                    child: CircularProgressIndicator(),
                  ),
                ),

              if (finalFoschiniProductItems.isNotEmpty)
                RecommendationStoreName(color: kBgFoschini, title: "Foschini"),

              if (finalFoschiniProductItems.isNotEmpty)
                Container(
                    height: screenHeight * .35,
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: finalFoschiniProductItems.length,
                      itemBuilder: (_, index) {
                        return GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FoschiniProductGraph(
                                  productItem:
                                      finalFoschiniProductItems[index]),
                            ),
                          ),
                          child: RecommendationProductCard(
                              finalPnPProductItems: finalFoschiniProductItems,
                              nullImageUrl: _nullImageUrl,
                              index: index),
                        );
                      },
                    )),

              if (finalFoschiniProductItems.isNotEmpty)
                SizedBox(
                  height: 5 * screenHeight10p,
                ),

              if (finalMarkhamProductItems.isNotEmpty)
                RecommendationStoreName(color: kBgFoschini, title: "Markham"),

              if (finalMarkhamProductItems.isNotEmpty)
                RecommendationListViewBuilder(
                  finalStoreProductItems: finalMarkhamProductItems,
                  nullImageUrl: _nullImageUrl,
                ),

              if (finalMarkhamProductItems.isNotEmpty)
                SizedBox(
                  height: 5 * screenHeight10p,
                ),

              if (finalSportsceneProductItems.isNotEmpty)
                RecommendationStoreName(
                    color: kBgFoschini, title: "Sportscene"),

              if (finalSportsceneProductItems.isNotEmpty)
                RecommendationListViewBuilder(
                  finalStoreProductItems: finalSportsceneProductItems,
                  nullImageUrl: _nullImageUrl,
                ),

              if (finalSportsceneProductItems.isNotEmpty)
                SizedBox(
                  height: 5 * screenHeight10p,
                ),

              if (finalSuperbalistProductItems.isNotEmpty)
                RecommendationStoreName(
                    color: kBgFoschini, title: "Superbalist"),

              if (finalSuperbalistProductItems.isNotEmpty)
                RecommendationListViewBuilder(
                  finalStoreProductItems: finalSuperbalistProductItems,
                  nullImageUrl: _nullImageUrl,
                ),

              if (finalSuperbalistProductItems.isNotEmpty)
                SizedBox(
                  height: 5 * screenHeight10p,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getRecommendations() async {
    print('get recomendation ');
//    setState(() {
//      _isLoadingRecommendations = true;
//    });

//    Map<String,dynamic> data =  Provider.of<AllGroceryStoresData>(context, listen: false).data;
//    List<String> shopriteList = Provider.of<AllGroceryStoresData>(context, listen: false).getStoreProductNameList(data['shoprite'], context);
//    List<String> wooliesList = Provider.of<AllGroceryStoresData>(context, listen: false).getStoreProductNameList(data['woolies'], context);
    try {
      //// foschini  ///////
//    await Provider.of<FoschiniAllProductList>(context,listen:false).getItems();
      var dataFoschini =
          Provider.of<FoschiniAllProductList>(context, listen: false).data;
      Provider.of<FoschiniProductNameList>(context, listen: false)
          .getProductNameList(dataFoschini, context);
      List<String> foschiniList =
          Provider.of<FoschiniProductNameList>(context, listen: false).items;

      ////  markham  ///////
//    await Provider.of<MarkhamAllProductList>(context,listen:false).getItems();
      var dataMarkham =
          Provider.of<MarkhamAllProductList>(context, listen: false).data;
      Provider.of<MarkhamProductNameList>(context, listen: false)
          .getProductNameList(dataMarkham, context);
      List<String> markhamList =
          Provider.of<MarkhamProductNameList>(context, listen: false).items;

      //// sportscene  ///////
//    await Provider.of<SportsceneAllProductList>(context,listen:false).getItems();
      var dataSportscene =
          Provider.of<SportsceneAllProductList>(context, listen: false).data;
      Provider.of<SportsceneProductNameList>(context, listen: false)
          .getProductNameList(dataSportscene, context);
      List<String> sportsceneList =
          Provider.of<SportsceneProductNameList>(context, listen: false).items;

      //// superbalist  ///////
//    await Provider.of<SuperbalistAllProductList>(context,listen:false).getItems();
      var dataSuperbalist =
          Provider.of<SuperbalistAllProductList>(context, listen: false).data;
      Provider.of<SuperbalistProductNameList>(context, listen: false)
          .getProductNameList(dataSuperbalist, context);
      List<String> superbalistList =
          Provider.of<SuperbalistProductNameList>(context, listen: false).items;

      //// woolworths  ///////
//    await Provider.of<WoolworthsClothingAllProductList>(context,listen:false).getItems();
      var dataWoolworthsClothing =
          Provider.of<WoolworthsClothingAllProductList>(context, listen: false)
              .data;
      Provider.of<WoolworthsClothingProductNameList>(context, listen: false)
          .getProductNameList(dataWoolworthsClothing, context);
      List<String> woolworthsClothingList =
          Provider.of<WoolworthsClothingProductNameList>(context, listen: false)
              .items;

      finalFoschiniProductItems = [];
      finalMarkhamProductItems = [];
      finalSportsceneProductItems = [];
      finalSuperbalistProductItems = [];

////////////////////////////// foschini  ////////////////////////////////
//      runBestMatch(foschiniList,finalFoschiniProducts,3,widget.productItem.title);
//      FoschiniData _foschiniNetworkData = FoschiniData();
//
//      for (String i in finalFoschiniProducts){
//        ProductItem result = await RecommendationDataGetProduct.getProduct(i, context, FoschiniData(););
//        setState(() {
//          finalFoschiniProductItems.add(result);
//        });
//      }
//      print(finalFoschiniProductItems);
//      setState(() {});

      runBestMatchHelper(
        foschiniList,
        4,
        FoschiniData(),
        finalFoschiniProducts,
        finalFoschiniProductItems,
      );

      runBestMatchHelper(
        markhamList,
        4,
        MarkhamData(),
        finalMarkhamProducts,
        finalMarkhamProductItems,
      );

      runBestMatchHelper(
        sportsceneList,
        4,
        SportsceneData(),
        finalSportsceneProducts,
        finalSportsceneProductItems,
      );

      runBestMatchHelper(
        superbalistList,
        4,
        SuperbalistData(),
        finalSuperbalistProducts,
        finalSuperbalistProductItems,
      );

//      runBestMatchHelperNoImage(
//        woolworthsClothingList,
//        4,
//        WoolworthsClothingData(),
//        finalWoolworthsClothingProducts,
//        finalWoolworthsClothingProductItems,
//      );

      setState(() {
        _isLoadingRecommendations = false;
      });
    } on NoSuchMethodError {
      setState(() {
        _isLoadingRecommendations = false;
      });
      print("noooooooooooo such  methoddddddddddddddddd  ");
//      Provider.of<AllGroceryStoresData>(context,listen:false).getAllStoresData();

    } catch (e) {
      print(e);

      setState(() => _isLoadingRecommendations = false);
    }
  }

  void runBestMatchHelper(
    List<String> listOfProducts,
    int num,
    networkData,
    finalStoreProducts,
    finalStoreProductItems,
  ) async {
    try {
      runBestMatch(
          listOfProducts, finalStoreProducts, num, widget.productItem.title);
//  FoschiniData _foschiniNetworkData = FoschiniData();

      for (String i in finalStoreProducts) {
        ProductItem result = await RecommendationDataGetProduct.getProduct(
            i, context, networkData);
        setState(() {
          finalStoreProductItems.add(result);
        });
      }
      print(finalStoreProductItems);
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  static void runBestMatch(
      List<String> storeList, List<String> resultsList, int num, String title) {
    for (int i = 0; i < num; i++) {
      BestMatch results = title.bestMatch(storeList);
      resultsList.add((results.bestMatch.target));
      storeList.removeAt(results.bestMatchIndex);
    }

    print(resultsList);
  }
}
