import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

const url = 'http://ec2-3-12-76-166.us-east-2.compute.amazonaws.com:4000';

class ComputermaniaData {
  Future<dynamic> getData() async {
    Map<String, String> headers = {
      "Connection": "Keep-Alive",
      "Keep-Alive": "timeout=5, max=1000"
    };
    try {
      print("getting data...computermania...................");
      http.Response response =
          await http.get('$url/computermania-client', headers: headers);

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
          '$url/computermania-get-product-data/${title.replaceAll("/", "@forwardslash@")}',
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
