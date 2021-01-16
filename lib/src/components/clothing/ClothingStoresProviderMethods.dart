import 'package:e_grocery/src/networking/connection_test.dart';
import 'package:e_grocery/src/providers/accessories/computermania_product_provider.dart';
import 'package:e_grocery/src/providers/accessories/hifi_product_provider.dart';
import 'package:e_grocery/src/providers/accessories/takealot_product_provider.dart';
import 'package:e_grocery/src/providers/clothing/foschini/foschini_product_provider.dart';
import 'package:e_grocery/src/providers/clothing/markham/markham_product_provider.dart';
import 'package:e_grocery/src/providers/clothing/sportscene/sportscene_product_provider.dart';
import 'package:e_grocery/src/providers/clothing/superbalist/superbalist_product_provider.dart';
import 'package:e_grocery/src/providers/clothing/woolworths_clothing/woolworths_clothing_product_provider.dart';
import 'package:provider/provider.dart';

class ClothingStoresProviderMethods {
  static Future<void> checkNullAndGetAllProductData(context) async {
    if (await TestConnection.checkForConnection()) {
      if (Provider.of<FoschiniAllProductList>(context, listen: false).data ==
          null) {
        await Provider.of<FoschiniAllProductList>(context, listen: false)
            .getItems();
      }

      if (Provider.of<MarkhamAllProductList>(context, listen: false).data ==
          null) {
        await Provider.of<MarkhamAllProductList>(context, listen: false)
            .getItems();
      }
      if (Provider.of<SportsceneAllProductList>(context, listen: false).data ==
          null) {
        await Provider.of<SportsceneAllProductList>(context, listen: false)
            .getItems();
      }

      if (Provider.of<SuperbalistAllProductList>(context, listen: false).data ==
          null) {
        await Provider.of<SuperbalistAllProductList>(context, listen: false)
            .getItems();
      }

      if (Provider.of<WoolworthsClothingAllProductList>(context, listen: false)
              .data ==
          null) {
        await Provider.of<WoolworthsClothingAllProductList>(context,
                listen: false)
            .getItems();
      }
    } else {
      TestConnection.showNoNetworkDialog(context);
    }
  }
}
