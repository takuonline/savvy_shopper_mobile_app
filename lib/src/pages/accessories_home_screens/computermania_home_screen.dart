import 'dart:convert';

import 'package:e_grocery/src/components/custom_paint.dart';
import 'package:e_grocery/src/components/grid_homescreen_product_card/product_card_white.dart';
import 'package:e_grocery/src/components/homescreen_components/best_buys.dart';
import 'package:e_grocery/src/components/homescreen_components/datatable_grid_selector.dart';
import 'package:e_grocery/src/components/product_item.dart';
import 'package:e_grocery/src/constants/constants.dart';
import 'package:e_grocery/src/mixins/accessories_home_page_mixin.dart';
import 'package:e_grocery/src/networking/accessories/computermania_data.dart';
import 'package:e_grocery/src/networking/connection_test.dart';
import 'package:e_grocery/src/pages/accessories_product_graph/accessories_product_graph.dart';
import 'package:e_grocery/src/providers/accessories/computermania_product_provider.dart';
import 'package:e_grocery/src/services/accessories_services/accessories_search.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

class ComputermaniaHomeScreen extends StatefulWidget {
  static const id = "/computermaniaHomeScreen";

  @override
  _ComputermaniaHomeScreenState createState() =>
      _ComputermaniaHomeScreenState();
}

class _ComputermaniaHomeScreenState extends State<ComputermaniaHomeScreen>
    with AccessoriesHomePageMixin {
  @override
  void initState() {
    super.initState();
    testConnection(
        Provider.of<ComputermaniaAllProductList>(context, listen: false));
  }

  @override
  void dispose() {
    gridScrollController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    data = Provider.of<ComputermaniaAllProductList>(context, listen: true).data;

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
            Provider.of<ComputermaniaAllProductList>(context, listen: false)),
        child: ListView(
          controller: scrollController,
          children: [
            Stack(
              children: [
                Positioned(
                  child: CustomPaint(
                    size: Size(screenWidth, screenHeight * .37),
                    //You can Replace this with your desired WIDTH and HEIGHT
                    painter: HomeBGCustomPaint(color: kBgComputermania),
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
                          "Computer mania",
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
//
                                final result = await showSearch(
                                    context: context,
                                    delegate: AccessoriesProductSearch(
                                      networkData: ComputermaniaData(),
                                      bgColor: kBgComputermania,
                                      items: Provider.of<
                                                  ComputermaniaAllProductList>(
                                              context,
                                              listen: false)
                                          .titles,
                                    ));
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
            BestBuys(
              bestBuys: bestBuys,
              color: kBgComputermania.withOpacity(.1),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              decoration: BoxDecoration(
                  color: kBgComputermania.withOpacity(.1),
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
                  ? 70 * cheap.length.toDouble()
                  : 136 * cheap.length.toDouble(),
              child: DefaultTabController(
                length: 3,
                child: Column(
                  children: [
                    Material(
                      child: TabBar(
                        indicator: BoxDecoration(
                            border:
                            Border.all(color: kBgComputermania, width: 5),
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
                  MaterialStateProperty.all(kBgComputermania.withOpacity(.3)),
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
                      DataCell(Image.network(product.imageUrl ?? nullImageUrl),
                          onTap: () =>
                          product.imageUrl == null
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
                            builder: (context) => AccessoriesProductGraph(
                              productItem: product,
                              graphBgColor: kBgComputermania,
                            ),
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
                            builder: (context) => AccessoriesProductGraph(
                              productItem: product,
                              graphBgColor: kBgComputermania,
                            ),
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
                            builder: (context) => AccessoriesProductGraph(
                              productItem: product,
                              graphBgColor: kBgComputermania,
                            ),
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
                                onTap: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        AccessoriesProductGraph(
                                      productItem: itemList[index],
                                      graphBgColor: kBgComputermania,
                                    ),
                                  ),
                                ),
                                child: ProductCardWhite(
                                  index: index,

                                  cheap: itemList,
                                  shopriteNullImageUrl: nullImageUrl,
//                                    showDialog: _showDialog(itemList[index], context),
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
                                          AccessoriesProductGraph(
                                        productItem: itemList[index],
                                        graphBgColor: kBgComputermania,
                                      ),
                                    ),
                                  ),
                                  child: ProductCardWhite(
                                    index: index,

                                    cheap: itemList,
                                    shopriteNullImageUrl: nullImageUrl,
//                                    showDialog: _showDialog(itemList[index], context),
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
                        product.imageUrl ?? nullImageUrl,
                      ),
                    ),
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
