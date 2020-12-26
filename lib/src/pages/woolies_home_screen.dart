import 'dart:convert';

import 'package:e_grocery/src/components/custom_paint.dart';
import 'package:e_grocery/src/components/homescreen_components.dart';
import 'package:e_grocery/src/components/product_item.dart';
import 'package:e_grocery/src/components/woolies/woolies_search.dart';
import 'package:e_grocery/src/constants/constants.dart';
import 'package:e_grocery/src/networking/connection_test.dart';
import 'package:e_grocery/src/pages/woolies_product_graph.dart';
import 'package:e_grocery/src/providers/woolies_product_name_provider.dart';
import 'package:e_grocery/src/providers/woolies_product_provider.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

class WooliesHomeScreen extends StatefulWidget {
  static const id = "/wooliesHomeScreen";
  @override
  _WooliesHomeScreenState createState() => _WooliesHomeScreenState();
}

class _WooliesHomeScreenState extends State<WooliesHomeScreen> {
  final _textController = TextEditingController();
  final _gridScrollController = ScrollController();
  final _scrollController = ScrollController();

  bool _isDataLoaded = false;
  dynamic data;

  bool _isLoading = false;

  List<WooliesProductItem> _cheap = [];
  List<WooliesProductItem> _expensive = [];
  List<WooliesProductItem> _allProducts = [];

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
                style: TextStyle(color: kBgWoolies),
              ),
              onPressed: () async {
                Navigator.of(context).pop();
                if (await TestConnection.checkForConnection()) {
                  Provider.of<WooliesAllProductList>(context, listen: false)
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

  void _testWooliesConnection() async {
    if (await TestConnection.checkForConnection()) {
      await Future.delayed(Duration(seconds: 15));
      if (Provider.of<WooliesAllProductList>(context, listen: false).data ==
          null) {
        setState(() {
          _isLoading = true;
        });
        await Provider.of<WooliesAllProductList>(context, listen: false)
            .getItems();
        setState(() {
          _isLoading = false;
        });
      }
    } else {
//      TestConnection.showNetworkDialog(context);
      await _showNetworkDialog(context);
    }
  }


  @override
  void initState() {
    super.initState();
    _testWooliesConnection();
  }

  @override
  void dispose() {
    _textController.dispose();
    _gridScrollController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _loadData(BuildContext context){
    if (data != null && !_isDataLoaded) {
//        print("in if statement");
      _cleanCheap(jsonDecode(data["cheap"]));
      _cleanExpensive(jsonDecode(data["expensive"]));

      setState(()=> _isLoading=false);
      setState(()=> _isDataLoaded=true);

    }else{
//      print("in else statement");
      setState(() => _isLoading=true);
    }
  }

  void _cleanExpensive(List<dynamic> items) {
    for (var i in items) {
      List<DateTime> tempDateList = [];

      List<dynamic> datesList = i[i.keys.elementAt(0).toString()]['dates'];

      for (var dateString in datesList) {
        tempDateList.add((DateTime.parse(dateString)));
      }

      WooliesProductItem _productItem = WooliesProductItem(
//          i[i.keys.elementAt(0).toString()]['image_url'],
          i[i.keys.elementAt(0).toString()]['prices_list'],
          tempDateList,
          i.keys.elementAt(0).toString(),
          i[i.keys.elementAt(0).toString()]['change']);

      _expensive.add(_productItem);
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

      WooliesProductItem _productItem = WooliesProductItem(
//          i[i.keys.elementAt(0).toString()]['image_url'],
          i[i.keys.elementAt(0).toString()]['prices_list'],
          tempDateList,
          i.keys.elementAt(0).toString(),
          i[i.keys.elementAt(0).toString()]['change']);

      _cheap.add(_productItem);
    }
//    print(cheap);

    setState(() {});
  }

  Future<void> _getDataOnRefresh()async{
    if (await TestConnection.checkForConnection()){
      print('refreshing');
      setState(() => _isLoading = true);
      setState(()=> _isDataLoaded=false);

      await Provider.of<WooliesAllProductList>(context,listen:false).getItems();

      _cheap=[];
      _expensive=[];
      _allProducts= [];

      data = Provider.of<WooliesAllProductList>(context, listen: false).data;

      print(data);
      print(_isDataLoaded);

      _cleanCheap(jsonDecode(data["cheap"]));
      _cleanExpensive(jsonDecode(data["expensive"]));

      setState(()=> _isLoading=false);


      setState(()=> _isDataLoaded=true);


    } else  {
      _showNetworkDialog(context);
    }

  }


  final double _horizontalPadding = 20.0;
  bool _isGrid = false;
  final _pnpNullImageUrl =
      'https://www.pnp.co.za/pnpstorefront/_ui/responsive/theme-blue/images/missing_product_EN_400x400.jpg';
  final _badImageUrl =
      "/pnpstorefront/_ui/responsive/theme-blue/images/missing_product_EN_140x140.jpg";

  void toggleGrid() {
//    setState(() {
//      _isGrid = !_isGrid;
//    });
  }

  @override
  Widget build(BuildContext context) {
     data =
        Provider.of<WooliesAllProductList>(context, listen: true).data;

     if (!_isDataLoaded ) {
       _loadData(context);
     }

     if (_cheap.isNotEmpty && _expensive.isNotEmpty) {
       setState(() => _isLoading=false);
     }

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenHeight10p =
        screenHeight * (10 / MediaQuery.of(context).size.height);
    final screenWidth10p =
        screenWidth * (10 / MediaQuery.of(context).size.width);

    _allProducts = _cheap + _expensive;
    List<WooliesProductItem> bestBuys = _cheap.take(5).toList();
    _allProducts.shuffle();

    return Container(
//      color: kShopriteSecondary,
      color: Colors.white,
      child: RefreshIndicator(
        onRefresh: () => _getDataOnRefresh(),
        child: ListView(
          controller: _scrollController,
          children: [
            Stack(
              children: [
                Positioned(
                  child: CustomPaint(
                    size: Size(
                        screenWidth,
                        screenHeight *
                            .37), //You can Replace this with your desired WIDTH and HEIGHT
                    painter: HomeBGCustomPaint(color: kBgWoolies),
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
                          "Woolworths",
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
                                Provider.of<WooliesProductNameList>(context,
                                        listen: false)
                                    .getProductNameList(data, context);
                                final result = await showSearch(
                                    context: context,
                                    delegate: ProductSearch());
                                print(result);
                              } else {
                                await TestConnection.showNetworkDialog(context);
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
                        )),
                  ],
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
              child: Container(
                decoration: BoxDecoration(
                    color: kBgWoolies.withOpacity(.1),
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
                      ...bestBuys
                          .map((e) => BestChoiceProduct(title: e.title))
                          .toList(),
                      SizedBox(height: 20)
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
//            Container(
//              decoration: BoxDecoration(
//                  color: kBgWoolies.withOpacity(.1),
//                  borderRadius: BorderRadius.circular(15)),
//              height: 70,
//              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//              padding: EdgeInsets.symmetric(
//                horizontal: 10,
//              ),
//              child: DatatableGridSelector(
//                _isGrid,toggleGrid
//
//              ),
//            ),

            _isLoading
                ? Center(child: CircularProgressIndicator())
                : Container(),
            SizedBox(
              height: 30,
            ),
            Container(
              height: screenHeight10p * 7.3 * _cheap.length.toDouble(),
              child: DefaultTabController(
                length: 3,
                child: Column(
                  children: [
                    Material(
                      child: TabBar(
                        indicator: BoxDecoration(
                            border: Border.all(color: kBgWoolies, width: 5),
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
                        children: [
                          productTabBarView(context, _allProducts),
                          productTabBarView(context, _cheap),
                          productTabBarView(context, _expensive),
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

  ListView productTabBarView(
      BuildContext context, List<WooliesProductItem> itemList) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenHeight10p =
        screenHeight * (10 / MediaQuery.of(context).size.height);
    final screenWidth10p =
        screenWidth * (10 / MediaQuery.of(context).size.width);

    return ListView(
      controller: _scrollController,
      physics: NeverScrollableScrollPhysics(),
      children: [
        SizedBox(
          height: 50,
        ),
//        if (_isGrid)
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
            dataRowHeight: 55,
            headingRowColor:
                MaterialStateProperty.all(kWooliesSecondary.withOpacity(.3)),
            columns: [
//              DataColumn(
//                label: FittedBox(child: Text('Image')),
//              ),
              DataColumn(
                label: FittedBox(
                    child: Text(
                  'Title',
                  textAlign: TextAlign.center,
                )),
              ),
              DataColumn(
                  label: FittedBox(
                    child: Text('Price', textAlign: TextAlign.center),
                  ),
                  numeric: true),
              DataColumn(
                  label: FittedBox(
                    child: Text('Change', textAlign: TextAlign.center),
                  ),
                  numeric: true),
            ],
            rows: [
              ...itemList.map(
                (product) => DataRow(
                  cells: [
//                        DataCell(
//                    product.imageUrl== _badImageUrl ? Image.network(_pnpNullImageUrl)  : Image.network(
//                                product.imageUrl ?? _pnpNullImageUrl),
//                            onTap: () =>
//                            product.imageUrl == null
//                                ? null
//                                : _showDialog(product, context)),
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
                              WooliesProductGraph(productItem: product),
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
                              WooliesProductGraph(productItem: product),
                        ),
                      ),
                    ),
                    DataCell(
                      Text(
                        "${product.change.round()}%",
                        style: TextStyle(
                          color: product.change > 0 ? Colors.red : Colors.green,
                        ),
                      ),
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              WooliesProductGraph(productItem: product),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
//        else Scrollbar(
//          controller: _gridScrollController,
//
//          child: Padding(
//            padding: const EdgeInsets.symmetric(horizontal: 10),
//            child: GridView.builder(
//                controller: _gridScrollController,
//                itemCount: itemList.length,
//                shrinkWrap: true,
//                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                  crossAxisCount: 2,
//                  childAspectRatio: 1 / 1.4,
//                  crossAxisSpacing: screenWidth*.03,
//                ),
//                itemBuilder: (_, index) {
//                  return  index==itemList.length-1 ?  Container()   :
//                  ( index.isEven ?
//                  GestureDetector(
//                    onTap: () =>Navigator.push(
//                          context,
//                          MaterialPageRoute(
//                            builder: (context) =>
//                                PnPProductGraph(
//                                    productItem: itemList[index]),
//                          ),
//                        )
//                        ,
//                    child: ProductCard(
//                      index: index,
//
//                      cheap: itemList,
//                      shopriteNullImageUrl: _pnpNullImageUrl,
////                                    showDialog: _showDialog(itemList[index], context),
//                      product: itemList[index],
//                    ),
//                  ) :
//                  Transform.translate(
//                    offset: Offset(0,80),
//                    child: GestureDetector(
//                      onTap: () =>
//                          Navigator.push(
//                            context,
//                            MaterialPageRoute(
//                              builder: (context) =>
//                                  PnPProductGraph(
//                                      productItem: itemList[index]),
//                            ),
//                          )
//                      ,
//                      child: ProductCard(
//                        index: index,
//
//                        cheap: itemList,
//                        shopriteNullImageUrl: _pnpNullImageUrl,
////                                    showDialog: _showDialog(itemList[index], context),
//                        product: itemList[index],
//                      ),
//                    ),
//                  ));
//                }),
//          ),
//        ),
      ],
    );
  }

//  Future<void> _showDialog(ProductItem product, BuildContext context) async {
//    return showDialog<void>(
//      context: context,
//      builder: (BuildContext context) {
//        return Hero(
//            tag: '${product.imageUrl}',
//            child: GestureDetector(
//              onTap: () => Navigator.pop(context),
//              child: Column(
//                children: [
//                  Expanded(
//                    flex: 4,
//                    child: Container(
//                        child:
//                        product.imageUrl == _badImageUrl ? Image.network(_pnpNullImageUrl) : Image.network(
//                          product.imageUrl??_pnpNullImageUrl,
//                        ),
//
//
//
//                    ),
//                  ),
//                  Expanded(
//                    flex: 1,
//                    child: Row(
//                      children: [],
//                    ),
//                  )
//                ],
//              ),
//            ));
//      },
//    );
//  }

}
