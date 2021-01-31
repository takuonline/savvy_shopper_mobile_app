import 'dart:convert';

import 'package:e_grocery/src/networking/connection_test.dart';
import 'package:e_grocery/src/networking/pnp_data.dart';
import 'package:flutter/material.dart';

class PnPAllProductList with ChangeNotifier {
  dynamic _data;

  List<String> _titles = [];

  List<String> get titles => [..._titles];

  dynamic get data => _data;

  Future<void> getItems() async {
    if (await TestConnection.checkForConnection()) {
      PnPData _pnpData = PnPData();
      dynamic data = await _pnpData.getData();
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

//  void addToWishList(String value) {
//    _items.add(value);
//    notifyListeners();
//  }
}
