import 'dart:convert';
import 'package:http/http.dart' as http;

class Btcdata {
  final String api_key = '5CE85656-A821-4BEA-9A49-EBBBF55CB02D';

  Future getBtcData(String selectedCurrency) async {
    var uri = Uri.parse(
        'https://rest.coinapi.io/v1/exchangerate/BTC/$selectedCurrency?apikey=$api_key');
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
