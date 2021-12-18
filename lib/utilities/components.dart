import 'dart:ui';

import 'package:crypto_invest/model/market.dart';
import 'package:crypto_invest/view_model/wallet_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'constants.dart';

String get nowToString {
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat("dd/MM/yyyy HH:mm:ss");

  return formatter.format(now);
}

double coinPriceCalculator(UsdModel coinPrice, dynamic percentage) {
  var currentPrice = coinPrice.price.toDouble();
  return currentPrice -
      (currentPrice - (currentPrice / (1 + (percentage / 100))));
}

BoxDecoration get textFieldBox => BoxDecoration(
      color: white,
      borderRadius: BorderRadius.circular(18),
      boxShadow: [
        BoxShadow(
            blurRadius: 1.0,
            offset: Offset(2, 7),
            color: black.withOpacity(0.15))
      ],
    );

ScaffoldFeatureController showSnackBar(
    {required BuildContext context, required String description}) {
  double width = MediaQuery.of(context).size.width;
  return ScaffoldMessenger.of(context)
      .showSnackBar(customSnackBar(description: description, width: width));
}

SnackBar customSnackBar({required String description, required double width}) {
  return SnackBar(
    content: Text(
      '$description',
      style: kWhiteTS.copyWith(
          color: Colors.yellow.shade800, fontSize: width / 25),
      textAlign: TextAlign.center,
    ),
    backgroundColor: black,
    behavior: SnackBarBehavior.floating,
    shape: StadiumBorder(),
    dismissDirection: DismissDirection.horizontal,
  );
}

Widget walletScreenAppBar({
  WalletViewModel? viewModel,
  Size? size,
}) {
  return StreamBuilder(
      stream: viewModel!.firebaseRef.child('usdBalance').onValue,
      builder: (context, AsyncSnapshot? snapshot) {
        if (snapshot!.hasData) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('The Dollar Balance:',
                  style: kBalanceTS.copyWith(
                      fontSize: size!.width / 20,
                      color: Colors.yellow.shade800)),
              const SizedBox(width: 12),
              Text(
                  '\$${double.parse(snapshot.data.snapshot.value.toString()).toStringAsFixed(3)}',
                  style: kBalanceTS.copyWith(fontSize: size.width / 20)),
            ],
          );
        }
        return customIndicator;
      });
}

Widget optionScreenAppBar(size) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text('Top Up Your Balance',
          style: kBalanceTS.copyWith(
              fontSize: size.width / 20, color: Colors.yellow.shade800)),
    ],
  );
}
