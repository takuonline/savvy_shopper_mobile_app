import 'package:e_grocery/src/providers/shoppinglist_filter.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FilterDialog extends StatefulWidget {
  bool isShopriteChecked;
  bool isPnPChecked;
  bool isWooliesChecked;

  FilterDialog(
      this.isShopriteChecked, this.isPnPChecked, this.isWooliesChecked);

  @override
  _FilterDialogState createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenHeight10p =
        screenHeight * (10 / MediaQuery.of(context).size.height);
    final screenWidth10p =
        screenWidth * (10 / MediaQuery.of(context).size.width);

    bool isShopriteChecked =
        Provider.of<GroceryShoppingListFilter>(context).getData['shoprite'];
    bool isPnPChecked =
        Provider.of<GroceryShoppingListFilter>(context).getData['pnp'];
    bool isWooliesChecked =
        Provider.of<GroceryShoppingListFilter>(context).getData['woolies'];

    return ClipRRect(
      borderRadius: BorderRadius.circular(screenWidth10p * 1.5),
      child: Container(
//          height: screenHeight * .3,
//          width: screenWidth * .6,
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Material(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth10p * 1,
                      vertical: screenHeight10p * 1),
                  child: Column(
                    children: [
                      SizedBox(
                        height: screenHeight10p,
                      ),
                      CheckboxListTile(
                          title: Text('Shoprite'),
                          value: isShopriteChecked,
                          onChanged: (value) {
                            setState(() => isShopriteChecked = value);
                            Provider.of<GroceryShoppingListFilter>(context,
                                    listen: false)
                                .setData('shoprite', value);
                          }),
                      CheckboxListTile(
                        title: Text('Pick n Pay'),
                        value: isPnPChecked,
                        onChanged: (value) {
                          setState(() => isPnPChecked = value);
                          Provider.of<GroceryShoppingListFilter>(context,
                                  listen: false)
                              .setData('pnp', value);
                        },
                      ),
                      CheckboxListTile(
                          title: Text('Woolies'),
                          value: isWooliesChecked,
                          onChanged: (value) {
                            setState(() => isWooliesChecked = value);

                            Provider.of<GroceryShoppingListFilter>(context,
                                    listen: false)
                                .setData('woolies', value);
                          }),
                    ],
                  ),
                ),
                Spacer(
                  flex: 4,
                ),
                RaisedButton(
                  color: Colors.black,
                  onPressed: () {
//                    if (!widget.isShopriteChecked &&
//                        !widget.isPnPChecked &&
//                        !widget.isWooliesChecked) {
//                    } else {
                    Navigator.pop(context);
//                    }
                  },
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth10p * 2),
                    child: Text(
                      'Close',
                      style: TextStyle(
                          color: Colors.white, fontSize: screenWidth10p * 2),
                    ),
                  ),
                ),
                Spacer(
                  flex: 3,
                ),
              ],
            ),
          )),
    );
  }
}
