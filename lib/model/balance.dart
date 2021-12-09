class Balance {
  Balance({this.usd, this.coin});

  final num? usd;
  final num? coin;

  factory Balance.fromJson(Map<dynamic, dynamic> snapshot) {
    return Balance(usd: snapshot['usdBalance'], coin: snapshot['coinBalance']);
  }
}
