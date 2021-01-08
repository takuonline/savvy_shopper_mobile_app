import 'dart:convert';
import 'dart:math';
import 'package:e_grocery/src/networking/connection_test.dart';
import 'package:e_grocery/src/networking/pnp_data.dart';
import 'package:e_grocery/src/networking/woolies_data.dart';
import 'package:e_grocery/src/pages/groceries_product_graph/pnp_product_graph.dart';
import 'package:e_grocery/src/pages/groceries_product_graph/woolies_product_graph.dart';
import 'package:string_similarity/string_similarity.dart';

import 'package:e_grocery/src/components/graph_page_components.dart';
import 'package:e_grocery/src/components/product_item.dart';
import 'package:e_grocery/src/constants/constants.dart';
import 'package:e_grocery/src/providers/all_grocery_store_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ShopriteProductGraph extends StatefulWidget {
  static const id = "shoprite-product-graph";

  ProductItem productItem;

  ShopriteProductGraph({this.productItem});

  @override
  _ShopriteProductGraphState createState() => _ShopriteProductGraphState();
}

class _ShopriteProductGraphState extends State<ShopriteProductGraph> {
  List<String> finalPnPProducts = [];
  List finalPnPProductItems = [];

  List<String> finalWooliesProducts = [];
  List finalWooliesProductItems = [];

  bool _isLoadingRecommendations = false;

  final _nullImageUrl =
      'https://www.shoprite.co.za/medias/Food-min.webp?context=bWFzdGVyfHJvb3R8MTE2MDJ8aW1hZ2Uvd2VicHxoZGUvaDI1Lzg5OTgyNTE5MjE0Mzgud2VicHw4MzAyOGFmMTU0NmEwMmUwOWYwYjU2MTJhMzUzMWVhZWRlMWQ2ODg5NTRhZDIzODMwYTcxN2U1ODRhNGU2ZGZj';

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
    double gridCardBorderRadius = 10;
    final screenHeight10p =
        screenHeight * (10 / MediaQuery.of(context).size.height);
    final screenWidth10p =
        screenWidth * (10 / MediaQuery.of(context).size.width);
    ;
    return Container(
      child: Scaffold(
//      appBar: AppBar(
//        title: Text("${widget.productItem.title}"),
//      ),
        body: Container(
          color: kShopriteSecondary,
          child: Stack(
            children: [
//              Positioned(
//                top: 0,
//                left: 0,
//                child: Row(
//                  children: [
//                    Expanded(
//                      child: Container(
//                        alignment: Alignment.center,
//                        height: screenHeight*.4,
//                        decoration: BoxDecoration(
//                          color: kBgShoprite,
//                          borderRadius: BorderRadius.circular(20)
//                        ),
//                      ),
//                    ),
//
//                    Expanded(child: Container())
//                  ],
//                ),
//              ),

              ListView(
                children: [
                  SizedBox(
                    height: screenHeight10p * 4,
                  ),
                  Stack(
                    children: [
                      Center(
                        child: Container(
                          width: screenWidth * .8,
                          height: screenHeight * .35,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenHeight10p * 1.5),
                            child: Image.network(
                              widget.productItem.imageUrl ?? _nullImageUrl,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: screenWidth10p * 2,
                        top: 0,
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.orange),
                          width: screenWidth10p * 4.5,
                          height: screenHeight10p * 4.5,
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.black,
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
                    margin: EdgeInsets.symmetric(
                        horizontal: screenHeight10p * 1.5),
                    decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(
                        screenHeight10p * 5)),
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
                          borderRadius: BorderRadius.circular(screenHeight10p *
                              2),
                          color: Colors.orange,
                        ),
                        child: SfCartesianChart(
                          plotAreaBorderWidth: 0,
                          crosshairBehavior: CrosshairBehavior(
                            enable: true,
                          ),
//borderColor: Colors.blue,

                          palette: [
//                      Colors.black,
                            kBgShoprite
                          ],
                          //set type for x and y axis
                          primaryXAxis: DateTimeAxis(
                            majorGridLines: MajorGridLines(
                                color: Colors.blue,
                                width: 0
                            )
                            , labelStyle: TextStyle(
                              color: Colors.black
                          )
                            ,
                            title: AxisTitle(

                                text: 'Date',
                                textStyle: TextStyle(
                                    color: Colors.black
                                )
                            ),
                            intervalType: DateTimeIntervalType.days,
                          ),
                          primaryYAxis: NumericAxis(
                            labelStyle: TextStyle(
                                color: Colors.black
                            ), majorGridLines: MajorGridLines(
                              color: Colors.yellow.withOpacity(.2),
                              width: 1
                          ),
                            title: AxisTitle(
                                text: 'Price',
                                textStyle: TextStyle(
                                    color: Colors.black
                                )

                            ),

//                        labelFormat: 'R{value}'
//                    interval: 4
                          ),
                          //give chart title
                          title: ChartTitle(text: widget.productItem.title),
                          onMarkerRender: (args) {
//                      args.
                          },
                          legend: Legend(overflowMode: LegendItemOverflowMode
                              .wrap),
                          tooltipBehavior: TooltipBehavior(enable: true),
                          backgroundColor: Colors.orangeAccent,

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
                            onTap: () =>
                                Provider.of<AllGroceryStoresData>(
                                    context, listen: false).getAllStoresData(),
                            child: MaxMinCard(
//                        widget: widget,
                              priceValue: widget.productItem.prices.map((e) =>
                                  double.parse(e.toString())).toList().reduce(
                                  max) ?? 0,
                              title: "Max",
                              bgColor: Colors.orange,
                              textColor: Colors.black87,
                              headerColor: kBgShoprite.withOpacity(.6),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => getRecommendations(),
                            child: MaxMinCard(
//                      widget: widget,
                              priceValue: widget.productItem.prices.map((e) =>
                                  double.parse(e.toString())).toList().reduce(
                                  min) ?? 0,
                              title: "Min",
                              bgColor: Colors.orange,
                              textColor: Colors.black87,
                              headerColor: kBgShoprite.withOpacity(.6),
                            ),
                          ),
                          MaxMinCard(
//                      widget: widget,
                            priceValue: (widget.productItem.prices.map((e) =>
                                double.parse(e.toString())).reduce((a, b) =>
                            a + b) / widget.productItem.prices.length)
                                .roundToDouble() ?? 0,
                            title: "Avg",
                            bgColor: Colors.orange,
                            textColor: Colors.black87,
                            headerColor: kBgShoprite.withOpacity(.6),
                          ),

                        ]
                    ),
                  ),

                  SizedBox(
                    height: screenHeight10p * 3,
                  ),
                  CurrentPriceCard(

                      bgColor: Colors.orange,
                      textColor: Colors.black87,
                      headerColor: kBgShoprite.withOpacity(.6),
                      priceValue: widget.productItem.prices.last

                  ),

                  SizedBox(
                    height: 3 * screenHeight10p,
                  ),

                  if(_isLoadingRecommendations) Center(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: screenHeight10p * 3),
                      child: CircularProgressIndicator(

                      ),
                    ),
                  ),

                  if (finalPnPProductItems.isNotEmpty) RecommendationStoreName(
                      color: kBgPnP,
                      title: "Pick n Pay"

                  ),

                  if (finalWooliesProductItems.isNotEmpty) Container(
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
                                finalPnPProductItems: finalPnPProductItems,
                                nullImageUrl: _nullImageUrl,
                                index: index

                            ),
                          );
                        },


                      )

                  ),

