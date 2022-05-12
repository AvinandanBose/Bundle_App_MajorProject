import 'package:http/http.dart' as http;
import 'dart:convert';
import 'constants_url.dart';
import 'coin_data.dart';
class get_data {
  dynamic rate;
  Future<dynamic> getData(String selectedCurrency) async {
    Map<String, String> cryptoPrices = {};
    for (String crypto in cryptoList) {
      http.Response response = await http.get(
          Uri.parse('$coinAPIURL/$crypto/$selectedCurrency?apikey=$apiKey'));
      if (response.statusCode == 200) {
        String data = response.body;
        dynamic decodeData = jsonDecode(data);
        rate = decodeData['rate'];
        cryptoPrices[crypto] = rate.toStringAsFixed(2);
      }
      else{
        print(response.statusCode);
        throw 'Problem with the get request';
      }

    }
    print(cryptoPrices);
    return cryptoPrices;
  }
}