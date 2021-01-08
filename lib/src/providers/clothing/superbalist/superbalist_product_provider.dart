import 'package:e_grocery/src/networking/clothing/superbalist_data.dart';
import 'package:e_grocery/src/networking/connection_test.dart';
import 'package:flutter/material.dart';

class SuperbalistAllProductList with ChangeNotifier {
  dynamic _data;

  dynamic get data {
    return _data;
  }

  Future<void> getItems() async {
    if (await TestConnection.checkForConnection()) {
      SuperbalistData _sportsceneData = SuperbalistData();
      dynamic data = await _sportsceneData.getData();

      _data = data;
      notifyListeners();
    }
  }

//  void addToWishList(String value) {
//    _items.add(value);
//    notifyListeners();
//  }
}
