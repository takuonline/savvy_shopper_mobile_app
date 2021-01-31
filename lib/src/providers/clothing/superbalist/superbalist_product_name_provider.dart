//import 'dart:convert';
//
//import 'file:///C:/Users/Taku/AndroidStudioProjects/e_grocery/lib/src/providers/grocery/shoprite_product_provider.dart';
//import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
//
//class SuperbalistProductNameList with ChangeNotifier {
//  List<String> _items = [];
//
//  List<String> get items {
//    return [..._items];
//  }
//
//  void getProductNameList(data, BuildContext context) {
//    if (data != null) {
//      List<dynamic> _allProducts = jsonDecode(data["all_products"]);
//
//      _items = _allProducts.map((e) => e.toString()).toList();
//    }
//
//    notifyListeners();
//  }
//}
