import 'package:e_grocery/src/pages/pnp_welcome_screen.dart';
import 'package:e_grocery/src/pages/shoprite_product_graph.dart';
import 'package:e_grocery/src/pages/shoprite_welcome_screen.dart';
import 'package:e_grocery/src/pages/woolworths_welcome_screen.dart';
import 'package:e_grocery/src/providers/shoprite_product_name_provider.dart';
import 'package:e_grocery/src/providers/shoprite_product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/pages/home.dart';
import 'package:e_grocery/src/pages/shoprite_home_screen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value:ProductNameList() ,
        ),
        ChangeNotifierProvider.value(
          value:AllProductList() ,
        ),
      ],
      child: MaterialApp(
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
        initialRoute: HomePage.id,
        routes: {
          HomePage.id: (context) => HomePage(),
          ShopriteWelcomeScreen.id:(context) => ShopriteWelcomeScreen(),
          PnPWelcomeScreen.id:(context) => PnPWelcomeScreen(),
          WoolworthsWelcomeScreen.id:(context) => WoolworthsWelcomeScreen(),

          ShopriteHomeScreen.id:(context) => ShopriteHomeScreen(),
          ShopriteProductGraph.id:(context) => ShopriteProductGraph(),
        },

      ),
    );
  }
}


