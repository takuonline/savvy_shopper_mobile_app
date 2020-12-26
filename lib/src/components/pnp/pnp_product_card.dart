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
  final _pnpNullImageUrl ='https://www.pnp.co.za/pnpstorefront/_ui/responsive/theme-blue/images/missing_product_EN_400x400.jpg';
  final _badImageUrl = "/pnpstorefront/_ui/responsive/theme-blue/images/missing_product_EN_140x140.jpg";
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenHeight10p = screenHeight*(10/MediaQuery.of(context).size.height);
    final screenWidth10p =screenWidth* (10/MediaQuery.of(context).size.width);

    return Card(
      elevation: 0,
      margin: EdgeInsets.only(top:  screenHeight*.01,bottom:  screenHeight*.01,),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(gridCardBorderRadius)),
      color: Colors.white,
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
                            color: kBgPnP.withOpacity(0),
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
                  child:

                  cheap[index].imageUrl == _badImageUrl ? Image.network(_pnpNullImageUrl)  :
                  Image.network(
                    cheap[index].imageUrl ?? shopriteNullImageUrl,
                    height:  screenHeight*.35,
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
                  height:  screenHeight*.015,
                ),
                FittedBox(
                  child: Text(
                    "Price:  R${cheap[index].prices[cheap[index].prices.length - 1]}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w700,
                      fontSize: screenWidth10p*1.5,
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight*.013,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal:  screenWidth10p*1),
                  child: Text(
                    "${cheap[index].title}",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w400,
                      fontSize: screenWidth10p*1.2,
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
  }
}
