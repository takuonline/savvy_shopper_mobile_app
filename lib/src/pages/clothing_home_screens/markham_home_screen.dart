import 'dart:convert';

import 'package:e_grocery/src/components/clothing/product_tabbar_view.dart';
import 'package:e_grocery/src/components/custom_paint.dart';
import 'package:e_grocery/src/components/homescreen_components/best_buys.dart';
import 'package:e_grocery/src/components/homescreen_components/datatable_grid_selector.dart';
import 'package:e_grocery/src/components/product_item.dart';
import 'package:e_grocery/src/constants/constants.dart';
import 'package:e_grocery/src/mixins/clothing_home_page_mixin.dart';
import 'package:e_grocery/src/networking/clothing/markham_data.dart';
import 'package:e_grocery/src/networking/connection_test.dart';
import 'package:e_grocery/src/providers/clothing/markham_product_provider.dart';
import 'package:e_grocery/src/services/clothing_services/clothing_search.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

class MarkhamHomeScreen extends StatefulWidget {
  static const id = "/markhamHomeScreen";

  @override
  _MarkhamHomeScreenState createState() => _MarkhamHomeScreenState();
}

class _MarkhamHomeScreenState extends State<MarkhamHomeScreen>
    with SingleTickerProviderStateMixin, ClothingHomePageMixin {
  @override
  void initState() {
    super.initState();
    tabController = TabController(vsync: this, length: 3, initialIndex: 1);
    setState(() => tabController.addListener(() {}));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (Provider.of<MarkhamAllProductList>(context, listen: false) == null) {
      testConnection(
          Provider.of<MarkhamAllProductList>(context, listen: false));
    }
  }

  @override
  void dispose() {
    textController.dispose();
    gridScrollController.dispose();
    scrollController.dispose();
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    data = Provider.of<MarkhamAllProductList>(context, listen: true).data;

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
            Provider.of<MarkhamAllProductList>(context, listen: true)),
        child: ListView(
          controller: scrollController,
          children: [
            Stack(
              children: [
                Positioned(
                  child: CustomPaint(
                    size: Size(screenWidth, screenHeight * .37),
                    //You can Replace this with your desired WIDTH and HEIGHT
                    painter: HomeBGCustomPaint(color: kBgMarkham),
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
                          "Markham",
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
//                                Provider.of<MarkhamAllProductList>(context,
//                                        listen: false)
//                                    .getProductNameList(data, context);

                                final _networkData = MarkhamData();
                                final result = await showSearch(
                                    context: context,
                                    delegate: ClothingProductSearch(
                                        items:
                                        Provider
                                            .of<MarkhamAllProductList>(
                                            context,
                                            listen: false)
                                            .items,
                                        networkData: _networkData));
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
            Container(
              decoration: BoxDecoration(
                  color: kBgMarkham.withOpacity(.1),
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
//              physics: NeverScrollableScrollPhysics(),

              height: (isGridOff
                  ? screenHeight10p * 7 * cheap.length.toDouble()
                  : screenHeight10p * 13.6 * cheap.length.toDouble()),

              child: DefaultTabController(
                length: 3,
                child: Column(
                  children: [
                    Material(
                      child: TabBar(
                        indicator: BoxDecoration(
                            border: Border.all(color: kBgMarkham, width: 5),
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
                          StoreMainMenuTabBarView.productTabBarView(
                            context,
                            allProducts,
                            scrollController,
                            isGridOff,
                            nullImageUrl,
                            gridScrollController,
                          ),
                          StoreMainMenuTabBarView.productTabBarView(
                            context,
                            cheap,
                            scrollController,
                            isGridOff,
                            nullImageUrl,
                            gridScrollController,
                          ),
                          StoreMainMenuTabBarView.productTabBarView(
                            context,
                            expensive,
                            scrollController,
                            isGridOff,
                            nullImageUrl,
                            gridScrollController,
                          ),
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
}
