import 'package:device_preview/device_preview.dart';
import 'package:e_grocery/locator.dart';
import 'package:e_grocery/src/pages/accessories_home.dart';
import 'package:e_grocery/src/pages/accessories_home_screens/computermania_home_screen.dart';
import 'package:e_grocery/src/pages/accessories_home_screens/hifi_home_screen.dart';
import 'package:e_grocery/src/pages/accessories_home_screens/takealot_home_screen.dart';
import 'package:e_grocery/src/pages/accessories_product_graph/accessories_product_graph.dart';
import 'package:e_grocery/src/pages/clothing_home.dart';
import 'package:e_grocery/src/pages/clothing_home_screens/foschini_home_screen.dart';
import 'package:e_grocery/src/pages/clothing_home_screens/markham_home_screen.dart';
import 'package:e_grocery/src/pages/clothing_home_screens/sportscene_home_screen.dart';
import 'package:e_grocery/src/pages/clothing_home_screens/superbalist_home_screen.dart';
import 'package:e_grocery/src/pages/clothing_home_screens/woolworths_clothing_home_screen.dart';
import 'package:e_grocery/src/pages/clothing_product_graph/foschini_product_graph.dart';
import 'package:e_grocery/src/pages/clothing_product_graph/woolworths_clothing_product_graph.dart';
import 'package:e_grocery/src/pages/main_menu.dart';
import 'package:e_grocery/src/pages/groceries_home_screens/pnp_home_screen.dart';
import 'package:e_grocery/src/pages/groceries_product_graph/pnp_product_graph.dart';
import 'package:e_grocery/src/pages/shopping_list.dart';
import 'package:e_grocery/src/pages/groceries_product_graph/shoprite_product_graph.dart';
import 'package:e_grocery/src/pages/groceries_home_screens/woolies_home_screen.dart';
import 'package:e_grocery/src/providers/accessories/computermania_product_provider.dart';
import 'package:e_grocery/src/providers/accessories/hifi_product_provider.dart';
import 'package:e_grocery/src/providers/accessories/takealot_product_provider.dart';
import 'package:e_grocery/src/pages/groceries_product_graph/woolies_product_graph.dart';
import 'package:e_grocery/src/providers/clothing/markham_product_provider.dart';
import 'package:e_grocery/src/providers/clothing/sportscene_product_provider.dart';
import 'package:e_grocery/src/providers/clothing/foschini_product_provider.dart';
import 'package:e_grocery/src/providers/clothing/superbalist_product_provider.dart';
import 'package:e_grocery/src/providers/clothing/woolworths_clothing_product_provider.dart';
import 'package:e_grocery/src/providers/grocery_shopping_list.dart';
import 'package:e_grocery/src/providers/grocery/pnp_product_provider.dart';
import 'package:e_grocery/src/providers/shoppinglist_filter.dart';
import 'package:e_grocery/src/providers/grocery/shoprite_product_provider.dart';
import 'package:e_grocery/src/providers/grocery/woolies_product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:e_grocery/src/pages/groceries_home.dart';
import 'package:e_grocery/src/pages/groceries_home_screens/shoprite_home_screen.dart';

void main() {
  setupLocator();

  runApp(
//    SystemChrome.setEnabledSystemUIOverlays ([SystemUiOverlay.top]);

// to hide only status bar:

// to hide both:

//for preview there are two parts---first uncomment here below including the last parentheses
//  DevicePreview(
//    enabled: true,
//    builder: (context) =>
    MyApp(), // Wrap your app
//  ),
  );
}

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
//    SystemChrome.setEnabledSystemUIOverlays ([SystemUiOverlay.bottom]);
    return MultiProvider(
      providers: [

        ChangeNotifierProvider(create: (_) => GroceryShoppingListFilter()),

        ChangeNotifierProvider(create: (_) => ShopriteAllProductList()),

        ChangeNotifierProvider(create: (_) => PnPAllProductList()),

        ChangeNotifierProvider(create: (_) => WooliesAllProductList()),

        ChangeNotifierProvider(create: (_) => GroceryShoppingList()),

        ChangeNotifierProvider(create: (_) => FoschiniAllProductList()),

        ChangeNotifierProvider(create: (_) => SportsceneAllProductList()),

        ChangeNotifierProvider(create: (_) => SuperbalistAllProductList()),

        ChangeNotifierProvider(create: (_) => MarkhamAllProductList()),

        ChangeNotifierProvider(
            create: (_) => WoolworthsClothingAllProductList()),

        ChangeNotifierProvider(create: (_) => TakealotAllProductList()),

        ChangeNotifierProvider(create: (_) => HifiAllProductList()),

        ChangeNotifierProvider(create: (_) => ComputermaniaAllProductList()),

      ],
      child: MaterialApp(
//          ---second part here uncomment here - -two lines
//        locale: DevicePreview.locale(context), // Add the locale here
//        builder: DevicePreview.appBuilder,
        title: "Savvy shopper",

        theme: ThemeData(
          bottomSheetTheme: BottomSheetThemeData(
              backgroundColor: Colors.transparent),
          fontFamily: "Montserrat",

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
          AccessoriesHome.id: (context) => AccessoriesHome(),
          TakealotHomeScreen.id: (context) => TakealotHomeScreen(),
          HifiHomeScreen.id: (context) => HifiHomeScreen(),
          ComputermaniaHomeScreen.id: (context) => ComputermaniaHomeScreen(),
          AccessoriesProductGraph.id: (context) => AccessoriesProductGraph(),
        },


      ),
    );
  }
}


