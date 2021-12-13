import 'dart:async';

import 'package:crypto_invest/model/balance.dart';
import 'package:crypto_invest/model/market.dart';
import 'package:crypto_invest/service/firebase_service.dart';
import 'package:crypto_invest/service/market_service.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class WalletViewModel extends ChangeNotifier {
  MarketService _marketService = MarketService();
  FirebaseService _fireService = FirebaseService();
  WalletViewModel() {
    setBalances();
    _setZeroBalance();
    _loadMarkets();
    print('Wallet View Model Constructor Called!');
  }

  final firebaseRef = FirebaseDatabase.instance.reference();
  TextEditingController _buyController = TextEditingController();
  TextEditingController _sellController = TextEditingController();
  double? _usdBalance;
  bool _loading = true;
  bool _zeroBalance = false;
  List<double> _pricesList = [];
  int _listIndex = 0;
  bool _isClicked = false;
  String _snackBarContent = "";

  TextEditingController get buyController => _buyController;
  TextEditingController get sellController => _sellController;
  double get usdBalance => _usdBalance!;
  bool get loading => _loading;
  bool get zeroBalance => _zeroBalance;
  List<double>? get pricesList => _pricesList;
  int get listIndex => _listIndex;
  bool get isClicked => _isClicked;
  String get snackBarContent => _snackBarContent;

  Future setBalances() async {
    _setLoading(true);
    _usdBalance = await firebaseRef
        .once()
        .then((value) => double.parse(value.value['usdBalance'].toString()));
    _setLoading(false);
  }

  void updateUsdBalance(double value) {
    firebaseRef.update({'usdBalance': value});
    notifyListeners();
  }

  void setSnackBarContent(String snackBarContent) {
    _snackBarContent = snackBarContent;
    notifyListeners();
  }

  void sellCoin(
      {Balance? balance, double? updatedCoinPiece, double? withdrawValue}) {
    _fireService.updateCoin(
        coinTitle: balance!.coin!.coinTitle!.toLowerCase(),
        updatedCoinValue: updatedCoinPiece);
    firebaseRef.child('usdBalance').once().then((value) {
      updateUsdBalance(value.value + withdrawValue);
    });
  }

  void setListIndex(int listIndex) {
    _listIndex = listIndex;
    notifyListeners();
  }

  void setClicked(bool isClicked) {
    _isClicked = isClicked;
    notifyListeners();
  }

  void addPricesToList(double? price) {
    _pricesList.add(price!);
    notifyListeners();
  }

  void _loadMarkets() async {
    Market marketList = await _marketService.getData();
    marketList.data!.forEach((marketData) {
      firebaseRef.once().then((value) {
        List<dynamic> list =
            (value.value['balances'] as Map<dynamic, dynamic>).keys.toList();
        var values =
            (value.value['balances'] as Map<dynamic, dynamic>).values.toList();
        values.forEach((element) {
          if (list.contains(marketData.name!.toLowerCase()))
            addPricesToList(marketList
                .data![element['coinIndex']].quoteModel!.usdModel.price
                .toDouble());
        });
      });
    });
  }

  void _setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  void _setZeroBalance() {
    if (_usdBalance == 0) _zeroBalance = true;
    notifyListeners();
  }
}
