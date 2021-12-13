class Balance {
  Balance({this.usd, this.coin});

  final num? usd;
  final CoinBalance? coin;

  factory Balance.fromJson(Map<dynamic, dynamic> snapshot, String? coinTitle) {
    return Balance(
        usd: snapshot['usdBalance'],
        coin: CoinBalance.fromJson(
            snapshot['balances']['${coinTitle!.toLowerCase()}'] ?? {}));
  }
}

class CoinBalance {
  CoinBalance(
      {this.time,
      this.coinValue,
      this.coinSymbol,
      this.coinTitle,
      this.coinIndex});

  final String? time;
  final num? coinValue;
  final String? coinSymbol;
  final String? coinTitle;
  final int? coinIndex;

  factory CoinBalance.fromJson(Map<dynamic, dynamic> snapshot) {
    return CoinBalance(
        time: snapshot['time'],
        coinValue: snapshot['value'],
        coinSymbol: snapshot['symbol'],
        coinTitle: snapshot['title'],
        coinIndex: snapshot['coinIndex']);
  }
}