                  if (finalPnPProductItems.isNotEmpty) SizedBox(
                    height: 5 * screenHeight10p,
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

                  if (finalWooliesProductItems.isNotEmpty) SizedBox(
                    height: 5 * screenHeight10p,
                  ),
                ],
              ),
            ],
          ),),
      ),);
  }


  Future<void> getRecommendations() async {
    setState(() {
      _isLoadingRecommendations = true;
    });

    Map<String, dynamic> data = Provider
        .of<AllGroceryStoresData>(context, listen: false)
        .data;
    List<String> pnpList = Provider.of<AllGroceryStoresData>(
        context, listen: false).getStoreProductNameList(data['pnp'], context);
    List<String> wooliesList = Provider.of<AllGroceryStoresData>(
        context, listen: false).getStoreProductNameList(
        data['woolies'], context);

    finalPnPProductItems = [];
    finalWooliesProducts = [];
    try {
      runBestMatch(pnpList, finalPnPProducts, 3, widget.productItem.title);
      PnPData _pnpNetworkData = PnPData();

      for (String i in finalPnPProducts) {
        ProductItem result = await RecommendationDataGetProduct.getProduct(
            i, context, _pnpNetworkData);
        setState(() {
          finalPnPProductItems.add(result);
        });
      }
      print(finalPnPProductItems);
      setState(() {});


      ////////////////////////////// woolies  ////////////////////////////////

      runBestMatch(
          wooliesList, finalWooliesProducts, 3, widget.productItem.title);
      WooliesData _wooliesNetworkData = WooliesData();

      for (String i in finalWooliesProducts) {
        WooliesProductItem resultWoolies = await RecommendationDataGetProduct
            .getProductNoImage(i, context, _wooliesNetworkData);
        setState(() {
          finalWooliesProductItems.add(resultWoolies);
        });
      }
      print(finalWooliesProductItems);
      setState(() {});

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


  static void runBestMatch(List<String> storeList, List<String> resultsList,
      int num, String title) {
    for (int i = 0; i < num; i++) {
      BestMatch results = title.bestMatch(storeList);
      resultsList.add((results.bestMatch.target));
      storeList.removeAt(results.bestMatchIndex);
    }

    print(resultsList);
  }


}







