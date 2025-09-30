import 'package:e_grocery/src/components/custom_paint.dart';
import 'package:e_grocery/src/components/grid_homescreen_product_card/shoprite_product_card.dart';
import 'package:e_grocery/src/components/homescreen_components/best_buys.dart';
import 'package:e_grocery/src/components/homescreen_components/datatable_grid_selector.dart';
import 'package:e_grocery/src/components/product_item.dart';
import 'package:e_grocery/src/components/shoprite/shoprite_search.dart';
import 'package:e_grocery/src/constants/constants.dart';
import 'package:e_grocery/src/mixins/grocery_home_page_mixin.dart';
import 'package:e_grocery/src/networking/connection_test.dart';
import 'package:e_grocery/src/pages/groceries_product_graph/shoprite_product_graph.dart';
import 'package:e_grocery/src/providers/grocery/shoprite_product_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ShopriteHomeScreen extends StatefulWidget {
  static const id = "shopriteHomeScreen";

  @override
  _ShopriteHomeScreenState createState() => _ShopriteHomeScreenState();
}

class _ShopriteHomeScreenState extends State<ShopriteHomeScreen>
    with GroceriesHomePageMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    textController.dispose();
    gridScrollController.dispose();
    scrollController.dispose();
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    print("running did change");
    if (Provider.of<ShopriteAllProductList>(context, listen: false) == null) {
      testConnection(
          Provider.of<ShopriteAllProductList>(context, listen: true));
    }
  }

  final double _horizontalPadding = 20.0;

  final _shopriteNullImageUrl =
      'https://www.shoprite.co.za/medias/Food-min.webp?context=bWFzdGVyfHJvb3R8MTE2MDJ8aW1hZ2Uvd2VicHxoZGUvaDI1Lzg5OTgyNTE5MjE0Mzgud2VicHw4MzAyOGFmMTU0NmEwMmUwOWYwYjU2MTJhMzUzMWVhZWRlMWQ2ODg5NTRhZDIzODMwYTcxN2U1ODRhNGU2ZGZj';

  @override
  Widget build(BuildContext context) {
    data = Provider.of<ShopriteAllProductList>(context).data;

    if (!isDataLoaded) {
      loadData(context);
    }

    if (cheap.isNotEmpty && expensive.isNotEmpty) {
      setState(() => isLoading = false);
    }

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenHeight10p =
        screenHeight * (10 / MediaQuery.of(context).size.height);
    final screenWidth10p =
        screenWidth * (10 / MediaQuery.of(context).size.width);

    allProducts = cheap + expensive;
    List<ProductItem> bestBuys = cheap.take(5).toList();
    allProducts.shuffle();

    return Container(
      color: Colors.white,
      child: RefreshIndicator(
        onRefresh: () => getDataOnRefresh(
            Provider.of<ShopriteAllProductList>(context, listen: true)),
        child: ListView(
          controller: scrollController,
          children: [
            Stack(
              children: [
                Positioned(
                  child: CustomPaint(
                    size: Size(screenWidth, screenHeight * .37),
                    //You can Replace this with your desired WIDTH and HEIGHT
                    painter: HomeBGCustomPaint(color: kBgShoprite),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: screenHeight * .05,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: _horizontalPadding),
                      child: FittedBox(
                        child: Text(
                          "Shoprite",
                          style: TextStyle(
                            fontFamily: "Montserrat",
                            color: Colors.white,
                            fontSize: screenWidth10p * 3,
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * .025,
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: _horizontalPadding),
                        child: Center(
                          child: GestureDetector(
                            onTap: () async {
                              if (await TestConnection.checkForConnection()) {
//                                  Provider.of<ShopriteAllProductList>(
//                                      context, listen: false)
//                                      .getProductNameList();
                                final result = await showSearch(
                                    context: context,
                                    delegate: ProductSearch());
                                print(result);
                              } else {
                                await TestConnection.showNoNetworkDialog(
                                    context);
                              }
                            },
                            child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(.8),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.search,
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    width: screenWidth * .025,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 20),
                                    child: FittedBox(
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
                                    ),
                                  ),
                                ],
                              ),
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
            BestBuys(
              bestBuys: bestBuys,
              color: kBgShoprite.withOpacity(.1),
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
              child: DatatableGridSelector(isGridOff, toggleGrid),
            ),
            isLoading
                ? Center(child: CircularProgressIndicator())
                : Container(),
            SizedBox(
              height: 30,
            ),
            Container(
              height: isGridOff
                  ? screenHeight10p * 7 * cheap.length.toDouble()
                  : screenHeight10p * 13.6 * cheap.length.toDouble(),
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
                              child: FittedBox(
                            child: Text(
                              "All",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Montserrat",
                                  fontSize: 20),
                            ),
                          )),
                          Tab(
                              child: FittedBox(
                            child: Text(
                              "Cheap",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Montserrat",
                                  fontSize: 18),
                            ),
                          )),
                          Tab(
                              child: FittedBox(
                            child: Text(
                              "Expensive",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Montserrat",
                                  fontSize: 20),
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
                          productTabBarView(context, allProducts),
                          productTabBarView(context, cheap),
                          productTabBarView(context, expensive),
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
      ),
    );
  }

  Future<void> _showNetworkDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Please check your Network'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'An internet connection is required for this app, please make sure you are'
                  ' connected to a network and try again',
                  style: TextStyle(
                    fontFamily: "Montserrat",
                    color: Colors.black,
                  ),
                ),
//                Text('Would you like to approve of this message?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Retry',
                style: TextStyle(color: kBgShoprite),
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                if (await TestConnection.checkForConnection()) {
                  Provider.of<ShopriteAllProductList>(context, listen: false)
                      .getItems();
                } else {
                  _showNetworkDialog(context);
                }
              },
            ),
          ],
        );
      },
    );
  }

