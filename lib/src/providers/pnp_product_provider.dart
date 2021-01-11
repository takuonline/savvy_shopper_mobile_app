import 'dart:convert';

import 'package:e_grocery/src/networking/connection_test.dart';
import 'package:e_grocery/src/networking/pnp_data.dart';
import 'package:flutter/material.dart';

class PnPAllProductList with ChangeNotifier {
  dynamic _data ;

  dynamic get data {
    return _data;
  }

  Future<void> getItems() async {
    if (await TestConnection.checkForConnection()) {
      PnPData _pnpData = PnPData();
      dynamic data = await _pnpData.getData();

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


