import 'package:e_grocery/src/pages/clothing/foschini_product_graph.dart';
import 'package:e_grocery/src/pages/clothing/woolworths_clothing_product_graph.dart';
import 'package:e_grocery/src/pages/clothing_home.dart';
import 'package:e_grocery/src/pages/clothing_home_screens/foschini_home_screen.dart';
import 'package:e_grocery/src/pages/clothing_home_screens/markham_home_screen.dart';
import 'package:e_grocery/src/pages/clothing_home_screens/sportscene_home_screen.dart';
import 'package:e_grocery/src/pages/clothing_home_screens/superbalist_home_screen.dart';
import 'package:e_grocery/src/pages/clothing_home_screens/woolworths_clothing_home_screen.dart';
import 'package:e_grocery/src/pages/main_menu.dart';
import 'package:e_grocery/src/pages/groceries_home_screens/pnp_home_screen.dart';
import 'file:///C:/Users/Taku/AndroidStudioProjects/e_grocery/lib/src/pages/groceries_product_graph/pnp_product_graph.dart';
import 'package:e_grocery/src/pages/shopping_list.dart';
import 'file:///C:/Users/Taku/AndroidStudioProjects/e_grocery/lib/src/pages/groceries_product_graph/shoprite_product_graph.dart';
import 'package:e_grocery/src/pages/groceries_home_screens/woolies_home_screen.dart';
import 'package:e_grocery/src/providers/all_grocery_store_data_provider.dart';
import 'file:///C:/Users/Taku/AndroidStudioProjects/e_grocery/lib/src/pages/groceries_product_graph/woolies_product_graph.dart';
import 'package:e_grocery/src/providers/clothing/markham/markham_product_name_provider.dart';
import 'package:e_grocery/src/providers/clothing/markham/markham_product_provider.dart';
import 'package:e_grocery/src/providers/clothing/sportscene/sportscene_product_name_provider.dart';
import 'package:e_grocery/src/providers/clothing/sportscene/sportscene_product_provider.dart';
import 'package:e_grocery/src/providers/clothing/foschini/foschini_product_name_provider.dart';
import 'package:e_grocery/src/providers/clothing/foschini/foschini_product_provider.dart';
import 'package:e_grocery/src/providers/clothing/superbalist/superbalist_product_name_provider.dart';
import 'package:e_grocery/src/providers/clothing/superbalist/superbalist_product_provider.dart';
import 'package:e_grocery/src/providers/clothing/woolworths_clothing/woolworths_clothing_product_name_provider.dart';
import 'package:e_grocery/src/providers/clothing/woolworths_clothing/woolworths_clothing_product_provider.dart';
import 'package:e_grocery/src/providers/got_data_provider.dart';
import 'package:e_grocery/src/providers/grocery_shopping_list.dart';
import 'package:e_grocery/src/providers/pnp_product_name_provider.dart';
import 'package:e_grocery/src/providers/pnp_product_provider.dart';
import 'package:e_grocery/src/providers/shoprite_product_name_provider.dart';
import 'package:e_grocery/src/providers/shoprite_product_provider.dart';
import 'package:e_grocery/src/providers/woolies_product_name_provider.dart';
import 'package:e_grocery/src/providers/woolies_product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:e_grocery/src/pages/groceries_home.dart';
import 'package:e_grocery/src/pages/groceries_home_screens/shoprite_home_screen.dart';

void main() => runApp(
//    SystemChrome.setEnabledSystemUIOverlays ([SystemUiOverlay.top]);

// to hide only status bar:
//    SystemChrome.setEnabledSystemUIOverlays ([SystemUiOverlay.bottom]);

// to hide both:

//  DevicePreview(
//    enabled: true,
//    builder: (context) =>
        MyApp(), // Wrap your app
//  ),
);

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  // to hide only bottom bar:
//  SystemChrome.setEnabledSystemUIOverlays ([]);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: GotData())
        ,
        ChangeNotifierProvider.value(value: ShopriteProductNameList(),),
        ChangeNotifierProvider.value(value: ShopriteAllProductList(),),

        ChangeNotifierProvider.value(value: PnPAllProductList()),
        ChangeNotifierProvider.value(value: PnPProductNameList()),

        ChangeNotifierProvider.value(value: WooliesAllProductList()),
        ChangeNotifierProvider.value(value: WooliesProductNameList()),

        ChangeNotifierProvider.value(value: GroceryShoppingList()),
        ChangeNotifierProvider.value(value: AllGroceryStoresData()),


        ChangeNotifierProvider.value(value: FoschiniAllProductList()),
        ChangeNotifierProvider.value(value: FoschiniProductNameList()),

        ChangeNotifierProvider.value(value: SportsceneAllProductList()),
        ChangeNotifierProvider.value(value: SportsceneProductNameList()),

        ChangeNotifierProvider.value(value: SuperbalistAllProductList()),
        ChangeNotifierProvider.value(value: SuperbalistProductNameList()),

        ChangeNotifierProvider.value(value: MarkhamAllProductList()),
        ChangeNotifierProvider.value(value: MarkhamProductNameList()),

        ChangeNotifierProvider.value(value: WoolworthsClothingAllProductList()),
        ChangeNotifierProvider.value(
            value: WoolworthsClothingProductNameList()),
      ],
      child: MaterialApp(
//        locale: DevicePreview.locale(context), // Add the locale here
//        builder: DevicePreview.appBuilder,
//        title: 'Flutter Demo',
        theme: ThemeData(
          bottomSheetTheme: BottomSheetThemeData(
              backgroundColor: Colors.transparent),
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in thcd ee console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: MainMenu.id,
        routes: {
          GroceriesHomePage.id: (context) => GroceriesHomePage(),

          ShopriteHomeScreen.id: (context) => ShopriteHomeScreen(),
          ShopriteProductGraph.id: (context) => ShopriteProductGraph(),

          PnPHomeScreen.id: (context) => PnPHomeScreen(),
          PnPProductGraph.id: (context) => PnPProductGraph(),

          WooliesHomeScreen.id: (context) => WooliesHomeScreen(),
          WooliesProductGraph.id: (context) => WooliesProductGraph(),

          MainMenu.id: (context) => MainMenu(),
          ShoppingList.id: (context) => ShoppingList(),

          ClothingHome.id: (context) => ClothingHome(),
          FoschiniHomeScreen.id: (context) => FoschiniHomeScreen(),
          FoschiniProductGraph.id: (context) => FoschiniProductGraph(),

          SportsceneHomeScreen.id: (context) => SportsceneHomeScreen(),
          SuperbalistHomeScreen.id: (context) => SuperbalistHomeScreen(),
          MarkhamHomeScreen.id: (context) => MarkhamHomeScreen(),
          WoolworthsClothingHomeScreen.id: (context) =>
              WoolworthsClothingHomeScreen(),
          WoolworthsClothingProductGraph.id: (context) =>
              WoolworthsClothingProductGraph(),
        },

      ),
    );
  }
}


