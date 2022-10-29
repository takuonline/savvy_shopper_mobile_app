import 'package:e_grocery/src/components/custom_paint.dart';
import 'package:e_grocery/src/components/homescreen_components/best_buys.dart';
import 'package:e_grocery/src/components/product_item.dart';
import 'package:e_grocery/src/components/woolies/woolies_search.dart';
import 'package:e_grocery/src/constants/constants.dart';
import 'package:e_grocery/src/mixins/woolworths_clothing_home_page_mixin.dart';
import 'package:e_grocery/src/networking/clothing/woolworths_clothing_data.dart';
import 'package:e_grocery/src/networking/connection_test.dart';
import 'package:e_grocery/src/pages/clothing_product_graph/woolworths_clothing_product_graph.dart';
import 'package:e_grocery/src/providers/clothing/woolworths_clothing_product_provider.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

class WoolworthsClothingHomeScreen extends StatefulWidget {
  static const id = "/woolworthsClothingHomeScreen";

  @override
  _WoolworthsClothingHomeScreenState createState() =>
      _WoolworthsClothingHomeScreenState();
}

class _WoolworthsClothingHomeScreenState
    extends State<WoolworthsClothingHomeScreen>
    with WoolworthsClothingHomePageMixin {
  @override
  void initState() {
    super.initState();
    testConnection(
        Provider.of<WoolworthsClothingAllProductList>(context, listen: false));
  }

  @override
  void dispose() {
    textController.dispose();
    gridScrollController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    data = Provider.of<WoolworthsClothingAllProductList>(context, listen: true)
        .data;

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
    List<WooliesProductItem> bestBuys = cheap.take(5).toList();
    allProducts.shuffle();

    return Container(
      color: Colors.white,
      child: RefreshIndicator(
        onRefresh: () => getDataOnRefresh(
            Provider.of<WoolworthsClothingAllProductList>(context,
                listen: false)),
        child: ListView(
          controller: scrollController,
          children: [
            Stack(
              children: [
                Positioned(
                  child: CustomPaint(
                    size: Size(screenWidth, screenHeight * .37),
                    //You can Replace this with your desired WIDTH and HEIGHT
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
                          EdgeInsets.symmetric(horizontal: horizontalPadding),
                      child: FittedBox(
                        child: Text(
                          "Woolworths Clothing",
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
                        padding:
                            EdgeInsets.symmetric(horizontal: horizontalPadding),
                        child: Center(
                          child: GestureDetector(
                            onTap: () async {
                              if (await TestConnection.checkForConnection()) {
                                WoolworthsClothingData _networkData =
                                    WoolworthsClothingData();

                                final result = await showSearch(
                                  context: context,
                                  delegate: WooliesProductSearch(
                                      items: Provider.of<
                                                  WoolworthsClothingAllProductList>(
                                              context,
                                              listen: false)
                                          .items,
                                      networkData: _networkData),
                                );
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
                        )),
                  ],
                )
              ],
            ),
            BestBuys(bestBuys: bestBuys),
            SizedBox(
              height: 40,
            ),
            isLoading
                ? Center(child: CircularProgressIndicator())
                : Container(),
            SizedBox(
              height: 30,
            ),
            Container(
              height: screenHeight10p * 7.3 * cheap.length.toDouble(),
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

  ListView productTabBarView(
      BuildContext context, List<WooliesProductItem> itemList) {
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
                          builder: (context) => WoolworthsClothingProductGraph(
                              productItem: product),
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
                          builder: (context) => WoolworthsClothingProductGraph(
                              productItem: product),
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
                          builder: (context) => WoolworthsClothingProductGraph(
                              productItem: product),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
