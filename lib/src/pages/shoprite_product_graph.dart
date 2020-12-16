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

//  double cutOffYValue = 10;

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
            height: 30,
          ),

          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            width: screenWidth,
            height: screenHeight * .5,
color: kShopriteSecondary,
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
                    dataLabelSettings: DataLabelSettings(isVisible: false))
              ],
            ),

          ),

          SizedBox(
            height: 10,
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Image.network(
                widget.productItem.imageUrl ?? _shopriteNullImageUrl),
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
