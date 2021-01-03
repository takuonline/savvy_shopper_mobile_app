import 'file:///C:/Users/Taku/AndroidStudioProjects/e_grocery/lib/src/deletables/pnp_welcome_screen.dart';
import 'package:e_grocery/src/pages/main_menu.dart';
import 'package:e_grocery/src/pages/pnp_home_screen.dart';
import 'package:e_grocery/src/pages/pnp_product_graph.dart';
import 'package:e_grocery/src/pages/shopping_list.dart';
import 'package:e_grocery/src/pages/shoprite_product_graph.dart';
import 'package:e_grocery/src/pages/woolies_home_screen.dart';
import 'package:e_grocery/src/pages/woolies_product_graph.dart';
import 'file:///C:/Users/Taku/AndroidStudioProjects/e_grocery/lib/src/deletables/shoprite_welcome_screen.dart';
import 'file:///C:/Users/Taku/AndroidStudioProjects/e_grocery/lib/src/deletables/woolworths_welcome_screen.dart';
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
import 'src/pages/home.dart';
import 'package:e_grocery/src/pages/shoprite_home_screen.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
//  final screenWidth = MediaQuery.of(context).size.width;
//  final screenHeight = MediaQuery.of(context).size.height;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
            value: GotData())
        ,
        ChangeNotifierProvider.value(
          value:ProductNameList() ,
        ),
        ChangeNotifierProvider.value(
          value: AllProductList(),
        ),
        ChangeNotifierProvider.value(value: PnPAllProductList()),
        ChangeNotifierProvider.value(value: PnPProductNameList()),
        ChangeNotifierProvider.value(value: WooliesAllProductList()),
        ChangeNotifierProvider.value(value: WooliesProductNameList()),
        ChangeNotifierProvider.value(value: GroceryShoppingList())
      ],
      child: MaterialApp(
//        locale: DevicePreview.locale(context), // Add the locale here
//        builder: DevicePreview.appBuilder,
//        title: 'Flutter Demo',
        theme: ThemeData(
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
          HomePage.id: (context) => HomePage(),
          ShopriteHomeScreen.id: (context) => ShopriteHomeScreen(),
          ShopriteProductGraph.id: (context) => ShopriteProductGraph(),
          PnPHomeScreen.id: (context) => PnPHomeScreen(),
          PnPProductGraph.id: (context) => PnPProductGraph(),
          WooliesHomeScreen.id: (context) => WooliesHomeScreen(),
          WooliesProductGraph.id: (context) => WooliesProductGraph(),
          MainMenu.id: (context) => MainMenu(),
          ShoppingList.id: (context) => ShoppingList(),
        },

      ),
    );
  }
}


