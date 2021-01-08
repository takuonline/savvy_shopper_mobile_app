import 'package:e_grocery/src/networking/clothing/foschini_data.dart';
import 'package:e_grocery/src/networking/connection_test.dart';
import 'package:flutter/material.dart';

class FoschiniAllProductList with ChangeNotifier {
  dynamic _data;

  dynamic get data {
    return _data;
  }

  Future<void> getItems() async {
    if (await TestConnection.checkForConnection()) {
      FoschiniData _foschiniData = FoschiniData();
      dynamic data = await _foschiniData.getData();

      _data = data;
      notifyListeners();
    }
  }

//  void addToWishList(String value) {
//    _items.add(value);
//    notifyListeners();
//  }
}
