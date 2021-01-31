import 'package:e_grocery/src/networking/connection_test.dart';
import 'package:e_grocery/src/providers/grocery/pnp_product_provider.dart';
import 'package:e_grocery/src/providers/grocery/shoprite_product_provider.dart';
import 'package:e_grocery/src/providers/grocery/woolies_product_provider.dart';
import 'package:provider/provider.dart';

class GroceryStoresProviderMethods {
  static Future<void> checkNullAndGetAllProductData(context) async {
    if (await TestConnection.checkForConnection()) {
      try {
        if (Provider.of<ShopriteAllProductList>(context, listen: false).data ==
            null) {
          await Provider.of<ShopriteAllProductList>(context, listen: false)
              .getItems();
        }
      } catch (e) {
        print(e);
      }

      try {
        if (Provider.of<PnPAllProductList>(context, listen: false).data ==
            null) {
          await Provider.of<PnPAllProductList>(context, listen: false)
              .getItems();
        }
      } catch (e) {
        print(e);
      }

      try {
        if (Provider.of<WooliesAllProductList>(context, listen: false).data ==
            null) {
          await Provider.of<WooliesAllProductList>(context, listen: false)
              .getItems();
        }
      } catch (e) {
        print(e);
      }
    } else {
      TestConnection.showNoNetworkDialog(context);
    }
  }
}
