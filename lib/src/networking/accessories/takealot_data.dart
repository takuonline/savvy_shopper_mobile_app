import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

const url = 'http://52.50.112.49:9876';

class TakealotData {
  Future<dynamic> getData() async {
    Map<String, String> headers = {
      "Connection": "Keep-Alive",
      "Keep-Alive": "timeout=20, max=1000"
    };
    try {
      print("getting data...takealot...................");
      http.Response response =
          await http.get('$url/takealot-client', headers: headers);

      String data = response.body;

      print("returning data...takealot.............");
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
      print("getting single product data.......takealot...............");
      http.Response response = await http.get(
          '$url/takealot-get-product-data/${title.replaceAll("/", "@forwardslash@")}',
          headers: headers);

      String data = response.body;

      print(data);

      print("returning single product data......takealot..........");
      return jsonDecode(data);
    } on SocketException catch (_) {
      print(" error, not connected to the internet");
    }
  }
}
