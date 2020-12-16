import 'dart:convert';

import 'package:e_grocery/src/components/custom_paint.dart';
import 'package:e_grocery/src/components/product_item.dart';
import 'package:e_grocery/src/components/shoprite_search.dart';
import 'package:e_grocery/src/constants/constants.dart';
import 'package:e_grocery/src/networking/shoprite_data.dart';
import 'package:e_grocery/src/pages/shoprite_product_graph.dart';
import 'package:e_grocery/src/providers/shoprite_product_name_provider.dart';
import 'package:e_grocery/src/providers/shoprite_product_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:provider/provider.dart';

class ShopriteHomeScreen extends StatefulWidget {
  static const id = "shopriteHomeScreen";
  @override
  _ShopriteHomeScreenState createState() => _ShopriteHomeScreenState();
}

class _ShopriteHomeScreenState extends State<ShopriteHomeScreen> {
  final _textController = TextEditingController();
  final _gridScrollController = ScrollController();
  ScrollController _scrollController = ScrollController();


  List<ProductItem> cheap = [];
  List<ProductItem> expensive = [];
  List<ProductItem> allProducts = [];

  @override
  void initState() {





  }


  final _outlineBorder = OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(10));

  @override
  void dispose() {
    _textController.dispose();
    _gridScrollController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _getBestBuys(){

  }

  void _cleanExpensive(List<dynamic> items) {
    for (var i in items) {
      List<DateTime> tempDateList = [];

      List<dynamic> datesList = i[i.keys.elementAt(0).toString()]['dates'];

      for (var dateString in datesList) {
        tempDateList.add((DateTime.parse(dateString)));
      }

      ProductItem _productItem = ProductItem(
          i[i.keys.elementAt(0).toString()]['image_url'],
          i[i.keys.elementAt(0).toString()]['prices_list'],
          tempDateList,
          i.keys.elementAt(0).toString(),
          i[i.keys.elementAt(0).toString()]['change']);

      expensive.add(_productItem);
    }


    setState(() {});
  }

  void _cleanCheap(List<dynamic> items) {
    for (var i in items) {
      List<DateTime> tempDateList = [];

      List<dynamic> datesList = i[i.keys.elementAt(0).toString()]['dates'];

      for (var dateString in datesList) {
        tempDateList.add((DateTime.parse(dateString)));
      }

      ProductItem _productItem = ProductItem(
          i[i.keys.elementAt(0).toString()]['image_url'],
          i[i.keys.elementAt(0).toString()]['prices_list'],
          tempDateList,
          i.keys.elementAt(0).toString(),
          i[i.keys.elementAt(0).toString()]['change']);

//      print(_productItem.imageUrl);
//      print(_productItem.dates);
//      print(_productItem.prices);
//      print(_productItem.title);

      cheap.add(_productItem);
    }
//    print(cheap);

    setState(() {});
  }

  final double _horizontalPadding = 20.0;
  bool _isGrid = false;
  final _shopriteNullImageUrl =
      'https://www.shoprite.co.za/medias/Food-min.webp?context=bWFzdGVyfHJvb3R8MTE2MDJ8aW1hZ2Uvd2VicHxoZGUvaDI1Lzg5OTgyNTE5MjE0Mzgud2VicHw4MzAyOGFmMTU0NmEwMmUwOWYwYjU2MTJhMzUzMWVhZWRlMWQ2ODg5NTRhZDIzODMwYTcxN2U1ODRhNGU2ZGZj';

  @override
  Widget build(BuildContext context) {
    dynamic data =  Provider.of<AllProductList>(context,listen: true).data;

    if (data != null){
      _cleanCheap(jsonDecode(data["cheap"]));
      _cleanExpensive(jsonDecode(data["expensive"]));

    }


    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
      allProducts = cheap + expensive;
      allProducts.shuffle();

    return Container(
//      color: kShopriteSecondary,
      color: Colors.white,
      child: ListView(
        controller: _scrollController,
        children: [
          Stack(
            children: [
              CustomPaint(
                size: Size(screenWidth,
                    270.0), //You can Replace this with your desired WIDTH and HEIGHT
                painter: HomeBGCustomPaint(color: kBgShoprite),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: _horizontalPadding),
                    child: Text(
                      "Shoprite",
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),



                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: _horizontalPadding),
                    child:
                    Center(
                      child: GestureDetector(
                        onTap: ()async{
//                          print(data);
                          Provider.of<ProductNameList>(context,listen: false).getProductNameList(data,context);
                          final result = await showSearch(context: context, delegate: ShoeSearch());
                          print(result);
                          ShopriteData _shopriteData = ShopriteData();

                          if (result !=null){
                            dynamic response = await _shopriteData.getSingleProductData(result);
                            dynamic parsedResponse = jsonDecode(response);

                            List<DateTime> tempDateList = [];

                            List<dynamic> datesList = parsedResponse[parsedResponse.keys.elementAt(0).toString()]['dates'];

                            for (var dateString in datesList) {
                              tempDateList.add((DateTime.parse(dateString)));
                            }

                            ProductItem _parsedProductItem = ProductItem(
                                parsedResponse[parsedResponse.keys.elementAt(0).toString()]['image_url'],
                                parsedResponse[parsedResponse.keys.elementAt(0).toString()]['prices_list'],
                                tempDateList,
                                parsedResponse.keys.elementAt(0).toString(),
                                parsedResponse[parsedResponse.keys.elementAt(0).toString()]['change']);


                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    ShopriteProductGraph(
                                        productItem:
                                        _parsedProductItem),
                              ),
                            );
                          }



//                          print(response);





                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(.8),

                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 70,vertical: 20),
                            child: Text(
                            "Search Product",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "Montserrat",
                                decoration: TextDecoration.none,
                                color: kTextColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 18),
                            ),
                          )

                          ,
                        ),
                      ),
                    )

//                    Material(
//                      color: Colors.transparent,
//                      child: TextField(
//                        textAlign: TextAlign.center,
//                        maxLines: 1,
//                        controller: _textController,
//                        style:
//                            TextStyle(fontFamily: "Montserrat", fontSize: 18),
//                        decoration: InputDecoration(
//                          fillColor: Colors.white.withOpacity(.8),
//                          hintText: "Search Product",
//                          filled: true,
//                          focusedBorder: _outlineBorder,
//                          enabledBorder: _outlineBorder,
//                          border: _outlineBorder,
//                        ),
//                      ),
//                    ),
                  ),
                ],
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
            child: Container(
              decoration: BoxDecoration(
                  color: kBgShoprite.withOpacity(.1),
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: Text(
                            "Best Buys",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Montserrat",
                              decoration: TextDecoration.none,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    BestChoiceProduct(title: "Ritebrand Mayonnaise Cream"),
                    SizedBox(
                      height: 10,
                    ),
                    BestChoiceProduct(title: "Crown blended cooking oil"),
                    SizedBox(
                      height: 10,
                    ),
                    BestChoiceProduct(
                        title:
                            "Country Fair fresh chicken 10 pierce braaipack"),
                    SizedBox(
                      height: 10,
                    ),
                    BestChoiceProduct(
                        title: "Crystal Valley Gouda Cheese Pack "),
                    SizedBox(
                      height: 30,
                    ),

                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Container(
            decoration: BoxDecoration(
                color: kBgShoprite.withOpacity(.1),
                borderRadius: BorderRadius.circular(15)),
            height: 70,
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: EdgeInsets.symmetric(
              horizontal: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isGrid = !_isGrid;
                    });
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: _isGrid ? Colors.white : Colors.transparent,
                          borderRadius: BorderRadius.circular(10)),
                      width: screenWidth * .5 * .8,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      child: Text(
                        "DataTable",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            decoration: TextDecoration.none),
                      )),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isGrid = !_isGrid;
                    });
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          color: _isGrid ? Colors.transparent : Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      width: screenWidth * .5 * .8,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      child: Text(
                        "Grid",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Montserrat",
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            decoration: TextDecoration.none),
                      )),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            height: _isGrid ?  70 * cheap.length.toDouble(): 150 * cheap.length.toDouble() ,
            child: DefaultTabController(
              length: 3,

              child: Column(
                children: [
                  Material(
                    child: TabBar(
                      indicator: BoxDecoration(
                          border: Border.all(color: kBgShoprite, width: 5),
                          borderRadius: BorderRadius.circular(50)),
                      tabs: [
                        Tab(
//                                    text: "All",
                            child: Text(
                          "All",
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Montserrat",
                            fontSize: 20
                          ),
                        )),
                        Tab(
//                                    text: "All",
                            child: Text(
                              "Cheap",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Montserrat",
                                  fontSize: 18
                              ),
                            )),
                        Tab(
//                                    text: "All",
                            child: Text(
                              "Expensive",
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "Montserrat",
                                  fontSize: 20
                              ),
                            )),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Material(
                        child: TabBarView(
//                                  controller: _tabController,
                      children: [

                        productTabBarView(context,allProducts),
                        productTabBarView(context,cheap),
                        productTabBarView(context,expensive),

                      ],
                    )),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 70,
          ),
        ],
      ),
    );
  }

  ListView productTabBarView(BuildContext context, List<ProductItem>  itemList) {
    return ListView(
                        controller: _scrollController,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          SizedBox(
                            height: 50,
                          ),

                          _isGrid
                              ? Material(
                            child: DataTable(
                              columnSpacing: 5,
                              headingTextStyle: TextStyle(
                                  fontFamily: "Montserrat",
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black),

                              showBottomBorder: false,
                              sortAscending: true,
                              sortColumnIndex: 1,
                              dividerThickness: 0,
//                  horizontalMargin: 20,
                              dataRowHeight: 55,
                              headingRowColor:
                              MaterialStateProperty.all(
                                  kShopriteSecondary
                                      .withOpacity(.3)),
                              columns: [
                                DataColumn(
                                  label: Text('Image'),
                                ),
                                DataColumn(
                                  label: Text('Title'),
                                ),
                                DataColumn(
                                    label: Text(
                                      'Price',
                                    ),
                                    numeric: true),
                                DataColumn(
                                    label: Text(
                                      'Change',
                                    ),
                                    numeric: true),
                              ],
                              rows: [
                                ...itemList.map(
                                      (product) => DataRow(
                                    cells: [
                                      DataCell(
                                          Image.network(product
                                              .imageUrl ??
                                              _shopriteNullImageUrl),
                                          onTap: () =>
                                          product.imageUrl == null
                                              ? null
                                              : _showDialog(product,
                                              context)),
                                      DataCell(
                                        Text(
                                          "${product.title}",
                                          maxLines: 3,
                                          style: TextStyle(
//                                color: Colors.redAccent,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                        onTap: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                ShopriteProductGraph(
                                                    productItem:
                                                    product),
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          'R${product.prices[product.prices.length-1]}',
                                          style: TextStyle(
//                                color: Colors.redAccent,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      DataCell(
                                        Text(
                                          "${product.change.round()}%",
                                          style: TextStyle(
                                              color: product.change  > 0  ?  Colors.red : Colors.green  ,


                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          )
                              : Scrollbar(
                            controller: _gridScrollController,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10),
                              child: GridView.builder(
                                  controller: _gridScrollController,
                                  itemCount: itemList.length,
                                  shrinkWrap: true,
                                  gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 1 / 1.4,
                                    crossAxisSpacing: 10,
                                  ),
                                  itemBuilder: (_, index) {
                                    return

                                      GestureDetector(
                                       onTap: ()=> Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ShopriteProductGraph(
                                                      productItem:
                                                      itemList[index]),
                                            ),
                                       ),
                                        child: ProductCard(
                                          index: index,
                                          cheap: itemList,
                                          shopriteNullImageUrl:_shopriteNullImageUrl,
//                                    showDialog: _showDialog(itemList[index], context),
                                        product: itemList[index],
                                    ),
                                      );
                                  }),
                            ),
                          ),
                        ],
                      );
  }

  Future<void> _showDialog(ProductItem product, BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Hero(
            tag: '${product.imageUrl}',
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Column(
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                        child: Image.network(
                      product.imageUrl,
                    )),
                  ),
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: [],
                    ),
                  )
                ],
              ),
            ));
      },
    );
  }
}

