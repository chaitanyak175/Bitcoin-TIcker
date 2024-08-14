import 'dart:convert';
import 'package:http/http.dart' as http;

class Btcdata {
  final String api_key = '9b38bb5d-9074-424b-98a0-a228da9504c0';

  Future getBtcData(String selectedCurrency) async {
    var uri = Uri.parse(
        'https://rest.coinapi.io/v1/exchangerate/LTC/$selectedCurrency?apikey=$api_key');
    http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      String data = response.body;
      var decodeData = jsonDecode(data);
      return decodeData;
    } else {
      print(response.statusCode);
    }
  }
}