//  void _testShopriteConnection() async{
//
//    if (await TestConnection.checkForConnection()){
//      await Future.delayed(Duration(seconds: 7));
//      if (Provider
//          .of<ShopriteAllProductList>(context, listen: false)
//          .data == null) {
//        setState(() {
//          isLoading = true;
//        });
//        await Provider.of<ShopriteAllProductList>(context, listen: false)
//            .getItems();
//        setState(() {
//          isLoading = false;
//        });
//      }
//    }else{
//
////      TestConnection.showNetworkDialog(context);
//      await  _showNetworkDialog( context);
//    }
//
//  }

//  void _loadData(BuildContext context){
//    if (data != null && !isDataLoaded) {
////        print("in if statement");
//      cleanCheap(jsonDecode(data["cheap"]));
//      cleanExpensive(jsonDecode(data["expensive"]));
//      setState(()=> isLoading=false);
//      setState(()=> isDataLoaded=true);
//
//    }else{
////      print("in else statement");
//      setState(() => isLoading=true);
//    }
//  }

//  Future<void> _getDataOnRefresh()async{
//    if (await TestConnection.checkForConnection()){
//      print('refreshing');
//      setState(() => isLoading = true);
//      setState(() => isDataLoaded = false);
//
//      await Provider.of<ShopriteAllProductList>(context, listen: false)
//          .getItems();
//
//      cheap = [];
//      expensive = [];
//      allProducts = [];
//
//      data = Provider
//          .of<ShopriteAllProductList>(context, listen: false)
//          .data;
//
//      print(data);
//      print(isDataLoaded);
//
//      cleanCheap(jsonDecode(data["cheap"]));
//      cleanExpensive(jsonDecode(data["expensive"]));
//
//      setState(() => isLoading = false);
//
//
//      setState(()=> isDataLoaded=true);
//
//
//    } else  {
//       _showNetworkDialog(context);
//    }
//
//  }

//  void _cleanExpensive(List<dynamic> items) {
//    for (var i in items) {
//      List<DateTime> tempDateList = [];
//
//      List<dynamic> datesList = i[i.keys.elementAt(0).toString()]['dates'];
//
//      for (var dateString in datesList) {
//        tempDateList.add((DateTime.parse(dateString)));
//      }
//
//      ProductItem _productItem = ProductItem(
//          i[i.keys.elementAt(0).toString()]['image_url'],
//          i[i.keys.elementAt(0).toString()]['prices_list'],
//          tempDateList,
//          i.keys.elementAt(0).toString(),
//          i[i.keys.elementAt(0).toString()]['change']);
//
//      expensive.add(_productItem);
//    }
//
//    setState(() {});
//  }

