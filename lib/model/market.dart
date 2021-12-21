// To parse this JSON data, do
//
//     final coin = coinFromJson(jsonString);

import 'dart:convert';

Market coinFromJson(String str) => Market.fromJson(json.decode(str));

class Market {
  Market({
    this.data,
    this.status,
  });

  final List<Coin>? data;
  final Status? status;

  factory Market.fromJson(Map<String, dynamic> json) {
    return Market(
      data: List<Coin>.from(json["data"].map((x) => Coin.fromJson(x)).toList()),
      status: Status.fromJson(json["status"]),
    );
  }
}

class Coin {
  Coin({
    this.id,
    this.name,
    this.symbol,
    this.slug,
    this.cmcRank,
    this.numMarketPairs,
    this.circulatingSupply,
    this.totalSupply,
    this.maxSupply,
    this.lastUpdated,
    this.dateAdded,
    this.tags,
    this.platform,
    this.quoteModel,
  });

  final int? id;
  final String? name;
  final String? symbol;
  final String? slug;
  final int? cmcRank;
  final int? numMarketPairs;
  final dynamic circulatingSupply;
  final dynamic totalSupply;
  final int? maxSupply;
  final DateTime? lastUpdated;
  final DateTime? dateAdded;
  final List<String>? tags;
  final dynamic platform;
  final DataModel? quoteModel;

  factory Coin.fromJson(Map<String, dynamic> json) => Coin(
        id: json["id"],
        name: json["name"],
        symbol: json["symbol"],
        slug: json["slug"],
        cmcRank: json["cmc_rank"] == null ? null : json["cmc_rank"],
        numMarketPairs: json["num_market_pairs"],
        circulatingSupply: json["circulating_supply"],
        totalSupply: json["total_supply"],
        maxSupply: json["max_supply"],
        lastUpdated: DateTime.parse(json["last_updated"]),
        dateAdded: DateTime.parse(json["date_added"]),
        tags: List<String>.from(json["tags"].map((x) => x)),
        platform: json["platform"],
        quoteModel: DataModel.fromJson(json["quote"]),
      );
}

class DataModel {
  final UsdModel usdModel;

  DataModel({
    required this.usdModel,
  });
  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      usdModel: UsdModel.fromJson(json["USD"]),
    );
  }
}

class UsdModel {
  final num price;
  final num volume24h;
  final num percentChange_1h;
  final num percentChange_24h;
  final num percentChange_7d;
  final num percentChange_30d;
  final num percentChange_60d;
  final num percentChange_90d;
  final num marketCap;
  final String lastUpdated;

  UsdModel(
      {required this.price,
      required this.volume24h,
      required this.percentChange_1h,
      required this.percentChange_24h,
      required this.percentChange_7d,
      required this.percentChange_30d,
      required this.percentChange_60d,
      required this.percentChange_90d,
      required this.marketCap,
      required this.lastUpdated});

  factory UsdModel.fromJson(Map<String, dynamic> json) {
    return UsdModel(
      price: json["price"] == null ? 0.0 : json["price"],
      volume24h: json["volume_24"] == null ? 0.0 : json["volume_24"],
      percentChange_1h:
          json["percent_change_1h"] == null ? 0.0 : json["percent_change_1h"],
      percentChange_24h:
          json["percent_change_24h"] == null ? 0.0 : json["percent_change_24h"],
      percentChange_7d:
          json["percent_change_7d"] == null ? 0.0 : json["percent_change_7d"],
      percentChange_30d:
          json["percent_change_30d"] == null ? 0.0 : json["percent_change_30d"],
      percentChange_60d:
          json["percent_change60d"] == null ? 0.0 : json["percent_change60d"],
      percentChange_90d:
          json["percent_change90d"] == null ? 0.0 : json["percent_change90d"],
      marketCap: json["market_cap"] == null ? 0.0 : json["market_cap"],
      lastUpdated: json["last_updated"],
    );
  }
}

class Status {
  Status({
    this.timestamp,
    this.errorCode,
    this.errorMessage,
    this.elapsed,
    this.creditCount,
  });

  final DateTime? timestamp;
  final int? errorCode;
  final String? errorMessage;
  final int? elapsed;
  final int? creditCount;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        timestamp: DateTime.parse(json["timestamp"]),
        errorCode: json["error_code"],
        errorMessage: json["error_message"],
        elapsed: json["elapsed"],
        creditCount: json["credit_count"],
      );
}
