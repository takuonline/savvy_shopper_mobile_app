import 'dart:convert';

import 'package:e_grocery/src/networking/clothing/superbalist_data.dart';
import 'package:e_grocery/src/networking/clothing/woolworths_clothing_data.dart';
import 'package:e_grocery/src/networking/connection_test.dart';
import 'package:flutter/material.dart';

class WoolworthsClothingAllProductList with ChangeNotifier {
  dynamic _data;
  List<String> _items = [];

  List<String> get items => [..._items];

  dynamic get data {
    return _data;
  }

  Future<void> getItems() async {
    if (await TestConnection.checkForConnection()) {
      WoolworthsClothingData _networkData = WoolworthsClothingData();
      dynamic data = await _networkData.getData();

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