class ProductCard extends StatelessWidget {
  List<ProductItem> cheap;
  String shopriteNullImageUrl;
  int index;
  ProductItem product;

  ProductCard({this.cheap, this.shopriteNullImageUrl, this.index,this.product});
  final double gridCardBorderRadius = 25;





  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(gridCardBorderRadius)),
      color: kBgShoprite.withOpacity(.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 13,
            child: Stack(
              children: [
                Row(
                  children: [
                    Expanded(
                      flex: 10,
                      child: Container(
                        decoration: BoxDecoration(
                            color: kBgShoprite.withOpacity(1),
                            borderRadius: BorderRadius.only(
                                bottomRight:
                                    Radius.circular(gridCardBorderRadius),
                                topLeft:
                                    Radius.circular(gridCardBorderRadius))),
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: Container(),
                    )
                  ],
                ),

//                                            BackdropFilter(
//                                              filter: ui.ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
//                                              child: Container(
//                                                height: 30,
//                                                decoration: BoxDecoration(color: Colors.black),
//                                              ),
//                                            ),

                Center(
                  child: Image.network(
                    cheap[index].imageUrl ?? shopriteNullImageUrl,
                    height: 250,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 10,

              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Price:  R${cheap[index].prices[cheap[index].prices.length - 1]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      "${cheap[index].title}",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "Montserrat",
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class BestChoiceProduct extends StatelessWidget {
  String title;

  BestChoiceProduct({this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: Colors.black,
        fontFamily: "Montserrat",
        decoration: TextDecoration.none,
        fontSize: 18,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
