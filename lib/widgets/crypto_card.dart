import 'package:crypto_font_icons/crypto_font_icons.dart';
import 'package:flutter/material.dart';

Widget cryptoCard(
    {required BuildContext context,
    String? currency,
    Function()? onPressed,
    Color? colour}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      color: colour,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(CryptoFontIcons.BTC_ALT, color: Colors.yellow[800]),
          const SizedBox(width: 8),
          Text(
            '$currency / USD',
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
        ],
      ),
      height: MediaQuery.of(context).size.height / 8,
    ),
  );
}
