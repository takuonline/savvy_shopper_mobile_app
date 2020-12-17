import 'package:e_grocery/src/components/product_item.dart';
import 'package:e_grocery/src/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ShopriteProductGraph extends StatefulWidget {
  static const id = "shoprite-product-graph";

  ProductItem productItem;

  ShopriteProductGraph({this.productItem});

  @override
  _ShopriteProductGraphState createState() => _ShopriteProductGraphState();
}

class _ShopriteProductGraphState extends State<ShopriteProductGraph> {
//  void _getDateValues() async {
//    _productDateList = await widget.dbHelper.retrieveAllDateData();
//    setState(() {
//      _parsedDateList = _productDateList
//          .where((element) => element.id == widget.product.id)
//          .toList();
//    });
//  }
//
//  List<ProductData> _getData() {
//    return _parsedDateList.map((e) => ProductData(e.time, e.price)).toList();
//  }

  final _shopriteNullImageUrl =
      'https://www.shoprite.co.za/medias/Food-min.webp?context=bWFzdGVyfHJvb3R8MTE2MDJ8aW1hZ2Uvd2VicHxoZGUvaDI1Lzg5OTgyNTE5MjE0Mzgud2VicHw4MzAyOGFmMTU0NmEwMmUwOWYwYjU2MTJhMzUzMWVhZWRlMWQ2ODg5NTRhZDIzODMwYTcxN2U1ODRhNGU2ZGZj';

  List<ProductData> _getData() {
    List<ProductData> temp = [];
    for (int i = 0; i < widget.productItem.prices.length; i++) {
      temp.add(ProductData(
          widget.productItem.dates[i], widget.productItem.prices[i]));
    }
    return temp;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
        child: Scaffold(
//      appBar: AppBar(
//        title: Text("${widget.productItem.title}"),
//      ),
      body: Container(
          color: kShopriteSecondary,
          child: ListView(
            children: [
              SizedBox(
                height: 10,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Card(
                        color: kBgShoprite.withOpacity(1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        elevation: 10,
                        child: Container(
                          height: 50,
                          width: 50,
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(50)),
                child: Material(
                  elevation: 5,
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    width: screenWidth,
                    height: screenHeight * .55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: kShopriteSecondary,
                    ),
                    child: SfCartesianChart(
                      plotAreaBorderWidth: 1,
                      crosshairBehavior: CrosshairBehavior(
                        enable: true,
                      ),

                      palette: [
//                      Colors.black,
                        kBgShoprite
                      ],
                      //set type for x and y axis
                      primaryXAxis: DateTimeAxis(
                        title: AxisTitle(
                          text: 'Date',
                        ),
                        intervalType: DateTimeIntervalType.days,
                      ),
                      primaryYAxis: NumericAxis(
                        title: AxisTitle(
                          text: 'Price',
                        ),

//                        labelFormat: 'R{value}'
//                    interval: 7
                      ),
                      //give chart title
                      title: ChartTitle(text: widget.productItem.title),
                      onMarkerRender: (args) {
//                      args.
                      },
                      legend: Legend(overflowMode: LegendItemOverflowMode.wrap),
                      tooltipBehavior: TooltipBehavior(enable: true),

                      series: <LineSeries>[
                        LineSeries(
                            dataSource: _getData(),
                            xValueMapper: (product, _) => product.time,
                            yValueMapper: (product, _) => product.price,
                            // Enable data label
                            dataLabelSettings:
                                DataLabelSettings(isVisible: false))
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 70,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Material(
                  elevation: 5,
                  color: kShopriteSecondary,
                  child: Container(
                    decoration: BoxDecoration(
//  color: Colors.transparent,

                        borderRadius: BorderRadius.circular(20)),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    child: Image.network(
                      widget.productItem.imageUrl ?? _shopriteNullImageUrl,
                    ),
                  ),
                ),
              )
            ],
          )),
    ));
  }
}

class ProductData {
  DateTime time;
  double price;
  ProductData(this.time, this.price);
}
