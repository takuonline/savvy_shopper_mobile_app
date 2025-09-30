import 'package:e_grocery/src/components/homescreen_components/best_buy_product_name.dart';
import 'package:e_grocery/src/constants/constants.dart';
import 'package:flutter/material.dart';

class BestBuys extends StatelessWidget {
  const BestBuys({
    Key key,
    @required this.bestBuys,
    this.color,
  }) : super(key: key);

  final List bestBuys;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final double _horizontalPadding = 20.0;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _horizontalPadding),
      child: Container(
        decoration: BoxDecoration(
            color: color ?? kBgFoschini.withOpacity(.1),
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
    );
  }
}
