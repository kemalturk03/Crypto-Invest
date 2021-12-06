import 'dart:convert';

import 'package:crypto_invest/model/market.dart';
import 'package:crypto_invest/utilities/constants.dart';
import 'package:http/http.dart' as http;

class MarketService {
  Future<Market> getData() async {
    final headers = {
      'X-CMC_PRO_API_KEY': apiKey,
      /*Bu header ı girip apikey i içine verince, bizim apimiz authentication yapmış oluyor*/
    };

    http.Response response =
        await http.get(Uri.parse(fullUrl), headers: headers);

    if (response.statusCode != 200) {
      print("ERROR HAPPENED");
    }
    return Market.fromJson(jsonDecode(response.body));
  }
}
