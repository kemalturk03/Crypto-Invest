// To parse this JSON data, do
//
//     final market = marketFromJson(jsonString);

import 'dart:convert';

List<Market> marketFromJson(String? str) =>
    List<Market>.from(json.decode(str!).map((x) => Market.fromJson(x)));

String? marketToJson(List<Market> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Market {
  Market({
    this.symbol,
    this.priceChange,
    this.priceChangePercent,
    this.weightedAvgPrice,
    this.prevClosePrice,
    this.lastPrice,
    this.lastQty,
    this.bidPrice,
    this.bidQty,
    this.askPrice,
    this.askQty,
    this.openPrice,
    this.highPrice,
    this.lowPrice,
    this.volume,
    this.quoteVolume,
    this.openTime,
    this.closeTime,
    this.firstId,
    this.lastId,
    this.count,
  });

  String? symbol;
  String? priceChange;
  String? priceChangePercent;
  String? weightedAvgPrice;
  String? prevClosePrice;
  String? lastPrice;
  String? lastQty;
  String? bidPrice;
  String? bidQty;
  String? askPrice;
  String? askQty;
  String? openPrice;
  String? highPrice;
  String? lowPrice;
  String? volume;
  String? quoteVolume;
  int? openTime;
  int? closeTime;
  int? firstId;
  int? lastId;
  int? count;

  factory Market.fromJson(Map<String?, dynamic> json) => Market(
        symbol: json["symbol"],
        priceChange: json["priceChange"],
        priceChangePercent: json["priceChangePercent"],
        weightedAvgPrice: json["weightedAvgPrice"],
        prevClosePrice: json["prevClosePrice"],
        lastPrice: json["lastPrice"],
        lastQty: json["lastQty"],
        bidPrice: json["bidPrice"],
        bidQty: json["bidQty"],
        askPrice: json["askPrice"],
        askQty: json["askQty"],
        openPrice: json["openPrice"],
        highPrice: json["highPrice"],
        lowPrice: json["lowPrice"],
        volume: json["volume"],
        quoteVolume: json["quoteVolume"],
        openTime: json["openTime"],
        closeTime: json["closeTime"],
        firstId: json["firstId"],
        lastId: json["lastId"],
        count: json["count"],
      );

  Map<String?, dynamic> toJson() => {
        "symbol": symbol,
        "priceChange": priceChange,
        "priceChangePercent": priceChangePercent,
        "weightedAvgPrice": weightedAvgPrice,
        "prevClosePrice": prevClosePrice,
        "lastPrice": lastPrice,
        "lastQty": lastQty,
        "bidPrice": bidPrice,
        "bidQty": bidQty,
        "askPrice": askPrice,
        "askQty": askQty,
        "openPrice": openPrice,
        "highPrice": highPrice,
        "lowPrice": lowPrice,
        "volume": volume,
        "quoteVolume": quoteVolume,
        "openTime": openTime,
        "closeTime": closeTime,
        "firstId": firstId,
        "lastId": lastId,
        "count": count,
      };
}
