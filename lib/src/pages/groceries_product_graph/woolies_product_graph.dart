import 'dart:math';
import 'package:e_grocery/src/components/graph_page_components.dart';
import 'package:e_grocery/src/components/product_item.dart';
import 'package:e_grocery/src/constants/constants.dart';
import 'package:e_grocery/src/mixins/grocery_graph_page_mixin.dart';
import 'package:e_grocery/src/pages/groceries_product_graph/pnp_product_graph.dart';
import 'package:e_grocery/src/pages/groceries_product_graph/shoprite_product_graph.dart';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

class WooliesProductGraph extends StatefulWidget {
  static const id = "woolies-product-graph";

  WooliesProductItem productItem;

  WooliesProductGraph({this.productItem});

  @override
  _WooliesProductGraphState createState() => _WooliesProductGraphState();
}

class _WooliesProductGraphState extends State<WooliesProductGraph>
    with GroceryGraphPageMixin {

  @override
  void initState() {
    super.initState();
//    WidgetsBinding.instance.addPostFrameCallback((_) {
//      onRefresh(widget.productItem.title);
//    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    onRefresh(widget.productItem.title);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenHeight10p =
        screenHeight * (10 / MediaQuery.of(context).size.height);
    final screenWidth10p =
        screenWidth * (10 / MediaQuery.of(context).size.width);

    return RefreshIndicator(
      onRefresh: () => onRefresh(widget.productItem.title),
      child: Container(
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
                Container(
                  margin:
                      EdgeInsets.symmetric(horizontal: screenHeight10p * 1.5),
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
                        borderRadius:
                            BorderRadius.circular(screenHeight10p * 2),
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
                        ),
                        //give chart title
                        title: ChartTitle(
                            text: widget.productItem.title,
                            textStyle: TextStyle(color: Colors.white)),
                        onMarkerRender: (args) {
//                      args.
                        },
                        legend:
                            Legend(overflowMode: LegendItemOverflowMode.wrap),
                        tooltipBehavior: TooltipBehavior(enable: true),
                        backgroundColor: Colors.black.withOpacity(1),

                        series: <LineSeries>[
                          LineSeries(
                              dataSource: processData(widget.productItem),
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
                          onLongPress: () => getProductData(),
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
                                          .map(
                                              (e) => double.parse(e.toString()))
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
                if (isLoadingRecommendations)
                  Center(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: screenHeight10p * 3),
                      child: CircularProgressIndicator(),
                    ),
                  ),
                if (finalShopriteProductItems.isNotEmpty)
                  RecommendationStoreName(
                      color: kBgShoprite, title: "Shoprite"),
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
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ShopriteProductGraph(
                                    productItem:
                                        finalShopriteProductItems[index]),
                              ),
                            ),
                            child: RecommendationProductCard(
                                finalStoreProductItems:
                                    finalShopriteProductItems,
                                nullImageUrl: nullImageUrl,
                                index: index),
                          );
                        },
                      )),
                if (finalWooliesProductItems.isNotEmpty)
                  RecommendationStoreName(
                      color: kBgWoolies, title: "Woolworths"),
                if (finalWooliesProductItems.isNotEmpty)
                  Container(
                      height: screenHeight * .19,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: finalWooliesProductItems.length,
                        itemBuilder: (_, index) {
                          return GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WooliesProductGraph(
                                    productItem:
                                        finalWooliesProductItems[index]),
                              ),
                            ),
                            child: RecommendationProductCardNoImage(
                                finalPnPProductItems: finalWooliesProductItems,
                                nullImageUrl: nullImageUrl,
                                index: index),
                          );
                        },
                      )),
                if (finalPnPProductItems.isNotEmpty)
                  RecommendationStoreName(color: kBgPnP, title: "Pick n Pay"),
                if (finalPnPProductItems.isNotEmpty)
                  Container(
                      height: screenHeight * .35,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: finalPnPProductItems.length,
                        itemBuilder: (_, index) {
                          return GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PnPProductGraph(
                                    productItem: finalPnPProductItems[index]),
                              ),
                            ),
                            child: RecommendationProductCard(
                                finalStoreProductItems: finalPnPProductItems,
                                nullImageUrl: nullImageUrl,
                                index: index),
                          );
                        },
                      )),
                if (finalShopriteProductItems.isNotEmpty)
                  SizedBox(
                    height: 5 * screenHeight10p,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
