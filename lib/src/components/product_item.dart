class ProductItem {
  String imageUrl;
  List<dynamic> prices;
  List<DateTime> dates;
  String title;
  double change;

  ProductItem(this.imageUrl, this.prices, this.dates, this.title, this.change);
}

class WooliesProductItem {
  List<dynamic> prices;
  List<DateTime> dates;
  String title;
  double change;

  WooliesProductItem(this.prices, this.dates, this.title, this.change);
}
