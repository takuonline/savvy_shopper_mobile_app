import 'package:flutter/material.dart';

class BestChoiceProduct extends StatelessWidget {
  final String title;

  BestChoiceProduct({this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5),
      child: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Colors.black,
          fontFamily: "Montserrat",
          decoration: TextDecoration.none,
          fontSize: 18,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}



class DatatableGridSelector extends StatefulWidget {

  bool isGrid = false;
  Function toggleGrid;

  DatatableGridSelector(this.isGrid,this.toggleGrid);

  @override
  _DatatableGridSelectorState createState() => _DatatableGridSelectorState();
}

class _DatatableGridSelectorState extends State<DatatableGridSelector> {

  @override
  Widget build(BuildContext context) {

    bool _isGrid = widget.isGrid;

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final screenHeight10p = screenHeight*(10/MediaQuery.of(context).size.height);
    final screenWidth10p =screenWidth* (10/MediaQuery.of(context).size.width);


    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            widget.toggleGrid();
          },
          child: Container(
              decoration: BoxDecoration(
                  color: _isGrid ? Colors.white : Colors.transparent,
                  borderRadius: BorderRadius.circular(10)),
              width: screenWidth * .5 * .8,
              padding:
              EdgeInsets.symmetric(horizontal:screenWidth10p* 2, vertical:screenHeight10p *1.6),
              child: Text(
                "DataTable",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w500,
                    fontSize: screenWidth10p* 1.8,
                    decoration: TextDecoration.none),
              )),
        ),
        GestureDetector(
          onTap: () {
            widget.toggleGrid();
          },
          child: Container(
              decoration: BoxDecoration(
                  color: _isGrid ? Colors.transparent : Colors.white,
                  borderRadius: BorderRadius.circular(10)),
              width: screenWidth * .5 * .8,
              padding:
              EdgeInsets.symmetric(horizontal:screenWidth10p* 2, vertical: screenHeight10p *1.6),
              child: Text(
                "Grid",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Montserrat",
                    fontWeight: FontWeight.w500,
                    fontSize: screenWidth10p* 1.8,
                    decoration: TextDecoration.none),
              )),
        ),
      ],
    );
  }
}