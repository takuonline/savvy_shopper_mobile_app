import 'package:e_grocery/src/pages/accessories_home_screens/computermania_home_screen.dart';
import 'package:e_grocery/src/pages/accessories_home_screens/hifi_home_screen.dart';
import 'package:e_grocery/src/pages/accessories_home_screens/takealot_home_screen.dart';
import 'package:flutter/material.dart';

class AccessoriesPageView extends StatelessWidget {
  final int pageNumber;

  AccessoriesPageView({this.pageNumber});

  @override
  Widget build(BuildContext context) {
    PageController _controller = PageController(initialPage: pageNumber);

    return Container(
      child: PageView(controller: _controller, children: [
        TakealotHomeScreen(),
        HifiHomeScreen(),
        ComputermaniaHomeScreen(),
      ]),
    );
  }
}
