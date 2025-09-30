import 'package:e_grocery/src/networking/connection_test.dart';
import 'package:e_grocery/src/providers/clothing/foschini_product_provider.dart';
import 'package:e_grocery/src/providers/clothing/markham_product_provider.dart';
import 'package:e_grocery/src/providers/clothing/sportscene_product_provider.dart';
import 'package:e_grocery/src/providers/clothing/superbalist_product_provider.dart';
import 'package:e_grocery/src/providers/clothing/woolworths_clothing_product_provider.dart';
import 'package:provider/provider.dart';

class ClothingStoresProviderMethods {
  static _runGetItems(storeProvider) async {
    try {
      if (storeProvider.data == null) {
        await storeProvider.getItems();
      }
    } catch (e) {
      print(e);
    }
  }

  static Future<void> checkNullAndGetAllProductData(context) async {
    if (await TestConnection.checkForConnection()) {
      await _runGetItems(
          Provider.of<FoschiniAllProductList>(context, listen: false));
      await _runGetItems(
          Provider.of<MarkhamAllProductList>(context, listen: false));
      await _runGetItems(
          Provider.of<SportsceneAllProductList>(context, listen: false));
      await _runGetItems(
          Provider.of<SuperbalistAllProductList>(context, listen: false));
      await _runGetItems(Provider.of<WoolworthsClothingAllProductList>(context,
          listen: false));
    } else {
      TestConnection.showNoNetworkDialog(context);
    }
  }
}
