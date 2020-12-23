import 'dart:convert';
import 'dart:io';
import "package:flutter/material.dart";
//import 'package:http
import 'package:http/http.dart' as http;

const url  = 'http://ec2-3-12-76-166.us-east-2.compute.amazonaws.com:4000';


class PnPData {

  Future<dynamic> getData ()async {
    try {
      print("getting data......................");
      http.Response response =
      await http.get('$url/pnp-client');

      String data = response.body;

      print("returning data................");
      return jsonDecode(data);
    } on SocketException catch (_) {
      print("not connected");
    }
  }

  Future<dynamic> getSingleProductData(String title) async {
    try {
      print("getting single product data......................");
      http.Response response = await http.get('$url/pnp-get-product-data/$title');

      String data = response.body;

      print(data);

      print("returning single product data................");
      return jsonDecode(data);
    } on SocketException catch (_) {
      print(" error, not connected to the internet");
    }
  }
}