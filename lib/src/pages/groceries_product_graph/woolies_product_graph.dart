import 'dart:math';

import 'package:e_grocery/src/components/graph_page_components.dart';
import 'package:e_grocery/src/components/product_item.dart';
import 'package:e_grocery/src/constants/constants.dart';
import 'package:e_grocery/src/pages/groceries_product_graph/pnp_product_graph.dart';
import 'package:e_grocery/src/pages/groceries_product_graph/shoprite_product_graph.dart';
import 'package:e_grocery/src/providers/pnp_product_provider.dart';
import 'package:e_grocery/src/providers/shoprite_product_provider.dart';
import 'package:e_grocery/src/providers/woolies_product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class WooliesProductGraph extends StatefulWidget {
  static const id = "woolies-product-graph";

  WooliesProductItem productItem;

  WooliesProductGraph({this.productItem});

  @override
  _WooliesProductGraphState createState() => _WooliesProductGraphState();
}

class _WooliesProductGraphState extends State<WooliesProductGraph> {
//  List<String> finalPnPProducts = [];
//  List finalPnPProductItems = [];
//
//  List<String> finalShopriteProducts = [];
//  List finalShopriteProductItems = [];

  List finalPnPProductItems = [];
  List finalShopriteProductItems = [];
  List finalWooliesProductItems = [];

  bool _isLoadingRecommendations = false;

  final _nullImageUrl =
      'https://play-lh.googleusercontent.com/tTcm_kToEtUvXdVGytgjB2Lc-qQiNo5fxcagB7c7MX_UJsO43OFKkeOJOZZiOL1VO6c=s180-rw';

  List<ProductData> _processData() {
    List<ProductData> temp = [];
    for (int i = 0; i < widget.productItem.prices.length; i++) {
      temp.add(ProductData(
          widget.productItem.dates[i], widget.productItem.prices[i]));
    }
    return temp;
  }

  Future<void> _getProductData() async {
    Provider.of<ShopriteAllProductList>(context, listen: false).getItems();

    Provider.of<PnPAllProductList>(context, listen: false).getItems();

    Provider.of<WooliesAllProductList>(context, listen: false).getItems();
  }

