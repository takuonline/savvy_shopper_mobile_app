import 'dart:convert';
import 'dart:math';
import 'package:e_grocery/src/networking/connection_test.dart';
import 'package:e_grocery/src/networking/pnp_data.dart';
import 'package:e_grocery/src/networking/shoprite_data.dart';
import 'package:e_grocery/src/networking/woolies_data.dart';
import 'package:e_grocery/src/pages/groceries_product_graph/pnp_product_graph.dart';
import 'package:e_grocery/src/pages/groceries_product_graph/woolies_product_graph.dart';
import 'package:e_grocery/src/providers/pnp_product_name_provider.dart';
import 'package:e_grocery/src/providers/pnp_product_provider.dart';
import 'package:e_grocery/src/providers/shoprite_product_name_provider.dart';
import 'package:e_grocery/src/providers/shoprite_product_provider.dart';
import 'package:e_grocery/src/providers/woolies_product_name_provider.dart';
import 'package:e_grocery/src/providers/woolies_product_provider.dart';
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
//  List<String> finalPnPProducts = [];
//  List finalPnPProductItems = [];
//  List<String> finalShopriteProducts = [];
//  List finalShopriteProductItems = [];
//  List<String> finalWooliesProducts = [];
//  List finalWooliesProductItems = []

  List finalPnPProductItems = [];
  List finalShopriteProductItems = [];
  List finalWooliesProductItems = [];

  bool _isLoadingRecommendations = true;

  final _nullImageUrl =
      'https://play-lh.googleusercontent.com/tTcm_kToEtUvXdVGytgjB2Lc-qQiNo5fxcagB7c7MX_UJsO43OFKkeOJOZZiOL1VO6c=s180-rw';

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
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _onRefresh();
    });
  }

  Future<void> _getProductData() async {
    Provider.of<ShopriteAllProductList>(context, listen: false).getItems();

    Provider.of<PnPAllProductList>(context, listen: false).getItems();

    Provider.of<WooliesAllProductList>(context, listen: false).getItems();
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

//      });
      setState(() {
        _isLoadingRecommendations = false;
      });
    } on RangeError {
      print("range errrrrrrrrrrrrrrrrrrrror in refreshing data");
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

//      });

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
    double gridCardBorderRadius = 10;
    final screenHeight10p =
        screenHeight * (10 / MediaQuery.of(context).size.height);
    final screenWidth10p =
        screenWidth * (10 / MediaQuery.of(context).size.width);

    return RefreshIndicator(
      onRefresh: () => _onRefresh(),
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
                            onLongPress: () {
                              _getProductData();
                            },
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

                          MaxMinCard(
//                      widget: widget,
                            priceValue: widget.productItem.prices.map((e) =>
                                double.parse(e.toString())).toList().reduce(
                                min) ?? 0,
                            title: "Min",
                            bgColor: Colors.orange,
                            textColor: Colors.black87,
                            headerColor: kBgShoprite.withOpacity(.6),
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
                                finalPnPProductItems: finalPnPProductItems,
                                nullImageUrl: _nullImageUrl,
                                index: index

                            ),
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

                  if (finalShopriteProductItems
                      .isNotEmpty) RecommendationStoreName(
                      color: kBgShoprite,
                      title: "Shoprite"
                  ),

                  if (finalShopriteProductItems.isNotEmpty)
                    Container(
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
                                  finalPnPProductItems: finalShopriteProductItems,
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
      ),
    );
  }










}







