import 'package:e_grocery/src/pages/clothing_home_screens/foschini_home_screen.dart';
import 'package:e_grocery/src/pages/clothing_home_screens/markham_home_screen.dart';
import 'package:e_grocery/src/pages/clothing_home_screens/sportscene_home_screen.dart';
import 'package:e_grocery/src/pages/clothing_home_screens/superbalist_home_screen.dart';
import 'package:e_grocery/src/pages/clothing_home_screens/woolworths_clothing_home_screen.dart';
import 'package:flutter/material.dart';

class ClothingPageView extends StatelessWidget {
  final int pageNumber;

  ClothingPageView({this.pageNumber});

  @override
  Widget build(BuildContext context) {
    PageController _controller = PageController(initialPage: pageNumber);

    return Container(
      child: PageView(controller: _controller, children: [
        FoschiniHomeScreen(),
        SportsceneHomeScreen(),
        MarkhamHomeScreen(),
        SuperbalistHomeScreen(),
        WoolworthsClothingHomeScreen(),
      ]),
    );
  }
}
