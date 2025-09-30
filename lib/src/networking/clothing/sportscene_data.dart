import 'dart:convert';
import 'dart:io';

//import 'package:http
import 'package:http/http.dart' as http;

import 'package:e_grocery/src/constants/constants.dart';

class SportsceneData {
  Future<dynamic> getData() async {
    Map<String, String> headers = {
      "Connection": "Keep-Alive",
      "Keep-Alive": "timeout=20, max=1000"
    };
    try {
      print("getting data...Sportscene...................");
      http.Response response =
          await http.get('$serverUrl/sportscene-client', headers: headers);

      String data = response.body;

      print("returning data...Sportscene.............");
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
      print("getting single product data.......Sportscene...............");
      http.Response response = await http.get(
          '$serverUrl/sportscene-get-product-data/${title.replaceAll("/", "@forwardslash@")}',
          headers: headers);

      String data = response.body;

      print(data);

      print("returning single product data......Sportscene..........");
      return jsonDecode(data);
    } on SocketException catch (_) {
      print(" error, not connected to the internet");
    }
  }
}
