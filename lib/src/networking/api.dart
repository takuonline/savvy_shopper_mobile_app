//import 'dart:convert';
//import 'dart:io';
//import "package:flutter/material.dart";
//import 'package:http/http.dart' as http;
//
//const url = 'http://ec2-3-12-76-166.us-east-2.compute.amazonaws.com:4000';
//const Map<String, String> headers = {
//  "Connection": "Keep-Alive",
//  "Keep-Alive": "timeout=20, max=1000"
//};
//
//class NetworkHelper {
//  Future<dynamic> getData(String endpoint) async {
//    try {
//      http.Response response =
//          await http.get('$url/$endpoint', headers: headers);
//
//      String data = response.body;
//
//      if (response.statusCode == 200) {
//        return jsonDecode(data);
//      } else {
//        print("could not get the product. code-->${response.statusCode} ");
//      }
//    } on SocketException catch (_) {
//      print("not connected");
//    }
//  }
//
//  Future<dynamic> getSingleProductData(String endpoint, String title) async {
//    try {
//      http.Response response =
//          await http.get('$url/$endpoint/$title', headers: headers);
//
//      String data = response.body;
//
//      if (response.statusCode == 200) {
//        return jsonDecode(data);
//      } else {
//        print("error could not get item from server");
//      }
//    } on SocketException catch (_) {
//      print(" error, not connected to the internet");
//    }
//  }
//}
