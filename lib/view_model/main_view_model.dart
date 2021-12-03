import 'package:crypto_invest/view/screens/markets_screen.dart';
import 'package:crypto_invest/view/screens/options_screen.dart';
import 'package:crypto_invest/view/screens/wallet_screen.dart';
import 'package:flutter/cupertino.dart';

class MainViewModel extends ChangeNotifier {
  MainViewModel() {
    print("Main View Model Constructor Called");
  }

  List<Widget> _tabs = [
    MarketsScreen(),
    WalletScreen(),
    OptionsScreen(),
  ];
  int _currentIndex = 0;

  List<Widget> get tabs => _tabs;
  int get currentIndex => _currentIndex;

  void setCurrentIndex(int currentIndex) {
    _currentIndex = currentIndex;
    notifyListeners();
  }
}
