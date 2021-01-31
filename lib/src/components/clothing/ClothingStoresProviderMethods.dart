import 'package:e_grocery/src/networking/connection_test.dart';
import 'package:e_grocery/src/providers/clothing/foschini_product_provider.dart';
import 'package:e_grocery/src/providers/clothing/markham_product_provider.dart';
import 'package:e_grocery/src/providers/clothing/sportscene_product_provider.dart';
import 'package:e_grocery/src/providers/clothing/superbalist_product_provider.dart';
import 'package:e_grocery/src/providers/clothing/woolworths_clothing_product_provider.dart';
import 'package:provider/provider.dart';

class ClothingStoresProviderMethods {
  static Future<void> checkNullAndGetAllProductData(context) async {
    if (await TestConnection.checkForConnection()) {
      try {
        if (Provider.of<FoschiniAllProductList>(context, listen: false).data ==
            null) {
          await Provider.of<FoschiniAllProductList>(context, listen: false)
              .getItems();
        }
      } catch (e) {
        print(e);
      }

      try {
        if (Provider.of<MarkhamAllProductList>(context, listen: false).data ==
            null) {
          await Provider.of<MarkhamAllProductList>(context, listen: false)
              .getItems();
        }
      } catch (e) {
        print(e);
      }

      try {
        if (Provider.of<SportsceneAllProductList>(context, listen: false)
                .data ==
            null) {
          await Provider.of<SportsceneAllProductList>(context, listen: false)
              .getItems();
        }
      } catch (e) {
        print(e);
      }

      try {
        if (Provider.of<SuperbalistAllProductList>(context, listen: false)
                .data ==
            null) {
          await Provider.of<SuperbalistAllProductList>(context, listen: false)
              .getItems();
        }
      } catch (e) {
        print(e);
      }

      try {
        if (Provider.of<WoolworthsClothingAllProductList>(context,
                    listen: false)
                .data ==
            null) {
          await Provider.of<WoolworthsClothingAllProductList>(context,
                  listen: false)
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
