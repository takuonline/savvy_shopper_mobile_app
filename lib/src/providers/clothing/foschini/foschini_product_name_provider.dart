import 'dart:convert';

import 'package:e_grocery/src/providers/shoprite_product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FoschiniProductNameList with ChangeNotifier {
  List<String> _items = [];

  List<String> get items {
    return [..._items];
  }

  void getProductNameList(data, BuildContext context) {
    if (data != null) {
      List<dynamic> _allProducts = jsonDecode(data["all_products"]);

      _items = _allProducts.map((e) => e.toString()).toList();
    }

    notifyListeners();
  }
}
