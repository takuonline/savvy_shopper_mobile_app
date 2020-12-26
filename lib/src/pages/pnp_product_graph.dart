import 'dart:math';
import 'package:e_grocery/src/components/product_item.dart';
import 'package:e_grocery/src/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PnPProductGraph extends StatefulWidget {
  static const id = "pnp-product-graph";

  ProductItem productItem;

  PnPProductGraph({this.productItem});

  @override
  _PnPProductGraphState createState() => _PnPProductGraphState();
}

class _PnPProductGraphState extends State<PnPProductGraph> {

  final _badImageUrl = "/pnpstorefront/_ui/responsive/theme-blue/images/missing_product_EN_140x140.jpg";
  final _pnpNullImageUrl =
      'https://www.pnp.co.za//pnpstorefront/_ui/responsive/theme-blue/images/missing_product_EN_400x400.jpg';

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

    final screenHeight10p = screenHeight*(10/MediaQuery.of(context).size.height);
    final screenWidth10p =screenWidth* (10/MediaQuery.of(context).size.width);
 ;
    return Container(
        child: Scaffold(

      body: Container(

      color: Colors.white,
          child: ListView(
            children: [
              SizedBox(
                height: screenHeight10p*4,
              ),
              Stack(

                children: [

                  Center(
                    child: Container(
                      width: screenWidth*.8,
                      height: screenHeight*.35,
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: screenHeight10p*1.5 ),
                        child:
                        widget.productItem.imageUrl == _badImageUrl ? Image.network(_pnpNullImageUrl) :
                        Image.network(
                          widget.productItem.imageUrl ?? _pnpNullImageUrl,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: screenWidth10p*2,
                    top: 0,
                    
                    child: Container(
                      decoration:BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color:kBgPnP.withOpacity(.2)
                      ),
                      
                      width: screenWidth10p*4.5,
                      
                      height: screenHeight10p*4.5,

                      child: IconButton(
                        icon: Icon(Icons.arrow_back,color:kBgPnP,size: screenHeight10p*3,) ,
                          onPressed: ()=> Navigator.pop(context),
                      ),

                    ),
                  ),
                ],
              ),
SizedBox(
  height: 40,
),
//              Padding(
//                padding:
//                    const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
//                child: Row(
//                  children: [
//                    GestureDetector(
//                      onTap: () => Navigator.of(context).pop(),
//                      child: Card(
//                        color: kBgShoprite.withOpacity(1),
//                        shape: RoundedRectangleBorder(
//                          borderRadius: BorderRadius.circular(5),
//                        ),
//                        elevation: 10,
//                        child: Container(
//                          height: 50,
//                          width: 50,
//                          child: Icon(
//                            Icons.arrow_back,
//                            color: Colors.white,
//                            size: 30,
//                          ),
//                        ),
//                      ),
//                    )
//                  ],
//                ),
//              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: screenHeight10p*1.5),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(screenHeight10p*5)),
                child: Material(
                  elevation: 20,
                  borderRadius: BorderRadius.circular(screenHeight10p*2),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: screenHeight10p, vertical: screenHeight10p*2),
                    width: screenWidth,
                    height: screenHeight * .55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(screenHeight10p*2),
                      color: kBgPnP,
                    ),
                    child: SfCartesianChart(
                      plotAreaBorderWidth: 0,
                      crosshairBehavior: CrosshairBehavior(
                        enable: true,
                      ),
//borderColor: Colors.blue,

                      palette: [
//                      Colors.black,
                        Colors.orange
                      ],
                      //set type for x and y axis
                      primaryXAxis: DateTimeAxis(
majorGridLines: MajorGridLines(
  color: Colors.blue,
  width: 0
)
                        ,labelStyle: TextStyle(
                        color: Colors.white
                      )
                       ,
                        title: AxisTitle(

                          text: 'Date',
                            textStyle:TextStyle(
                                color: Colors.white
                            )
                        ),
                        intervalType: DateTimeIntervalType.days,
                      ),
                      primaryYAxis: NumericAxis(
                      labelStyle: TextStyle(
                      color: Colors.white
                      ),majorGridLines: MajorGridLines(
                          color: Colors.black.withOpacity(.5),
                          width: 1
                      ),
                        title: AxisTitle(
                          text: 'Price',
                          textStyle:TextStyle(
                            color: Colors.white
                          )

                        ),

//                        labelFormat: 'R{value}'
//                    interval: 4
                      ),
                      //give chart title
                      title: ChartTitle(text: widget.productItem.title,textStyle: TextStyle(
                        color: Colors.white
                      )),
                      onMarkerRender: (args) {
//                      args.
                      },
                      legend: Legend(overflowMode: LegendItemOverflowMode.wrap),
                      tooltipBehavior: TooltipBehavior(enable: true),
backgroundColor:Colors.black.withOpacity(.2),

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
                height: 50,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal:20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children : [

                    MaxMinCard(
                        widget: widget,
                      priceValue: widget.productItem.prices.map((e) => double.parse(e.toString())).toList().reduce(max)?? 0 ,
                      title: "Max",
                    ),
                    MaxMinCard(
                      widget: widget,
                      priceValue: widget.productItem.prices.map((e) => double.parse(e.toString())).toList().reduce(min)?? 0 ,
                      title: "Min",
                    ),
                    MaxMinCard(
                      widget: widget,
                      priceValue: (widget.productItem.prices.map((e) => double.parse(e.toString())).reduce((a,b) => a+b ) /widget.productItem.prices.length).roundToDouble() ?? 0 ,
                      title: "Avg",
                    ),

                  ]
                ),
              ),


              SizedBox(
                height: 7*screenHeight10p,
              ),


            ],
          )),
    ));
  }
}

class MaxMinCard extends StatelessWidget {


   PnPProductGraph widget;

   String title;

   double priceValue;


   MaxMinCard({this.widget, this.title, this.priceValue});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final screenHeight10p = screenHeight*(10/MediaQuery.of(context).size.height);
    final screenWidth10p =screenWidth* (10/MediaQuery.of(context).size.width);

    return Card(
      color: kBgPnP,
      borderOnForeground: true,
      elevation: 20,

      child:
      Padding(
        padding:  EdgeInsets.symmetric(horizontal:screenWidth10p*1.5,vertical: screenHeight10p*2.5),
        child: Column(
          children: [
            Text(title,style: TextStyle(
              fontFamily: "Montserrat",
              color: Colors.white.withOpacity(.6),
              fontSize: screenWidth10p*2,
              fontWeight: FontWeight.w700

            ),),
            SizedBox(
              height: screenHeight10p,
            ),
            FittedBox(
              child: Text("R$priceValue",
              style: TextStyle(
                  fontFamily: "Montserrat",
                  color: Colors.white,
                  fontSize: screenWidth10p*1.5,
                  fontWeight: FontWeight.w500

              ),


              ),
            ),


          ],
        ),
      )
      ,

                  );
  }
}

class ProductData {
  DateTime time;
  double price;
  ProductData(this.time, this.price);
}
