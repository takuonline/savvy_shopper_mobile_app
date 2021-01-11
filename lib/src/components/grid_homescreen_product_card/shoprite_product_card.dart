import 'package:e_grocery/src/components/product_item.dart';
import 'package:e_grocery/src/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";

class ProductCardRed extends StatelessWidget {
  final String shopriteNullImageUrl;

//final   int index;
  final ProductItem product;

  ProductCardRed({this.shopriteNullImageUrl, this.product});

  final double gridCardBorderRadius = 25;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenHeight10p =
        screenHeight * (10 / MediaQuery.of(context).size.height);
    final screenWidth10p =
        screenWidth * (10 / MediaQuery.of(context).size.width);

    return LayoutBuilder(
      builder: (_, constraints) {
        return Card(
          elevation: 0,
          margin: EdgeInsets.only(
            top: screenHeight * .01,
            bottom: screenHeight * .01,
          ),
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
                              color: kBgShoprite,
                              borderRadius: BorderRadius.only(
                                bottomRight:
                                    Radius.circular(gridCardBorderRadius),
                                topLeft: Radius.circular(gridCardBorderRadius),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 8,
                          child: Container(),
                        )
                      ],
                    ),
                    Positioned(
                      left: 20,
                      child: Container(
                        height: 1,
                        child: Image.network(
                          product.imageUrl ?? shopriteNullImageUrl,
                          height: constraints.maxHeight * .43,
                        ),
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
                      height: screenHeight * .015,
                    ),
                    FittedBox(
                      child: Text(
                        "Price:  R${product.prices.last}",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w700,
                          fontSize: screenWidth10p * 1.5,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight * .013,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth10p * 1),
                      child: Text(
                        "${product.title}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.w400,
                          fontSize: screenWidth10p * 1.2,
                        ),
                      ),
                    ),

//                SizedBox(
//                  height: screenHeight10p*,
//                ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
