import 'package:e_grocery/src/networking/connection_test.dart';
import 'package:e_grocery/src/providers/accessories/computermania_product_provider.dart';
import 'package:e_grocery/src/providers/accessories/hifi_product_provider.dart';
import 'package:e_grocery/src/providers/accessories/takealot_product_provider.dart';
import 'package:provider/provider.dart';

class AccessoriesStoresProviderMethods {
  static Future<void> checkNullAndGetAllProductData(context) async {
    if (await TestConnection.checkForConnection()) {
      if (Provider.of<TakealotAllProductList>(context, listen: false).data ==
          null) {
        await Provider.of<TakealotAllProductList>(context, listen: false)
            .getItems();
      }
      if (Provider.of<HifiAllProductList>(context, listen: false).data ==
          null) {
        await Provider.of<HifiAllProductList>(context, listen: false)
            .getItems();
      }
      if (Provider.of<ComputermaniaAllProductList>(context, listen: false)
              .data ==
          null) {
        await Provider.of<ComputermaniaAllProductList>(context, listen: false)
            .getItems();
      }
    } else {
      TestConnection.showNoNetworkDialog(context);
    }
  }
}
