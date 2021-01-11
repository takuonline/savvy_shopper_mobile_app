import 'package:flutter/material.dart';
import 'package:e_grocery/src/components/grocery_shoppinglist/grocery_shoppinglist_item.dart';

class GroceryShoppingList with ChangeNotifier {
  List<GroceryShoppingListItem> _items = [];

  List<GroceryShoppingListItem> get items {
    return _items;
  }

  void addToGroceryShoppingList(GroceryShoppingListItem value) {
    if (!items.contains(value)) {
      _items.add(value);
    }

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
