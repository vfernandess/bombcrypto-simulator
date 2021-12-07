import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

abstract class RoiFacade {
  Future<num> getBombCoinUsdPrice();
}

class RoiFacadeImpl extends RoiFacade {
  static const String _url =
      "https://pro-api.coinmarketcap.com/v1/tools/price-conversion";

  @override
  Future<num> getBombCoinUsdPrice() async {
    const params = "?amount=1&symbol=BCOIN&convert=USD";
    final map = {"X-CMC_PRO_API_KEY": "f6f6270d-98ae-4a49-8ef4-3055c223ead1"};
    final response = await http.get(Uri.parse(_url + params), headers: map);

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json["data"]["quote"]["USD"]["price"] as num;
    } else {
      throw Exception('Failed to load album');
    }
  }
}
