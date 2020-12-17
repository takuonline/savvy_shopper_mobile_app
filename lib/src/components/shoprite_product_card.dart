import 'package:e_grocery/src/components/product_item.dart';
import 'package:e_grocery/src/constants/constants.dart';
import "package:flutter/material.dart";

class ProductCard extends StatelessWidget {
  List<ProductItem> cheap;
  String shopriteNullImageUrl;
  int index;
  ProductItem product;

  ProductCard(
      {this.cheap, this.shopriteNullImageUrl, this.index, this.product});

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
