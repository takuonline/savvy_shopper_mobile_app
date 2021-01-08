import 'dart:convert';

import 'package:e_grocery/src/networking/connection_test.dart';
import 'package:e_grocery/src/networking/pnp_data.dart';
import 'package:e_grocery/src/networking/shoprite_data.dart';
import 'package:e_grocery/src/networking/woolies_data.dart';
import 'package:flutter/material.dart';

class AllGroceryStoresData with ChangeNotifier {
  dynamic _dataShoprite;

  dynamic _dataPnP;

  dynamic _dataWoolies;

  Map<String, dynamic> get data =>
      {"shoprite": _dataShoprite, "pnp": _dataPnP, "woolies": _dataWoolies};

  Future<void> getAllStoresData() async {
    if (await TestConnection.checkForConnection()) {
      ShopriteData _shopriteData = ShopriteData();
      dynamic dataShoprite = await _shopriteData.getData();
      _dataShoprite = dataShoprite;

      PnPData _pnpData = PnPData();
      dynamic dataPnP = await _pnpData.getData();
      _dataPnP = dataPnP;

      WooliesData _wooliesData = WooliesData();
      dynamic dataWoolies = await _wooliesData.getData();
      _dataWoolies = dataWoolies;
    }
    notifyListeners();
  }

  List<String> getStoreProductNameList(data, BuildContext context) {
    if (data != null) {
      List<dynamic> _allProducts = jsonDecode(data["all_products"]);
      return _allProducts.map((e) => e.toString()).toList();
    } else {
      print('data is null');
    }
  }
}
