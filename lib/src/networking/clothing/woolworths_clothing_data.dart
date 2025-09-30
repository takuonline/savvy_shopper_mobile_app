import 'dart:convert';
import 'dart:io';

//import 'package:http
import 'package:http/http.dart' as http;

const url = 'http://52.50.112.49:9876';

class WoolworthsClothingData {
  Future<dynamic> getData() async {
    Map<String, String> headers = {
      "Connection": "Keep-Alive",
      "Keep-Alive": "timeout=20, max=1000"
    };
    try {
      print("getting data...WoolworthsClothing...................");
      http.Response response =
          await http.get('$url/woolworths-clothing-client', headers: headers);

      String data = response.body;

      print("returning data...woolworths-clothing.............");
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
      print(
          "getting single product data.......woolworths-clothing...............");
      http.Response response = await http.get(
          '$url/woolworths-clothing-get-product-data/${title.replaceAll("/", "@forwardslash@")}',
          headers: headers);

      String data = response.body;

      print(data);

      print("returning single product data......woolworths-clothing..........");
      return jsonDecode(data);
    } on SocketException catch (_) {
      print(" error, not connected to the internet");
    }
  }
}
