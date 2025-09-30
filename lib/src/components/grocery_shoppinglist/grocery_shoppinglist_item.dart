import 'package:e_grocery/src/components/product_item.dart';

class GroceryShoppingListItem {
  String title;
  String store;
  List<dynamic> prices;
  String imageUrl;
  int quantity = 1;
  double change;
  ProductItem productItem;
  WooliesProductItem wooliesProductItem;

  GroceryShoppingListItem(
      {this.title,
      this.store,
      this.prices,
      this.imageUrl,
      this.quantity,
      this.change,
      this.productItem,
      this.wooliesProductItem});
}
