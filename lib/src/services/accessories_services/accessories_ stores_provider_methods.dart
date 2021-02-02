import 'package:e_grocery/src/networking/connection_test.dart';
import 'package:e_grocery/src/providers/accessories/computermania_product_provider.dart';
import 'package:e_grocery/src/providers/accessories/hifi_product_provider.dart';
import 'package:e_grocery/src/providers/accessories/takealot_product_provider.dart';
import 'package:provider/provider.dart';

class AccessoriesStoresProviderMethods {
  static Future<void> _getStoreProductItems(storeProvider) async {
    try {
      if (storeProvider.data == null) {
        await storeProvider.getItems();
      }
    } catch (e) {}
  }

  static Future<void> checkNullAndGetAllProductData(context) async {
    if (await TestConnection.checkForConnection()) {
      _getStoreProductItems(
          Provider.of<TakealotAllProductList>(context, listen: false));
      _getStoreProductItems(
          Provider.of<HifiAllProductList>(context, listen: false));
      _getStoreProductItems(
          Provider.of<ComputermaniaAllProductList>(context, listen: false));
    } else {
      TestConnection.showNoNetworkDialog(context);
    }
  }
}
