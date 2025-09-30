import 'package:e_grocery/src/networking/connection_test.dart';
import 'package:e_grocery/src/providers/grocery/pnp_product_provider.dart';
import 'package:e_grocery/src/providers/grocery/shoprite_product_provider.dart';
import 'package:e_grocery/src/providers/grocery/woolies_product_provider.dart';
import 'package:provider/provider.dart';

class GroceryStoresProviderMethods {
  static Future<void> _getStoreProductItems(storeProvider) async {
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
      _getStoreProductItems(
          Provider.of<ShopriteAllProductList>(context, listen: false));
      _getStoreProductItems(
          Provider.of<PnPAllProductList>(context, listen: false));
      _getStoreProductItems(
          Provider.of<WooliesAllProductList>(context, listen: false));
    } else {
      TestConnection.showNoNetworkDialog(context);
    }
  }
}
