import 'dart:convert';
import 'dart:io';

import 'package:e_grocery/src/constants/constants.dart';
import 'package:http/http.dart' as http;

class ComputermaniaData {
  Future<dynamic> getData() async {
    Map<String, String> headers = {
      "Connection": "Keep-Alive",
      "Keep-Alive": "timeout=5, max=1000"
    };
    try {
      print("getting data...computermania...................");
      http.Response response =
          await http.get('$serverUrl/computermania-client', headers: headers);

      String data = response.body;

      print("returning data...computermania.............");
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
      print("getting single product data.......computermania...............");
      http.Response response = await http.get(
          '$serverUrl/computermania-get-product-data/${title.replaceAll("/", "@forwardslash@")}',
          headers: headers);

      String data = response.body;

      print(data);

      print("returning single product data......computermania..........");
      return jsonDecode(data);
    } on SocketException catch (_) {
      print(" error, not connected to the internet");
    }
  }
}
