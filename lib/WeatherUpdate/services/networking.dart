import 'package:http/http.dart' as http;
import 'dart:convert';
class NetworkHelper{
  final String url;
  NetworkHelper(this.url);
  Future<dynamic> getData() async {
    http.Response response = await http.get(Uri.parse(url));
    if(response.statusCode == 200) {
      String data = response.body;
      dynamic decodeData = jsonDecode(data);
      return decodeData;
    }
    else{
      print(response.statusCode);
    }
  }

}
