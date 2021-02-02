import 'package:e_grocery/src/pages/groceries_home_screens/pnp_home_screen.dart';
import 'package:e_grocery/src/pages/groceries_home_screens/shoprite_home_screen.dart';
import 'package:e_grocery/src/pages/groceries_home_screens/woolies_home_screen.dart';
import 'package:flutter/material.dart';

class GroceryPageView extends StatelessWidget {
  final int pageNumber;

  GroceryPageView({this.pageNumber});

  @override
  Widget build(BuildContext context) {
    PageController _controller = PageController(initialPage: pageNumber);

    return Container(
        child: PageView(controller: _controller, children: [
      ShopriteHomeScreen(),
      PnPHomeScreen(),
      WooliesHomeScreen(),
    ]));
  }
}
