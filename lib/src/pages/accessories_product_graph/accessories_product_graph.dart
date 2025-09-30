import 'dart:math';

import 'package:e_grocery/src/components/graph_page_components.dart';
import 'package:e_grocery/src/components/product_item.dart';
import 'package:e_grocery/src/constants/constants.dart';
import 'package:e_grocery/src/services/accessories_services/graph_recommendations.dart';
import 'package:e_grocery/src/services/grocery_services/grocery_stores_provider_aggregate_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class AccessoriesProductGraph extends StatefulWidget {
  static const id = "accessoriesProductgraph";

  ProductItem productItem;
  Color graphBgColor;

  AccessoriesProductGraph({this.productItem, this.graphBgColor});

  @override
  _AccessoriesProductGraphState createState() =>
      _AccessoriesProductGraphState();
}

class _AccessoriesProductGraphState extends State<AccessoriesProductGraph> {
  List finalTakealotProductItems = [];
  List finalHifiProductItems = [];
  List finalComputermaniaProductItems = [];
  bool _isLoadingRecommendations = false;

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

  Future<void> _getProductData() async {
    await GroceryStoresProviderMethods.checkNullAndGetAllProductData(context);
  }

  Future<void> _onRefresh() async {
    print("is getting data");
    setState(() {
      _isLoadingRecommendations = true;
    });
    try {
      Map dataMap = await AccessoriesGraphRecommendations.getRecommendations(
          context, widget.productItem.title);

      finalTakealotProductItems = await dataMap['takealot'];
      finalHifiProductItems = await dataMap['hifi'];
      finalComputermaniaProductItems = await dataMap['computermania'];
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

      Map dataMap = await AccessoriesGraphRecommendations.getRecommendations(
          context, widget.productItem.title);

      finalTakealotProductItems = await dataMap['takealot'];
      finalHifiProductItems = await dataMap['hifi'];
      finalComputermaniaProductItems = await dataMap['computermania'];
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

      Map dataMap = await AccessoriesGraphRecommendations.getRecommendations(
          context, widget.productItem.title);

      finalTakealotProductItems = await dataMap['takealot'];
      finalHifiProductItems = await dataMap['hifi'];
      finalComputermaniaProductItems = await dataMap['computermania'];
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
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _onRefresh();
    });
  }

  void _showSnackBar(BuildContext context, String text, Color color) {
    Scaffold.of(context).showSnackBar(new SnackBar(
      duration: Duration(milliseconds: 2000),
      content: new Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: color,
    ));
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
      onRefresh: () => _onRefresh(),
      child: Scaffold(
        body: Container(
            color: Colors.white,
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: widget.graphBgColor.withOpacity(.2)),
                            width: screenWidth10p * 4.5,
                            height: screenHeight10p * 4.5,
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                color: widget.graphBgColor,
                                size: screenHeight10p * 3,
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                        ],
                      ),
                    ),
