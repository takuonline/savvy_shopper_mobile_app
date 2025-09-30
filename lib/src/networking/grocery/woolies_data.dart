import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

const url = 'http://52.50.112.49:9876';

class WooliesData {
  Future<dynamic> getData() async {
    try {
      print("getting data.......Woolies...............");
      http.Response response = await http.get('$url/woolies-client');

      String data = response.body;

      print("returning data.....Woolies...........");
      return jsonDecode(data);
    } on SocketException catch (_) {
      print("not connected");
    }
  }

  Future<dynamic> getSingleProductData(String title) async {
    try {
      print("getting single product data.........Woolies.............");
      http.Response response = await http.get(
          '$url/woolies-get-product-data/${title.replaceAll("/", "@forwardslash@")}');

      String data = response.body;

      print(data);

      print("returning single product data.......Woolies.........");
      return jsonDecode(data);
    } on SocketException catch (_) {
      print(" error, not connected to the internet");
    }
  }
}
