import 'package:crypto_invest/model/market.dart';
import 'package:intl/intl.dart';

int get nowToInt {
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat("ss");
  String formattedTime = formatter.format(now);
  return int.parse(formattedTime);
}

double coinPriceCalculator(UsdModel coinPrice, dynamic percentage) {
  var currentPrice = coinPrice.price.toDouble();
  return currentPrice -
      (currentPrice - (currentPrice / (1 + (percentage / 100))));
}
