import 'dart:ui';

import 'package:crypto_invest/model/market.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'constants.dart';

int get nowToInt {
  DateTime now = DateTime.now();
  DateFormat formatter = DateFormat("ss");
  String formattedTime = formatter.format(now);
  return int.parse(formattedTime);
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
