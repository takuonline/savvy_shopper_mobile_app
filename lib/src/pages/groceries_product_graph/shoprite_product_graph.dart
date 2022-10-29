import 'dart:math';

import 'package:e_grocery/src/components/graph_page_components.dart';
import 'package:e_grocery/src/components/product_item.dart';
import 'package:e_grocery/src/constants/constants.dart';
import 'package:e_grocery/src/mixins/grocery_graph_page_mixin.dart';
import 'package:e_grocery/src/pages/groceries_product_graph/pnp_product_graph.dart';
import 'package:e_grocery/src/pages/groceries_product_graph/woolies_product_graph.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ShopriteProductGraph extends StatefulWidget {
  static const id = "shoprite-product-graph";

  ProductItem productItem;

  ShopriteProductGraph({this.productItem});

  @override
  _ShopriteProductGraphState createState() => _ShopriteProductGraphState();
}

class _ShopriteProductGraphState extends State<ShopriteProductGraph>
    with GroceryGraphPageMixin {
  @override
  void initState() {
    super.initState();
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
    double gridCardBorderRadius = 10;
    final screenHeight10p =
        screenHeight * (10 / MediaQuery.of(context).size.height);
    final screenWidth10p =
        screenWidth * (10 / MediaQuery.of(context).size.width);

    return RefreshIndicator(
      onRefresh: () => onRefresh(widget.productItem.title),
      child: Scaffold(
        body: Container(
          color: kShopriteSecondary,
          child: Stack(
            children: [
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
                              widget.productItem.imageUrl ?? nullImageUrl,
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
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: screenHeight10p * 1.5),
                    decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(screenHeight10p * 5)),
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
                            majorGridLines:
                                MajorGridLines(color: Colors.blue, width: 0),
                            labelStyle: TextStyle(color: Colors.black),
                            title: AxisTitle(
                                text: 'Date',
                                textStyle: TextStyle(color: Colors.black)),
                            intervalType: DateTimeIntervalType.days,
                          ),
                          primaryYAxis: NumericAxis(
                            labelStyle: TextStyle(color: Colors.black),
                            majorGridLines: MajorGridLines(
                                color: Colors.yellow.withOpacity(.2), width: 1),
                            title: AxisTitle(
                                text: 'Price',
                                textStyle: TextStyle(color: Colors.black)),

//                        labelFormat: 'R{value}'
//                    interval: 4
                          ),
                          //give chart title
                          title: ChartTitle(text: widget.productItem.title),
                          onMarkerRender: (args) {
//                      args.
                          },
                          legend:
                              Legend(overflowMode: LegendItemOverflowMode.wrap),
                          tooltipBehavior: TooltipBehavior(enable: true),
                          backgroundColor: Colors.orangeAccent,

                          series: <LineSeries>[
                            LineSeries(
                                dataSource: getData(widget.productItem),
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
                              getProductData();
                            },
                            child: MaxMinCard(
//                        widget: widget,
                              priceValue: widget.productItem.prices
                                      .map((e) => double.parse(e.toString()))
                                      .toList()
                                      .reduce(max) ??
                                  0,
                              title: "Max",
                              bgColor: Colors.orange,
                              textColor: Colors.black87,
                              headerColor: kBgShoprite.withOpacity(.6),
                            ),
                          ),
                          MaxMinCard(
//                      widget: widget,
                            priceValue: widget.productItem.prices
                                    .map((e) => double.parse(e.toString()))
                                    .toList()
                                    .reduce(min) ??
                                0,
                            title: "Min",
                            bgColor: Colors.orange,
                            textColor: Colors.black87,
                            headerColor: kBgShoprite.withOpacity(.6),
                          ),
                          MaxMinCard(
//                      widget: widget,
                            priceValue: (widget.productItem.prices
                                            .map((e) =>
                                                double.parse(e.toString()))
                                            .reduce((a, b) => a + b) /
                                        widget.productItem.prices.length)
                                    .roundToDouble() ??
                                0,
                            title: "Avg",
                            bgColor: Colors.orange,
                            textColor: Colors.black87,
                            headerColor: kBgShoprite.withOpacity(.6),
                          ),
                        ]),
                  ),
                  SizedBox(
                    height: screenHeight10p * 3,
                  ),
                  CurrentPriceCard(
                      bgColor: Colors.orange,
                      textColor: Colors.black87,
                      headerColor: kBgShoprite.withOpacity(.6),
                      priceValue: widget.productItem.prices.last),
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
                                  finalPnPProductItems:
                                      finalWooliesProductItems,
                                  nullImageUrl: nullImageUrl,
                                  index: index),
                            );
                          },
                        )),
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
                    SizedBox(
                      height: 5 * screenHeight10p,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