//                    Positioned(
//                      right: screenWidth10p*2,
//                      top: 0,
//
//                      child: Container(
//                        decoration:BoxDecoration(
//                            borderRadius: BorderRadius.circular(10),
//                            color:widget.graphBgColor.withOpacity(.2)
//                        ),
//
//                        width: screenWidth10p*4.5,
//
//                        height: screenHeight10p*4.5,
//
//                        child: IconButton(
//                          icon: Icon(Icons.shopping_basket_outlined,color:widget.graphBgColor,size: screenHeight10p*3,) ,
//                          onPressed: (){
//
//                          GroceryShoppingListItem _groceryItem = GroceryShoppingListItem(
//                          title: widget.productItem.title,
//                          store: "Pick n Pay",
//                          prices:  widget.productItem.prices,
//                          imageUrl:  widget.productItem.imageUrl,
//                          change:  widget.productItem.change,
//                          quantity: 1,
//                          productItem:  widget.productItem
//                          );
//
//                            Provider.of<GroceryShoppingList>(context,listen: false).addToGroceryShoppingList(_groceryItem);
//
//                          _showSnackBar(
//                              context,
//                              " Added ${widget.productItem.title} to shopping list",
//                              widget.graphBgColor
//                          );
//
//                          },
//                        ),
//                      ),
//                    ),
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
                        color: widget.graphBgColor,
                      ),
                      child: SfCartesianChart(
                        plotAreaBorderWidth: 0,
                        crosshairBehavior: CrosshairBehavior(
                          enable: true,
                        ),
//borderColor: Colors.blue,

                        palette: [
//                      Colors.black,
                          Colors.orange
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
                              color: Colors.black.withOpacity(.5), width: 1),
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
                        legend:
                            Legend(overflowMode: LegendItemOverflowMode.wrap),
                        tooltipBehavior: TooltipBehavior(enable: true),
                        backgroundColor: Colors.black.withOpacity(.2),

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
                            priceValue: widget.productItem.prices
                                    .map((e) => double.parse(e.toString()))
                                    .toList()
                                    .reduce(max) ??
                                0,
                            title: "Max",
                            bgColor: widget.graphBgColor,
                            textColor: Colors.white,
                            headerColor: Colors.white.withOpacity(.6),
                          ),
                        ),
                        MaxMinCard(
                          priceValue: widget.productItem.prices
                                  .map((e) => double.parse(e.toString()))
                                  .toList()
                                  .reduce(min) ??
                              0,
                          title: "Min",
                          bgColor: widget.graphBgColor,
                          textColor: Colors.white,
                          headerColor: Colors.white.withOpacity(.6),
                        ),
                        MaxMinCard(
                          priceValue: (widget.productItem.prices
                                          .map(
                                              (e) => double.parse(e.toString()))
                                          .reduce((a, b) => a + b) /
                                      widget.productItem.prices.length)
                                  .roundToDouble() ??
                              0,
                          title: "Avg",
                          bgColor: widget.graphBgColor,
                          textColor: Colors.white,
                          headerColor: Colors.white.withOpacity(.6),
                        ),
                      ]),
                ),
                SizedBox(
                  height: 3 * screenHeight10p,
                ),
                CurrentPriceCard(
                    bgColor: widget.graphBgColor,
                    textColor: Colors.white,
                    headerColor: Colors.white.withOpacity(.6),
                    priceValue: widget.productItem.prices.last),

                SizedBox(
                  height: 5 * screenHeight10p,
                ),

                if (_isLoadingRecommendations)
                  Center(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: screenHeight10p * 3),
                      child: CircularProgressIndicator(),
                    ),
                  ),

                if (finalTakealotProductItems.isNotEmpty)
                  RecommendationStoreName(
                      color: kBgTakealot, title: "Takealot"),

                if (finalTakealotProductItems.isNotEmpty)
                  Container(
                      height: screenHeight * .35,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: finalTakealotProductItems.length,
                        itemBuilder: (_, index) {
                          return GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AccessoriesProductGraph(
                                  productItem: finalTakealotProductItems[index],
                                  graphBgColor: kBgTakealot,
                                ),
                              ),
                            ),
                            child: RecommendationProductCard(
                                finalStoreProductItems:
                                    finalTakealotProductItems,
                                nullImageUrl: _nullImageUrl,
                                index: index),
                          );
                        },
                      )),

                if (finalHifiProductItems.isNotEmpty)
                  RecommendationStoreName(color: kBgHifi, title: "Hifi"),

                if (finalHifiProductItems.isNotEmpty)
                  Container(
                      height: screenHeight * .35,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: finalHifiProductItems.length,
                        itemBuilder: (_, index) {
                          return GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AccessoriesProductGraph(
                                  productItem: finalHifiProductItems[index],
                                  graphBgColor: kBgHifi,
                                ),
                              ),
                            ),
                            child: RecommendationProductCard(
                                finalStoreProductItems: finalHifiProductItems,
                                nullImageUrl: _nullImageUrl,
                                index: index),
                          );
                        },
                      )),

                if (finalComputermaniaProductItems.isNotEmpty)
                  RecommendationStoreName(
                      color: kBgComputermania, title: "Computer mania"),

                if (finalComputermaniaProductItems.isNotEmpty)
                  Container(
                      height: screenHeight * .35,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: finalComputermaniaProductItems.length,
                        itemBuilder: (_, index) {
                          return GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AccessoriesProductGraph(
                                  productItem:
                                      finalComputermaniaProductItems[index],
                                  graphBgColor: kBgComputermania,
                                ),
                              ),
                            ),
                            child: RecommendationProductCard(
                                finalStoreProductItems:
                                    finalComputermaniaProductItems,
                                nullImageUrl: _nullImageUrl,
                                index: index),
                          );
                        },
                      )),

                if (finalComputermaniaProductItems.isNotEmpty)
                  SizedBox(
                    height: 5 * screenHeight10p,
                  ),
              ],
            )),
      ),
    );
  }
}
