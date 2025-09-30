//import 'dart:convert';
//
//import 'package:e_grocery/src/networking/connection_test.dart';
//import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
//
//class AllGroceryStoresData with ChangeNotifier {
//  dynamic _dataShoprite;
//
//  dynamic _dataPnP;
//
//  dynamic _dataWoolies;
//
//  Map<String, dynamic> get data =>
//      {"shoprite": _dataShoprite, "pnp": _dataPnP, "woolies": _dataWoolies};
//
////  Future<void> getAllStoresData() async {
////    if (await TestConnection.checkForConnection()) {
////
////    }
////    notifyListeners();
////  }
//
//  List<String> getStoreProductNameList(data, BuildContext context) {
//    if (data != null) {
//      List<dynamic> _allProducts = jsonDecode(data["all_products"]);
//      return _allProducts.map((e) => e.toString()).toList();
//    } else {
//      print('data is null');
//    }
//  }
//}
