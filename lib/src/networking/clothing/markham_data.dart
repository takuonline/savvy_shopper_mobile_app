import 'dart:convert';
import 'dart:io';

//import 'package:http
import 'package:http/http.dart' as http;

import 'package:e_grocery/src/constants/constants.dart';

class MarkhamData {
  Future<dynamic> getData() async {
    Map<String, String> headers = {
      "Connection": "Keep-Alive",
      "Keep-Alive": "timeout=20, max=1000"
    };
    try {
      print("getting data...markham...................");
      http.Response response =
          await http.get('$serverUrl/markham-client', headers: headers);

      String data = response.body;

      print("returning data...markham.............");
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
      print("getting single product data.......markham...............");
      http.Response response = await http.get(
          '$serverUrl/markham-get-product-data/${title.replaceAll("/", "@forwardslash@")}',
          headers: headers);

      String data = response.body;

      print(data);

      print("returning single product data......markham..........");
      return jsonDecode(data);
    } on SocketException catch (_) {
      print(" error, not connected to the internet");
    }
  }
}
