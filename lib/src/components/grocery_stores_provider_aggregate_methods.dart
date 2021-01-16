import 'package:e_grocery/src/networking/connection_test.dart';
import 'package:e_grocery/src/providers/pnp_product_provider.dart';
import 'package:e_grocery/src/providers/shoprite_product_provider.dart';
import 'package:e_grocery/src/providers/woolies_product_provider.dart';
import 'package:provider/provider.dart';

class GroceryStoresProviderMethods {
  static Future<void> checkNullAndGetAllProductData(context) async {
    if (await TestConnection.checkForConnection()) {
      if (Provider.of<ShopriteAllProductList>(context, listen: false).data ==
          null) {
        await Provider.of<ShopriteAllProductList>(context, listen: false)
            .getItems();
      }
      if (Provider.of<PnPAllProductList>(context, listen: false).data == null) {
        await Provider.of<PnPAllProductList>(context, listen: false).getItems();
      }
      if (Provider.of<WooliesAllProductList>(context, listen: false).data ==
          null) {
        await Provider.of<WooliesAllProductList>(context, listen: false)
            .getItems();
      }
    } else {
      TestConnection.showNoNetworkDialog(context);
    }
  }
}
