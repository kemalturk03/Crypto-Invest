import 'package:crypto_invest/model/market.dart';
import 'package:http/http.dart' as http;

class MarketService {
  Future<List<Market>> fetchMarket() async {
    String baseUrl = "https://api.binance.com/api/v3/ticker/24hr";
    Uri parsedUrl = Uri.parse(baseUrl);

    http.Response response = await http.get(parsedUrl);

    if (response.statusCode == 200) {
      return marketFromJson(response.body);
    } else {
      throw Exception('AN ERROR OCCURRED!');
    }
  }
}
