import 'package:crypto_invest/view_model/wallet_view_model.dart';
import 'package:flutter/material.dart';

import 'components.dart';
import 'constants.dart';

Widget customTextField(
    double height,
    double width,
    WalletViewModel walletViewModel,
    String? dialogLabel,
    TextEditingController? controller,
    bool? autoOpen) {
  return Container(
    height: height / 20,
    width: width,
    margin: EdgeInsets.symmetric(horizontal: 22),
    padding: EdgeInsets.symmetric(horizontal: 22),
    decoration: textFieldBox,
    child: Row(
      children: [
        Expanded(
          child: TextField(
            autofocus: autoOpen!,
            controller: controller,
            textAlignVertical: TextAlignVertical.center,
            style: kBlackTS,
            cursorColor: grey,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'How Much You Want To $dialogLabel?',
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
