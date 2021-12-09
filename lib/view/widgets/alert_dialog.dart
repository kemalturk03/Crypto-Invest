import 'package:crypto_invest/model/balance.dart';
import 'package:crypto_invest/model/market.dart';
import 'package:crypto_invest/utilities/constants.dart';
import 'package:crypto_invest/utilities/custom_text_field.dart';
import 'package:crypto_invest/view_model/wallet_view_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

Future alertDialog(
    {required BuildContext context, Coin? market, WalletViewModel? viewModel}) {
  final firebaseRef = FirebaseDatabase.instance.reference();
  return showDialog(
    context: context,
    builder: (BuildContext? context) {
      double height = MediaQuery.of(context!).size.height;
      double width = MediaQuery.of(context).size.width;
      return AlertDialog(
        backgroundColor: grey,
        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
        title: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
              'BUY ${market!.name}',
              style:
                  TextStyle(fontSize: width / 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        content: Container(
          height: height / 7,
          width: width / 1.2,
          child: Column(
            children: [
              customTextField(height, width, viewModel!),
              const SizedBox(height: 12),
              Container(
                width: width / 4,
                child: ElevatedButton(
                    onPressed: () {
                      TextEditingController controller =
                          viewModel.marketBuyController;
                      if (controller.text.isNotEmpty) {
                        var enteredValue = double.parse(controller.text);
                        var enteredCoin =
                            enteredValue / market.quoteModel!.usdModel.price;
                        if (!viewModel.zeroBalance &&
                            enteredValue <= viewModel.usdBalance) {
                          firebaseRef.child('balances').once().then(
                            (snapshot) {
                              final balance = Balance.fromJson(snapshot.value);
                              if (balance.usd != null) {
                                var updatedUsdValue =
                                    balance.usd! - enteredValue;
                                viewModel.updateUsdBalance(updatedUsdValue);
                              }
                              if (balance.coin != null) {
                                var updatedCoinValue =
                                    balance.coin! + enteredCoin;
                                viewModel.updateCoinBalance(updatedCoinValue);
                              }
                            },
                          );
                        } else {
                          print(
                              'The value cannot be higher than your balance!');
                          ////TODO:1 showSnackBar(description: 'The value cannot be higher than your balance!');
                        }
                      } else {
                        print('The value cannot be empty!');
                        //TODO:2 showSnackBar(description: 'The value cannot be empty!');
                      }
                      controller.clear();
                      Navigator.pop(context);
                    },
                    child: Text('BUY'),
                    style: kBuyButtonStyle),
              ),
            ],
          ),
        ),
      );
    },
  );
}
