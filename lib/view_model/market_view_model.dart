import 'dart:async';

import 'package:crypto_invest/model/chart_data.dart';
import 'package:crypto_invest/model/market.dart';
import 'package:crypto_invest/service/market_service.dart';
import 'package:crypto_invest/utilities/components.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class MarketViewModel extends ChangeNotifier {
  MarketService _marketService = MarketService();

  MarketViewModel() {
    print("MarketViewModel Constructor Called");
    _loadMarkets();
    _streamController = new StreamController();
    _tooltipBehavior = TooltipBehavior(enable: true, color: Colors.blue);

  }

  int _listIndex = 0;
  bool _isClicked = false;
  StreamController _streamController = StreamController();
  List<ChartData> _chartData = [];
  TooltipBehavior _tooltipBehavior = TooltipBehavior();
  List<Coin> _coinData = [];
  String _snackBarContent = "";


  int get listIndex => _listIndex;
  bool get isClicked => _isClicked;
  StreamController get streamController => _streamController;
  List<ChartData> get chartData => _chartData;
  TooltipBehavior get tooltipBehaviour => _tooltipBehavior;
  List<Coin> get coinData => _coinData;
  String get snackBarContent => _snackBarContent;

  void _loadMarkets() async {
    print("loadMarkets called");
    await _marketService.getData().then((value) {
      _streamController.add(value);
      return value;
    });
  }

  void setCoinData(List<Coin> coinData) {
    _coinData = coinData;
  }

  void setListIndex(int listIndex) {
    _listIndex = listIndex;
    notifyListeners();
  }

  void setSnackBarContent(String snackBarContent) {
    _snackBarContent = snackBarContent;
    notifyListeners();
  }

  void setClicked(bool isClicked) {
    _isClicked = isClicked;
    notifyListeners();
  }

  void setChartData(UsdModel coinPrice) {
    _chartData = [
      ChartData(
          coinPriceCalculator(coinPrice, coinPrice.percentChange_90d), 90),
      ChartData(
          coinPriceCalculator(coinPrice, coinPrice.percentChange_60d), 60),
      ChartData(
          coinPriceCalculator(coinPrice, coinPrice.percentChange_30d), 30),
      ChartData(coinPriceCalculator(coinPrice, coinPrice.percentChange_7d), 7),
      ChartData(
          coinPriceCalculator(coinPrice, coinPrice.percentChange_24h), 24),
      ChartData(coinPriceCalculator(coinPrice, coinPrice.percentChange_1h), 1),
      ChartData(coinPrice.price.toDouble(), 0),
    ];
    notifyListeners();
  }
}
