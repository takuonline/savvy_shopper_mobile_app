//import 'dart:convert';
//import 'package:flutter/material.dart';
//
//class ShopriteProductNameList with ChangeNotifier {
//  List<String> _titles = [];
//
//  List<String> get titles {
//    return [..._titles];
//  }
//
//  void getProductNameList(data, BuildContext context) {
//    if (data != null) {
//
//      List<dynamic> _allProducts = jsonDecode(data["all_products"]);
//      _titles = _allProducts.map((e) => e.toString()).toList();
//
//    }
//
//    notifyListeners();
//  }
//}
//
//
