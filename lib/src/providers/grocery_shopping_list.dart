import 'dart:convert';

import 'package:e_grocery/src/components/grocery_shoppinglist/grocery_shoppinglist_item.dart';
import 'package:e_grocery/src/components/product_item.dart';
import 'package:e_grocery/src/providers/shoprite_product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GroceryShoppingList with ChangeNotifier {
  List<GroceryShoppingListItem> _items = [];

  List<GroceryShoppingListItem> get items {
    return [..._items];
  }

  void addToGroceryShoppingList(value) {
    _items.add(value);
    notifyListeners();
  }

  void dropItemGroceryShoppingList(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void clearGroceryShoppingList() {
    _items.clear();
    notifyListeners();
  }
}
