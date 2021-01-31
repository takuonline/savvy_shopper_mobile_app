import 'dart:convert';

import 'package:e_grocery/src/networking/accessories/hifi_data.dart';
import 'package:e_grocery/src/networking/connection_test.dart';
import 'package:flutter/material.dart';

class HifiAllProductList with ChangeNotifier {
  dynamic _data;
  List<String> _titles = [];

  List<String> get titles {
    return [..._titles];
  }

  dynamic get data {
    return _data;
  }

  Future<void> getItems() async {
    if (await TestConnection.checkForConnection()) {
      HifiData _networkData = HifiData();
      dynamic data = await _networkData.getData();

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
