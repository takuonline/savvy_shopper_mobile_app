import 'dart:convert';
import 'dart:io';

//import 'package:http
import 'package:http/http.dart' as http;

import 'package:e_grocery/src/constants/constants.dart';


class ShopriteData {
  Future<dynamic> getData() async {
    try {
      print("getting data....Shoprite..................");
      http.Response response = await http.get('$serverUrl/client');

      String data = response.body;
//    print(response.statusCode);

      print("returning data......Shoprite..........");
      return jsonDecode(data);
    } on SocketException catch (_) {
      print("not connected");
    }
  }

  Future<dynamic> getSingleProductData(String title) async {
    Map<String, String> headers = {
      "Connection": "Keep-Alive",
      "Keep-Alive": "timeout=20, max=1000"
    };
    try {
      print("getting single product data....Shoprite..................");
      http.Response response = await http.get(
          '$serverUrl/get-product-data/${title.replaceAll("/", "@forwardslash@")}',
          headers: headers);
      String data = response.body;

      print(data);

      print("returning single product data....Shoprite............");
      return jsonDecode(data);
    } on SocketException catch (_) {
      print(" error, not connected to the internet");
    } on NoSuchMethodError {
      print("is no such methodddddd");
    } catch (error) {
      print(error);
      print("unkown errrrrrrror");
    }
  }
}
