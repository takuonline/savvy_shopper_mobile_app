import 'package:e_grocery/src/components/grid_homescreen_product_card/product_card_white.dart';
import 'package:e_grocery/src/components/product_item.dart';
import 'package:e_grocery/src/constants/constants.dart';
import 'package:e_grocery/src/pages/clothing/foschini_product_graph.dart';
import 'package:flutter/material.dart';

class StoreMainMenuTabBarView {
  static ListView productTabBarView(
    BuildContext context,
    List<ProductItem> itemList,
    ScrollController _scrollController,
    bool _isGridOff,
    String _nullImageUrl,
    ScrollController _gridScrollController,

//List of stores that make use of this class are:
//  - foschini
//  - markham
//  - superbalist
//  - sportscene

//  the classes need to have certain characteristic:
//  make use Prodcut card
//
  ) {
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
        if (_isGridOff)
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
                  MaterialStateProperty.all(kBgWoolies.withOpacity(.3)),
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
                      DataCell(Image.network(product.imageUrl ?? _nullImageUrl),
                          onTap: () => product.imageUrl == null
                              ? null
                              : _showDialog(product, context, _nullImageUrl)),
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
                                FoschiniProductGraph(productItem: product),
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
                                FoschiniProductGraph(productItem: product),
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
                                FoschiniProductGraph(productItem: product),
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
            controller: _gridScrollController,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: GridView.builder(
                  controller: _gridScrollController,
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
                                    builder: (context) => FoschiniProductGraph(
                                        productItem: itemList[index]),
                                  ),
                                ),
                                child: ProductCardWhite(
                                  index: index,
                                  cheap: itemList,
                                  shopriteNullImageUrl: _nullImageUrl,
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
                                          FoschiniProductGraph(
                                              productItem: itemList[index]),
                                    ),
                                  ),
                                  child: ProductCardWhite(
                                    index: index,

                                    cheap: itemList,
                                    shopriteNullImageUrl: _nullImageUrl,
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

  static Future<void> _showDialog(
      ProductItem product, BuildContext context, _nullImageUrl) async {
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
                      product.imageUrl ?? _nullImageUrl,
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
          ),
        );
      },
    );
  }
}
