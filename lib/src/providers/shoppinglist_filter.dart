import 'package:e_grocery/src/components/grocery_shoppinglist/grocery_shoppinglist_search.dart';
import 'package:e_grocery/src/providers/grocery/pnp_product_provider.dart';
import 'package:e_grocery/src/providers/grocery/shoprite_product_provider.dart';
import 'package:e_grocery/src/providers/grocery/woolies_product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GroceryShoppingListFilter with ChangeNotifier {
  Map<String, bool> _data = {"shoprite": true, "pnp": true, "woolies": true};
  List<StoreAndTitle> _storeTitlesList = [];

  Map<String, bool> get getData => _data;

  List<StoreAndTitle> get getStoreTitlesList => _storeTitlesList;

  void setData(String store, bool value) {
    _data['$store'] = value;
  }

  void getCombinedList(BuildContext context) {
    List<StoreAndTitle> _pnpTitles = Provider
        .of<PnPAllProductList>(context, listen: false)
        .titles
        .map((e) => StoreAndTitle("Pick n Pay", e))
        .toList();
    List<StoreAndTitle> _shopriteTitles = Provider
        .of<ShopriteAllProductList>(context, listen: false)
        .titles
        .map((e) => StoreAndTitle("Shoprite", e))
        .toList();
    List<StoreAndTitle> _wooliesTitles = Provider
        .of<WooliesAllProductList>(context, listen: false)
        .titles
        .map((e) => StoreAndTitle("Woolworths", e))
        .toList();

    List<StoreAndTitle> shuffledList = [];

    if (Provider
        .of<GroceryShoppingListFilter>(context, listen: false)
        .getData['pnp']) {
      shuffledList += _pnpTitles;
    }

    if (Provider.of<GroceryShoppingListFilter>(context, listen: false)
        .getData['shoprite']) {
      shuffledList += _shopriteTitles;
    }

    if (Provider.of<GroceryShoppingListFilter>(context, listen: false)
        .getData['woolies']) {
      shuffledList += _wooliesTitles;
    }

    shuffledList.shuffle();
    _storeTitlesList = shuffledList;
    notifyListeners();
  }
}
