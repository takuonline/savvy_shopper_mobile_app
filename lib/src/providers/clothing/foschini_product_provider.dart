import 'dart:convert';

import 'package:e_grocery/src/networking/clothing/foschini_data.dart';
import 'package:e_grocery/src/networking/connection_test.dart';
import 'package:flutter/material.dart';

class FoschiniAllProductList with ChangeNotifier {
  dynamic _data;
  List<String> _items = [];

  dynamic get data => _data;

  List<String> get items => [..._items];

  Future<void> getItems() async {
    if (await TestConnection.checkForConnection()) {
      FoschiniData _foschiniData = FoschiniData();
      dynamic data = await _foschiniData.getData();
      _data = data;
      getProductNameList();
      notifyListeners();
    }
  }

  void getProductNameList() {
    if (data != null) {
      List<dynamic> _allProducts = jsonDecode(data["all_products"]);

      _items = _allProducts.map((e) => e.toString()).toList();
    }

    notifyListeners();
  }
}
