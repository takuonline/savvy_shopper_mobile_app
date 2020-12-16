import 'package:e_grocery/src/providers/shoprite_product_name_provider.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';


class ShoeSearch extends SearchDelegate {
  @override
  TextStyle get searchFieldStyle => TextStyle(
    color: Colors.white,
  );
  @override
  TextInputAction get textInputAction => TextInputAction.unspecified;

  @override
  ThemeData appBarTheme(BuildContext context) {
    return ThemeData(
      primarySwatch: Colors.red,
      textTheme: TextTheme(headline6: TextStyle(

          fontFamily: "Montserrat",
          fontSize: 16,
          color: Colors.white)),
      appBarTheme: AppBarTheme(elevation: 0, shadowColor: Colors.transparent),
    );


  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return Container(
      child: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
//          Navigator.pushReplacementNamed(context, MenuPage.id);
        },
      ),
    );
  }

  @override
  Widget buildResults(
      BuildContext context,
      ) {
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var _providerData = Provider.of<ProductNameList>(context);
    final results = _providerData.items
        .where(
          (product) => product.toLowerCase().contains(
        query.toLowerCase(),
      ),
    )
        .toList();

    return (query == '')
        ? Container()
        : ListView.builder(
        itemCount: results.length,
        itemBuilder: (context, index) =>
            ListTile(
          title: Text(
            results[index],
            style: TextStyle(color: Colors.black87),
          ),

          onTap: () {
            String _product = results[index];
            print(_product);
            close(context, results[index]);


          },
          focusColor: Colors.red,
        ));
  }
}