import 'package:crypto_invest/utilities/components.dart';
import 'package:firebase_database/firebase_database.dart';

class FirebaseService {
  final firebaseRef = FirebaseDatabase.instance.reference();

  void generateCoin({
    String? coinTitle,
    String? coinSymbol,
    double? coinValue,
    int? coinIndex,
  }) {
    var map = {
      'time': nowToString,
      'value': coinValue!,
      'symbol': coinSymbol!,
      'title': coinTitle,
      'coinIndex': coinIndex,
    };
    firebaseRef
        .child('balances')
        .child(coinTitle!.toLowerCase())
        .set(map, priority: nowToString);
  }

  void updateCoin({String? coinTitle, double? updatedCoinValue}) {
    firebaseRef.child('balances').child(coinTitle!.toLowerCase()).update(
      {
        'value': updatedCoinValue,
        'time': nowToString,
      },
    );
  }
}
