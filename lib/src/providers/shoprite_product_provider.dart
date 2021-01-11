import 'dart:convert';

import 'package:e_grocery/src/networking/connection_test.dart';
import 'package:e_grocery/src/networking/shoprite_data.dart';
import 'package:flutter/material.dart';

class ShopriteAllProductList with ChangeNotifier {
  dynamic _data;

  dynamic get data {
    return _data;
  }

  Future<void> getItems() async {
    if (await TestConnection.checkForConnection()) {
      ShopriteData _shopritedata = ShopriteData();
      dynamic data = await _shopritedata.getData();

      _data = data;
      notifyListeners();
    }
  }

  void addData(dynamic value) {
    value == null ? print("values is null : $value") : _data = value;
  }

//  void addToWishList(String value) {
//    _items.add(value);
//    notifyListeners();
//  }
}
