import 'dart:convert';
import 'dart:io';

//import 'package:http
import 'package:http/http.dart' as http;

const url = 'http://52.50.112.49:9876';

class ShopriteData {
  Future<dynamic> getData() async {
    try {
      print("getting data....Shoprite..................");
      http.Response response = await http.get('$url/client');

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
          '$url/get-product-data/${title.replaceAll("/", "@forwardslash@")}',
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
