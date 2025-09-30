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
