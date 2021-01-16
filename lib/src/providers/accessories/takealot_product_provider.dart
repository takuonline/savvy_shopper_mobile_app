import 'package:e_grocery/src/networking/accessories/takealot_data.dart';
import 'package:e_grocery/src/networking/connection_test.dart';
import 'package:flutter/material.dart';

class TakealotAllProductList with ChangeNotifier {
  dynamic _data;

  dynamic get data {
    return _data;
  }

  Future<void> getItems() async {
    if (await TestConnection.checkForConnection()) {
      TakealotData _networkData = TakealotData();
      dynamic data = await _networkData.getData();

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