//  void _cleanCheap(List<dynamic> items) {
//    for (var i in items) {
//      List<DateTime> tempDateList = [];
//
//      List<dynamic> datesList = i[i.keys.elementAt(0).toString()]['dates'];
//
//      for (var dateString in datesList) {
//        tempDateList.add((DateTime.parse(dateString)));
//      }
//
//      ProductItem _productItem = ProductItem(
//          i[i.keys.elementAt(0).toString()]['image_url'],
//          i[i.keys.elementAt(0).toString()]['prices_list'],
//          tempDateList,
//          i.keys.elementAt(0).toString(),
//          i[i.keys.elementAt(0).toString()]['change']);
//
//      cheap.add(_productItem);
//    }
////    print(cheap);
//
//    setState(() {});
//  }

  Row dataframeGridSelector(double screenWidth, double screenWidth10p) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isGridOff = !isGridOff;
            });
          },
          child: Container(
              decoration: BoxDecoration(
                  color: isGridOff ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(10)),
              width: screenWidth * .5 * .8,
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth10p * 2, vertical: screenWidth10p),
              child: FittedBox(
                child: Text(
                  "DataTable",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w500,
                      fontSize: screenWidth10p * 1.8,
                      decoration: TextDecoration.none),
                ),
              )),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              isGridOff = !isGridOff;
            });
          },
          child: Container(
              decoration: BoxDecoration(
                  color: isGridOff ? Colors.transparent : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              width: screenWidth * .5 * .8,
              padding: EdgeInsets.symmetric(
                  horizontal: screenWidth10p * 2, vertical: screenWidth10p * 1),
              child: Text(
                "Grid",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w500,
                    fontSize: screenWidth10p * 1.8,
                    decoration: TextDecoration.none),
              )),
        ),
      ],
    );
  }

  ListView productTabBarView(BuildContext context, List<ProductItem> itemList) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenHeight10p =
        screenHeight * (10 / MediaQuery.of(context).size.height);
    final screenWidth10p =
        screenWidth * (10 / MediaQuery.of(context).size.width);

    return ListView(
      controller: scrollController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        SizedBox(
          height: 50,
        ),
        if (isGridOff)
          Material(
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
                  MaterialStateProperty.all(kShopriteSecondary.withOpacity(.3)),
              columns: [
                DataColumn(
                  label: FittedBox(child: Text('Image')),
                ),
                DataColumn(
                  label: FittedBox(child: Text('Title')),
                ),
                DataColumn(
                    label: FittedBox(
                      child: Text(
                        'Price',
                      ),
                    ),
                    numeric: true),
                DataColumn(
                    label: FittedBox(
                      child: Text(
                        'Change',
                      ),
                    ),
                    numeric: true),
              ],
              rows: [
                ...itemList.map(
                  (product) => DataRow(
                    cells: [
                      DataCell(
                          Image.network(
                              product.imageUrl ?? _shopriteNullImageUrl),
                          onTap: () => product.imageUrl == null
                              ? null
                              : _showDialog(product, context)),
                      DataCell(
                        Text(
                          "${product.title}",
                          maxLines: 3,
                          style: TextStyle(
                            fontSize: screenWidth10p * 1.2,
//                                color: Colors.redAccent,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ShopriteProductGraph(productItem: product),
                          ),
                        ),
                      ),
                      DataCell(
                        FittedBox(
                          child: Text(
                            'R${product.prices[product.prices.length - 1]}',
                            style: TextStyle(
                              fontSize: screenWidth10p * 1.4,
//                                color: Colors.redAccent,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ShopriteProductGraph(productItem: product),
                          ),
                        ),
                      ),
                      DataCell(
                        Text(
                          "${product.change.round()}%",
                          style: TextStyle(
                            color:
                                product.change > 0 ? Colors.red : Colors.green,
                          ),
                        ),
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ShopriteProductGraph(productItem: product),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        else
          Scrollbar(
            controller: gridScrollController,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GridView.builder(
                  controller: gridScrollController,
                  itemCount: itemList.length,
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1 / 1.4,
                    crossAxisSpacing: screenWidth * .03,
                  ),
                  itemBuilder: (_, index) {
                    return index == itemList.length - 1
                        ? Container()
                        : (index.isEven
                            ? GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ShopriteProductGraph(
                                              productItem: itemList[index]),
                                    ),
                                  );
                                },
                                child: ProductCardRed(
//                      index: index,
                                  shopriteNullImageUrl: _shopriteNullImageUrl,
                                  product: itemList[index],
                                ),
                              )
                            : Transform.translate(
                                offset: Offset(0, 80),
                                child: GestureDetector(
                                  onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ShopriteProductGraph(
                                              productItem: itemList[index]),
                                    ),
                                  ),
                                  child: ProductCardRed(
//                        index: index,
                                    shopriteNullImageUrl: _shopriteNullImageUrl,
                                    product: itemList[index],
                                  ),
                                ),
                              ));
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
