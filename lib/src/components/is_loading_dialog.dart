
import 'package:flutter/material.dart';



class IsLoading{


  static Future<void> showIsLoadingDialog(BuildContext context) async {
    return showDialog<void>(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.black.withOpacity(.3),
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: CircularProgressIndicator(
            ),
          ),
        );
      },
    );
  }

}