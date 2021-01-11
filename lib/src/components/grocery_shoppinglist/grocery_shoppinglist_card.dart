import 'package:e_grocery/src/components/grocery_shoppinglist/grocery_shoppinglist_item.dart';
import 'package:e_grocery/src/constants/constants.dart';
import 'package:e_grocery/src/providers/grocery_shopping_list.dart';
import 'file:///C:/Users/Taku/AndroidStudioProjects/e_grocery/lib/src/pages/groceries_product_graph/pnp_product_graph.dart';
import 'file:///C:/Users/Taku/AndroidStudioProjects/e_grocery/lib/src/pages/groceries_product_graph/shoprite_product_graph.dart';
import 'file:///C:/Users/Taku/AndroidStudioProjects/e_grocery/lib/src/pages/groceries_product_graph/woolies_product_graph.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ShoppingListCard extends StatefulWidget {
  int index;
  GroceryShoppingListItem productItem;
  Function calculateBalance;
  Function dropItem;

  ShoppingListCard(
      {this.index, this.productItem, this.calculateBalance, this.dropItem});

  @override
  _ShoppingListCardState createState() => _ShoppingListCardState();
}

class _ShoppingListCardState extends State<ShoppingListCard> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenHeight10p =
        screenHeight * (10 / MediaQuery.of(context).size.height);
    final screenWidth10p =
        screenWidth * (10 / MediaQuery.of(context).size.width);


    Future<void> showDropItemDialog(BuildContext context, int index) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Attention!'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    'Are you sure you want to remove this item from your shopping list?',
                    style: TextStyle(
                      fontFamily: "Montserrat",
                      color: Colors.black,
                    ),
                  ),
//                Text('Would you like to approve of this message?'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'Cancel',
                  style: TextStyle(color: kTextColor),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text(
                  'Yes',
                  style: TextStyle(color: Colors.red),
                ),
                onPressed: () {
//                  Provider.of<GroceryShoppingList>(context,listen: false).dropItemGroceryShoppingList(index);

                  widget.dropItem(index);
                  widget.calculateBalance();

                  Navigator.of(context).pop();
                },
              )
            ],
          );
        },
      );
    }

    return Dismissible(
      key: UniqueKey(),
      background: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.delete_forever,
            color: Colors.red,
          ),
        ],
      ),
      onDismissed: (dir) {
//        showDropItemDialog(context,widget.index);
        widget.dropItem(widget.index);
        widget.calculateBalance();
      }

//        WidgetsBinding.instance.addPostFrameCallback((_){

//        });

      ,
      secondaryBackground: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Icon(
            Icons.delete_forever,
            color: Colors.red,
          ),
        ],
      ),
      child: Container(
        width: screenWidth * 1,
        height: screenHeight * .22,
        margin: EdgeInsets.only(bottom: screenHeight10p * 2),
        padding: EdgeInsets.only(
            left: screenWidth10p,
            right: 0,
            top: screenHeight10p,
            bottom: screenHeight10p),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: Colors.black,
              width: 5,
            )),
        child: Row(children: [
          Flexible(
            flex: 20,
            child: GestureDetector(
              onTap: () {
                if (widget.productItem.store == "Woolworths") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => WooliesProductGraph(
                          productItem: widget.productItem.wooliesProductItem),
                    ),
                  );
                } else if (widget.productItem.store == "Pick n Pay") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PnPProductGraph(
                          productItem: widget.productItem.productItem),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShopriteProductGraph(
                          productItem: widget.productItem.productItem),
                    ),
                  );
                }
              },
              child: Column(
                children: [
                  Flexible(child: SizedBox(height: screenHeight10p)),
                  Text(
                    '${widget.productItem.title}',
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontFamily: "Montserrat",
                        decoration: TextDecoration.none,
                        fontSize: screenWidth10p * 1.5),
                  ),
                  SizedBox(
                    height: screenHeight10p,
                  ),
                  Spacer(
                    flex: 2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Quantity',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Montserrat",
                            decoration: TextDecoration.none,
                            fontSize: screenWidth10p * 1.5),
                      ),
                      Text(
                        '${widget.productItem.quantity}',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Montserrat",
                            fontSize: screenWidth10p * 1.5,
                            decoration: TextDecoration.none),
                      ),
                    ],
                  ),
                  Spacer(
                    flex: 1,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Montserrat",
                            fontSize: screenWidth10p * 1.5,
                            decoration: TextDecoration.none),
                      ),
                      Text(
                        'R${(widget.productItem.quantity *
                            widget.productItem.prices.last).toStringAsFixed(
                            2)}',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Montserrat",
                            fontSize: screenWidth10p * 1.5,
                            decoration: TextDecoration.none),
                      ),
                    ],
                  ),
                  Spacer(
                    flex: 4,
                  ),
                  Flexible(
                    child: SizedBox(
                      height: screenHeight10p * 3,
                    ),
                  ),
                  Container(
                    width: double.infinity,
//                color: Colors.red,
                    child: Text(
                      "${widget.productItem.store}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w500,
                          fontFamily: "Montserrat",
                          fontSize: screenWidth10p * 1.5,
                          decoration: TextDecoration.none),
                    ),
                  )
                ],
              ),
            ),
          ),
          Spacer(),
          Flexible(
              flex: 5,
              child: Container(
                decoration: BoxDecoration(
                    color: kTextFieldBgGrey,
                    borderRadius: BorderRadius.circular(screenWidth10p * 1)),
                margin: EdgeInsets.symmetric(horizontal: screenHeight10p),
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth10p, vertical: screenHeight10p * .5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          setState(() => widget.productItem.quantity++);
                          widget.calculateBalance();
                        },
                        child: Icon(
                          Icons.add,
                          size: screenWidth10p * 2.5,
                          color: kTextColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (widget.productItem.quantity > 1) {
                            setState(() => widget.productItem.quantity--);
                            widget.calculateBalance();
                          }
                        },
                        child: Icon(
                          Icons.remove,
                          size: screenWidth10p * 2.5,
                          color: kTextColor,
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => showDropItemDialog(context, widget.index),
                        child: Icon(
                          Icons.close,
                          size: screenWidth10p * 2.5,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ))
        ]),
      ),
    );
  }
}
