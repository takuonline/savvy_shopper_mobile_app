import 'dart:convert';
import 'dart:io';
import "package:flutter/material.dart";
//import 'package:http
import 'package:http/http.dart' as http;



class ShopriteData {

  Future<dynamic> getData ()async {
    try {
      print("getting data......................");
      http.Response response =
          await http.get('http://nothin-to-see-here.herokuapp.com/client');

      String data = response.body;
//    print(response.statusCode);

      print("returning data................");
      return jsonDecode(data);
    } on SocketException catch (_) {
      print("not connected");
    }
  }

  Future<dynamic> getSingleProductData(String title) async {
    try {
      print("getting single product data......................");
      http.Response response = await http.post(
          'http://nothin-to-see-here.herokuapp.com/get-product-data/$title');

      String data = response.body;

//    print(response.statusCode);

      print(data);

      print("returning single product data................");
      return jsonDecode(data);
    } on SocketException catch (_) {
      print(" error, not connected to the internet");
    }
  }
}