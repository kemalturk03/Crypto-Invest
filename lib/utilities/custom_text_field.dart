import 'package:crypto_invest/view_model/market_view_model.dart';
import 'package:flutter/material.dart';

import 'components.dart';
import 'constants.dart';

Widget customTextField(double height, double width, BuildContext context,
    MarketViewModel marketViewModel) {
  return Container(
    height: height / 20,
    width: width / 1.2,
    margin: EdgeInsets.symmetric(horizontal: 22),
    padding: EdgeInsets.symmetric(horizontal: 22),
    decoration: textFieldBox,
    child: Row(
      children: [
        Expanded(
          child: TextField(
            autofocus: true,
            controller: marketViewModel.marketBuyController,
            textAlignVertical: TextAlignVertical.center,
            style: kBlackTS,
            cursorColor: grey,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Bir miktar girin',
              hintStyle: kBlack54TS,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
            ),
          ),
        ),
      ],
    ),
  );
}
