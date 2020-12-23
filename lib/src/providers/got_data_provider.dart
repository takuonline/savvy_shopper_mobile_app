import 'package:flutter/material.dart';



class GotData with ChangeNotifier{
  bool _gotData = false;
  bool get gotData => _gotData;

  void setGotData(bool value ){
    _gotData = value;
  }

}


