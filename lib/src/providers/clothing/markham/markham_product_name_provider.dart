//import 'dart:convert';
//
//import 'package:flutter/material.dart';
//
//class MarkhamProductNameList with ChangeNotifier {
//  List<String> _items = [];
//
//  List<String> get items {
//    return [..._items];
//  }
//
//  void getProductNameList(data, BuildContext context) {
//    if (data != null) {
//      List<dynamic> _allProducts = jsonDecode(data["all_products"]);
//      _items = _allProducts.map((e) => e.toString()).toList();
//    }
//
//    notifyListeners();
//  }
//}
