import 'dart:convert';

import 'package:e_grocery/src/networking/connection_test.dart';
import 'package:e_grocery/src/networking/grocery/woolies_data.dart';
import 'package:flutter/material.dart';

class WooliesAllProductList with ChangeNotifier {
  dynamic _data;

  List<String> _titles = [];

  dynamic get data => _data;

  List<String> get titles => [..._titles];

  Future<void> getItems() async {
    if (await TestConnection.checkForConnection()) {
      WooliesData _wooliesData = WooliesData();
      dynamic data = await _wooliesData.getData();
      _data = data;
      getProductNameList();
      notifyListeners();
    }
  }

  void addData(dynamic value) {
    value == null ? print("values is null : $value") : _data = value;
  }

  void getProductNameList() {
    if (data != null) {
      List<dynamic> _allProducts = jsonDecode(data["all_products"]);
      _titles = _allProducts.map((e) => e.toString()).toList();
    }
    notifyListeners();
  }
}
