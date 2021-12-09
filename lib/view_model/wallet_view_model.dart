import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class WalletViewModel extends ChangeNotifier {
  WalletViewModel() {
    setBalances();
    setZeroBalance();
    print('Wallet View Model Constructor Called!');
  }

  final firebaseRef = FirebaseDatabase.instance.reference();
  TextEditingController _marketBuyController = TextEditingController();
  double? _usdBalance;
  double? _coinBalance;
  bool _loading = true;
  bool _zeroBalance = false;

  TextEditingController get marketBuyController => _marketBuyController;
  double get usdBalance => _usdBalance!;
  double get coinBalance => _coinBalance!;
  bool get loading => _loading;
  bool get zeroBalance => _zeroBalance;

  void setBalances() async {
    setLoading(true);
    await firebaseRef.child('balances').once().then((snapshot) {
      var map = new Map<String, dynamic>.from(snapshot.value);
      double? usdBalance = double.parse(map['usdBalance'].toString());
      double? coinBalance = double.parse(map['coinBalance'].toString());
      _usdBalance = usdBalance;
      _coinBalance = coinBalance;
      notifyListeners();
    });
    setLoading(false);
  }

  void updateUsdBalance(double value) {
    firebaseRef.child('balances').update({'usdBalance': value});
    notifyListeners();
  }

  void updateCoinBalance(double value) {
    firebaseRef.child('balances').update({'coinBalance': value});
    notifyListeners();
  }

  void setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  void setZeroBalance() {
    if (_usdBalance == 0) _zeroBalance = true;
    notifyListeners();
  }
}
