import 'dart:math';
import 'package:e_grocery/src/components/graph_page_components.dart';
import 'package:e_grocery/src/components/grocery_stores_provider_aggregate_methods.dart';
import 'package:e_grocery/src/components/product_item.dart';
import 'package:e_grocery/src/constants/constants.dart';
import 'package:e_grocery/src/mixins/grocery_graph_page_mixin.dart';
import 'package:e_grocery/src/pages/groceries_product_graph/shoprite_product_graph.dart';
import 'package:e_grocery/src/pages/groceries_product_graph/woolies_product_graph.dart';
import 'package:e_grocery/src/services/grocery_services/get_graph_page_recommendations_groceries.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PnPProductGraph extends StatefulWidget {
  static const id = "pnp-product-graph";

  ProductItem productItem;

  PnPProductGraph({this.productItem});

  @override
  _PnPProductGraphState createState() => _PnPProductGraphState();
}

class _PnPProductGraphState extends State<PnPProductGraph>
    with GroceryGraphPageMixin {
//  List finalPnPProductItems = [];
//  List finalShopriteProductItems = [];
//  List finalWooliesProductItems = [];
//  bool _isLoadingRecommendations = false;

  final _badImageUrl =
      "/pnpstorefront/_ui/responsive/theme-blue/images/missing_product_EN_140x140.jpg";

//  final _nullImageUrl =
//      'https://www.pnp.co.za//pnpstorefront/_ui/responsive/theme-blue/images/missing_product_EN_400x400.jpg';
//
//  List<ProductData> _getData() {
//    List<ProductData> temp = [];
//    for (int i = 0; i < widget.productItem.prices.length; i++) {
//      temp.add(ProductData(
//          widget.productItem.dates[i], widget.productItem.prices[i]));
//    }
//    return temp;
//  }

  Future<void> _getProductData() async {
    await GroceryStoresProviderMethods.checkNullAndGetAllProductData(context);
  }

//  Future<void> _onRefresh() async {
//    print("is getting data");
//    setState(() {
//      _isLoadingRecommendations = true;
//    });
//    try {
//      Map dataMap = await GetGraphPageRecommendationGroceries
//          .getRecommendations(
//          context, widget.productItem.title);
//
//      finalPnPProductItems = await dataMap['pnp'];
//      finalShopriteProductItems = await dataMap['shoprite'];
//      finalWooliesProductItems = await dataMap['woolies'];
//      setState(() {});
//
//      setState(() {
//        _isLoadingRecommendations = false;
//      });
//    } on NoSuchMethodError {
//      print("noooooooooooo such  methoddddddddddddddddd  in refreshing data ");
//
//      setState(() {
//        _isLoadingRecommendations = true;
//      });
//      _getProductData();
////      WidgetsBinding.instance.addPostFrameCallback((_) async{
//
//      Map dataMap = await GetGraphPageRecommendationGroceries
//          .getRecommendations(
//          context, widget.productItem.title);
//
//      finalPnPProductItems = await dataMap['pnp'];
//      finalShopriteProductItems = await dataMap['shoprite'];
//      finalWooliesProductItems = await dataMap['woolies'];
//      setState(() {});
//
//      setState(() {
//        _isLoadingRecommendations = false;
//      });
//    } on RangeError {
//      print("range errrrrrrrrrrrrrrrrrrrror in refreshing data");
//      setState(() {
//        _isLoadingRecommendations = true;
//      });
//
//      _getProductData();
//
////      WidgetsBinding.instance.addPostFrameCallback((_) async{
//
//      Map dataMap = await GetGraphPageRecommendationGroceries
//          .getRecommendations(
//          context, widget.productItem.title);
//
//      finalPnPProductItems = await dataMap['pnp'];
//      finalShopriteProductItems = await dataMap['shoprite'];
//      finalWooliesProductItems = await dataMap['woolies'];
//      setState(() {});
//
////      });
//
//      setState(() {
//        _isLoadingRecommendations = false;
//      });
//    } catch (e) {
//      print(e);
//      setState(() {
//        _isLoadingRecommendations = false;
//      });
//    }
//  }

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

//  void _showSnackBar(BuildContext context, String text, Color color) {
//    Scaffold.of(context).showSnackBar(new SnackBar(
//      duration: Duration(milliseconds: 2000),
//      content: new Text(
//        text,
//        textAlign: TextAlign.center,
//        style: TextStyle(color: Colors.white),
//      ),
//      backgroundColor: color,
//    ));
//  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;

    final screenHeight10p =
        screenHeight * (10 / MediaQuery
            .of(context)
            .size
            .height);
    final screenWidth10p =
        screenWidth * (10 / MediaQuery
            .of(context)
            .size
            .width);

    return RefreshIndicator(
      onRefresh: () => onRefresh(widget.productItem.title),
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
                          child: widget.productItem.imageUrl == _badImageUrl
                              ? Image.network(nullImageUrl)
                              : Image.network(
                            widget.productItem.imageUrl ?? nullImageUrl,
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
                                color: kBgPnP.withOpacity(.2)),
                            width: screenWidth10p * 4.5,
                            height: screenHeight10p * 4.5,
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_back,
                                color: kBgPnP,
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
//                            color:kBgPnP.withOpacity(.2)
//                        ),
//
//                        width: screenWidth10p*4.5,
//
//                        height: screenHeight10p*4.5,
//
//                        child: IconButton(
//                          icon: Icon(Icons.shopping_basket_outlined,color:kBgPnP,size: screenHeight10p*3,) ,
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
//                              kBgPnP
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
                  margin: EdgeInsets.symmetric(
                      horizontal: screenHeight10p * 1.5),
                  decoration:
                  BoxDecoration(
                      borderRadius: BorderRadius.circular(screenHeight10p * 5)),
                  child: Material(
                    elevation: 20,
                    borderRadius: BorderRadius.circular(screenHeight10p * 2),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: screenHeight10p,
                          vertical: screenHeight10p * 2),
                      width: screenWidth,
                      height: screenHeight * .55,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                            screenHeight10p * 2),
                        color: kBgPnP,
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
                          majorGridLines: MajorGridLines(
                              color: Colors.blue,
                              width: 0
                          )
                          , labelStyle: TextStyle(
                            color: Colors.white
                        )
                          ,
                          title: AxisTitle(

                              text: 'Date',
                              textStyle: TextStyle(
                                  color: Colors.white
                              )
                          ),
                          intervalType: DateTimeIntervalType.days,
                        ),
                        primaryYAxis: NumericAxis(
                          labelStyle: TextStyle(
                              color: Colors.white
                          ), majorGridLines: MajorGridLines(
                            color: Colors.black.withOpacity(.5),
                            width: 1
                        ),
                          title: AxisTitle(
                              text: 'Price',
                              textStyle: TextStyle(
                                  color: Colors.white
                              )

                          ),

//                        labelFormat: 'R{value}'
//                    interval: 4
                        ),
                        //give chart title
                        title: ChartTitle(text: widget.productItem.title,
                            textStyle: TextStyle(
                                color: Colors.white
                            )),
                        onMarkerRender: (args) {
//                      args.
                        },
                        legend: Legend(
                            overflowMode: LegendItemOverflowMode.wrap),
                        tooltipBehavior: TooltipBehavior(enable: true),
                        backgroundColor: Colors.black.withOpacity(.2),

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
                            _getProductData();
                          }
                          ,

                          child: MaxMinCard(

                            priceValue: widget.productItem.prices.map((e) =>
                                double.parse(e.toString())).toList().reduce(
                                max) ?? 0,
                            title: "Max",
                            bgColor: kBgPnP,
                            textColor: Colors.white,
                            headerColor: Colors.white.withOpacity(.6),
                          ),
                        ),
                        MaxMinCard(

                          priceValue: widget.productItem.prices.map((e) =>
                              double.parse(e.toString())).toList().reduce(
                              min) ?? 0,
                          title: "Min",
                          bgColor: kBgPnP,
                          textColor: Colors.white,
                          headerColor: Colors.white.withOpacity(.6),
                        ),
                        MaxMinCard(

                          priceValue: (widget.productItem.prices.map((e) =>
                              double.parse(e.toString())).reduce((a, b) =>
                          a + b) / widget.productItem.prices.length)
                              .roundToDouble() ?? 0,
                          title: "Avg",
                          bgColor: kBgPnP,
                          textColor: Colors.white,
                          headerColor: Colors.white.withOpacity(.6),
                        ),

                      ]
                  ),
                ),
                SizedBox(
                  height: 3 * screenHeight10p,
                ),
                CurrentPriceCard(

                    bgColor: kBgPnP,
                    textColor: Colors.white,
                    headerColor: Colors.white.withOpacity(.6),
                    priceValue: widget.productItem.prices.last

                ),

                SizedBox(
                  height: 2 * screenHeight10p,
                ),


                SizedBox(
                  height: 3 * screenHeight10p,
                ),

                if(isLoadingRecommendations) Center(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                        vertical: screenHeight10p * 3),
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
                              finalStoreProductItems:
                              finalShopriteProductItems,
                              nullImageUrl: nullImageUrl,
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
                              nullImageUrl: nullImageUrl,
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
                              nullImageUrl: nullImageUrl,
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
            )),

      ),
    );
  }



}



