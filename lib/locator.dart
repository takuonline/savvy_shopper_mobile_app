import 'package:e_grocery/src/providers/clothing/foschini_product_provider.dart';
import 'package:e_grocery/src/providers/clothing/markham_product_provider.dart';
import 'package:e_grocery/src/providers/clothing/sportscene_product_provider.dart';
import 'package:e_grocery/src/providers/clothing/superbalist_product_provider.dart';
import 'package:e_grocery/src/providers/clothing/woolworths_clothing_product_provider.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => FoschiniAllProductList());

  locator.registerLazySingleton(() => SportsceneAllProductList());

  locator.registerLazySingleton(() => SuperbalistAllProductList());

  locator.registerLazySingleton(() => MarkhamAllProductList());

  locator.registerLazySingleton(() => WoolworthsClothingAllProductList());
}
