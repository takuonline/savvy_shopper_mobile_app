import 'dart:convert';

import 'package:e_grocery/src/networking/connection_test.dart';
import 'package:e_grocery/src/networking/woolies_data.dart';
import 'package:flutter/material.dart';

class WooliesAllProductList with ChangeNotifier {
  dynamic _data ;

  dynamic get data {
    return _data;
  }


  Future<void> getItems () async {
    if(await TestConnection.checkForConnection()){

      WooliesData _wooliesdata = WooliesData();
      dynamic data = await _wooliesdata.getData();

      _data = data;
      notifyListeners();
    }
  }

}