  @override
  void initState() {
//    if (Provider.of<AllGroceryStoresData>(context, listen: false).data ==
//        null) {
//      Provider.of<AllGroceryStoresData>(context, listen: false)
//          .getAllStoresData();
//    }

    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _onRefresh();
    });
  }

  Future<void> _onRefresh() async {
    print("is getting data");
    setState(() {
      _isLoadingRecommendations = true;
    });
    try {
      Map dataMap = await GraphGetRecommendation.getRecommendations(
          context, widget.productItem.title);

      finalPnPProductItems = await dataMap['pnp'];
      finalShopriteProductItems = await dataMap['shoprite'];
      finalWooliesProductItems = await dataMap['woolies'];
      setState(() {});

      setState(() {
        _isLoadingRecommendations = false;
      });
    } on NoSuchMethodError {
      print("noooooooooooo such  methoddddddddddddddddd  in refreshing data ");

      setState(() {
        _isLoadingRecommendations = true;
      });
      _getProductData();
//      WidgetsBinding.instance.addPostFrameCallback((_) async{

      Map dataMap = await GraphGetRecommendation.getRecommendations(
          context, widget.productItem.title);

      finalPnPProductItems = await dataMap['pnp'];
      finalShopriteProductItems = await dataMap['shoprite'];
      finalWooliesProductItems = await dataMap['woolies'];
      setState(() {});

      setState(() {
        _isLoadingRecommendations = false;
      });
    } on RangeError {
      print("range errrrrrrrrrrrrrrrrrrrror in refreshing data");
      setState(() {
        _isLoadingRecommendations = true;
      });

      _getProductData();

      Map dataMap = await GraphGetRecommendation.getRecommendations(
          context, widget.productItem.title);

      finalPnPProductItems = await dataMap['pnp'];

      finalShopriteProductItems = await dataMap['shoprite'];
      finalWooliesProductItems = await dataMap['woolies'];
      setState(() {});

      setState(() {
        _isLoadingRecommendations = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        _isLoadingRecommendations = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final screenHeight10p =
        screenHeight * (10 / MediaQuery.of(context).size.height);
    final screenWidth10p =
        screenWidth * (10 / MediaQuery.of(context).size.width);

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
                            dataSource: _processData(),
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
                        onLongPress: () => _getProductData(),
                        child: MaxMinCard(
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
                      MaxMinCard(
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
                  priceValue: widget.productItem.prices.last

              )
              ,
              SizedBox(
                height: 2 * screenHeight10p,
              ),


              SizedBox(
                height: 3 * screenHeight10p,
              ),

              if(_isLoadingRecommendations) Center(
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: screenHeight10p * 3),
                  child: CircularProgressIndicator(

                  ),
                ),
              ),

              if (finalShopriteProductItems
                  .isNotEmpty) RecommendationStoreName(
                  color: kBgShoprite,
                  title: "Shoprite"

              ),

              if (finalShopriteProductItems.isNotEmpty) Container(
                  height: screenHeight * .35,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: finalShopriteProductItems.length,
                    itemBuilder: (_, index) {
                      return GestureDetector(
                        onTap: () =>
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ShopriteProductGraph(
                                        productItem: finalShopriteProductItems[index]),
                              ),
                            ),
                        child: RecommendationProductCard(
                            finalStoreProductItems: finalShopriteProductItems,
                              nullImageUrl: _nullImageUrl,
                              index: index),
                      );
                    },


                  )

              ),


              if (finalWooliesProductItems
                  .isNotEmpty) RecommendationStoreName(
                  color: kBgWoolies,
                  title: "Woolworths"

              ),

              if (finalWooliesProductItems.isNotEmpty) Container(
                  height: screenHeight * .19,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: finalWooliesProductItems.length,
                    itemBuilder: (_, index) {
                      return GestureDetector(
                        onTap: () =>
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    WooliesProductGraph(
                                        productItem: finalWooliesProductItems[index]),
                              ),
                            ),
                        child: RecommendationProductCardNoImage(
                            finalPnPProductItems: finalWooliesProductItems,
                            nullImageUrl: _nullImageUrl,
                            index: index

                        ),
                      );
                    },


                  )

              ),


              if (finalPnPProductItems.isNotEmpty) RecommendationStoreName(
                  color: kBgPnP,
                  title: "Pick n Pay"

              ),

              if (finalPnPProductItems.isNotEmpty) Container(
                  height: screenHeight * .35,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: finalPnPProductItems.length,
                    itemBuilder: (_, index) {
                      return GestureDetector(
                        onTap: () =>
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PnPProductGraph(
                                        productItem: finalPnPProductItems[index]),
                              ),
                            ),
                        child: RecommendationProductCard(
                            finalStoreProductItems: finalPnPProductItems,
                            nullImageUrl: _nullImageUrl,
                            index: index

                        ),
                      );
                    },


                  )

              ),


              if (finalShopriteProductItems.isNotEmpty) SizedBox(
                height: 5 * screenHeight10p,
              ),


            ],
          ),),
        ),);
  }


//  Future<void> getRecommendations() async {
//    setState(() {
//      _isLoadingRecommendations = true;
//    });
//
//    Map<String, dynamic> data = Provider
//        .of<AllGroceryStoresData>(context, listen: false)
//        .data;
//    List<String> pnpList = Provider.of<AllGroceryStoresData>(
//        context, listen: false).getStoreProductNameList(data['pnp'], context);
//    List<String> shopriteList = Provider.of<AllGroceryStoresData>(
//        context, listen: false).getStoreProductNameList(
//        data['shoprite'], context);
//
//    finalPnPProductItems = [];
//    finalShopriteProducts = [];
//    try {
//      ////////////////////////////// Shoprite  ////////////////////////////////
//
//      runBestMatch(
//          shopriteList, finalShopriteProducts, 3, widget.productItem.title);
//      ShopriteData _shopriteNetworkData = ShopriteData();
//
//      for (String i in finalShopriteProducts) {
//        ProductItem result = await RecommendationDataGetProduct.getProduct(
//            i, context, _shopriteNetworkData);
//        setState(() {
//          finalShopriteProductItems.add(result);
//        });
//      }
//      print(finalShopriteProductItems);
//      setState(() {});
//
//////////////////////////////// pnp  ////////////////////////////////
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
//
//
//      setState(() => _isLoadingRecommendations = false);
//    } on NoSuchMethodError {
//      setState(() {
//        _isLoadingRecommendations = false;
//      });
//      print("noooooooooooo such  methoddddddddddddddddd  ");
////      Provider.of<AllGroceryStoresData>(context,listen:false).getAllStoresData();
//
//    } catch (e) {
//      print(e);
//
//      setState(() => _isLoadingRecommendations = false);
//    }
//  }


//  static void runBestMatch(List<String> storeList, List<String> resultsList,
//      int num, String title) {
//    for (int i = 0; i < num; i++) {
//      BestMatch results = title.bestMatch(storeList);
//      resultsList.add((results.bestMatch.target));
//      storeList.removeAt(results.bestMatchIndex);
//    }
//
//    print(resultsList);
//  }


}



