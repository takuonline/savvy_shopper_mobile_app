import 'dart:convert';

import 'package:e_grocery/src/networking/shoprite_data.dart';
import 'package:flutter/material.dart';

class AllProductList with ChangeNotifier {
  dynamic _data;

  dynamic get data {
    return _data;
  }


  void getItems () async {
    ShopriteData _shopritedata = ShopriteData();
    dynamic data = await _shopritedata.getData();

    _data = data;
    notifyListeners();
  }

//  void addToWishList(String value) {
//    _items.add(value);
//    notifyListeners();
//  }
}


