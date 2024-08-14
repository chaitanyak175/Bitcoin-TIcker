import 'dart:convert';
import 'package:http/http.dart' as http;

class CoinData {
  final String api_key = 'c2f5512e-a49e-40a1-91e4-63364fdaf669';

  Future getCoinData(String coinName, String selectedCurrency) async {
    var uri = Uri.parse(
        'https://rest.coinapi.io/v1/exchangerate/$coinName/$selectedCurrency?apikey=$api_key');
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
