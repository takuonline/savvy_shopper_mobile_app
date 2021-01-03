import 'dart:convert';

import 'package:e_grocery/src/providers/shoprite_product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GroceryShoppingList with ChangeNotifier {
  List<String> _items = [];

  List<String> get items {
    return [..._items];
  }

  void getGroceryShoppingList(value) {
    _items.add(value);

    notifyListeners();
  }
}
