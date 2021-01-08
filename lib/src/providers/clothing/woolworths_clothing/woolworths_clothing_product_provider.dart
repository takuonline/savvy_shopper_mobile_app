import 'package:e_grocery/src/networking/clothing/superbalist_data.dart';
import 'package:e_grocery/src/networking/clothing/woolworths_clothing_data.dart';
import 'package:e_grocery/src/networking/connection_test.dart';
import 'package:flutter/material.dart';

class WoolworthsClothingAllProductList with ChangeNotifier {
  dynamic _data;

  dynamic get data {
    return _data;
  }

  Future<void> getItems() async {
    if (await TestConnection.checkForConnection()) {
      WoolworthsClothingData _networkData = WoolworthsClothingData();
      dynamic data = await _networkData.getData();

      _data = data;
      notifyListeners();
    }
  }

//  void addToWishList(String value) {
//    _items.add(value);
//    notifyListeners();
//  }
}
