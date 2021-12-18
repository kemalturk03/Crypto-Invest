import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_invest/model/market.dart';
import 'package:crypto_invest/utilities/constants.dart';
import 'package:flutter/material.dart';

Widget cryptoCard(
    {required BuildContext context,
    Coin? market,
    Function()? onPressed,
    Color? colour}) {
  Size size = MediaQuery.of(context).size;
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      height: size.height / 8,
      color: colour,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 10,
            height: MediaQuery.of(context).size.width / 10,
            child: CachedNetworkImage(
              imageUrl: (iconUrl + '${market!.symbol!.toLowerCase()}' + '.png'),
              placeholder: (context, url) => customIndicator,
              errorWidget: (context, url, error) => defaultCoinAvatar,
            ),
          ),
          SizedBox(width: size.width / 35),
          Text(
            '${market.symbol}',
            style: TextStyle(color: white, fontSize: size.width / 20),
          ),
          SizedBox(width: size.width / 35),
          market.quoteModel!.usdModel.percentChange_1h > 0
              ? Icon(Icons.arrow_upward, color: green)
              : Icon(Icons.arrow_downward, color: red),
          SizedBox(width: size.width / 45),
          Text(
            '${market.quoteModel!.usdModel.percentChange_1h.toDouble().toStringAsFixed(2).replaceAll('-', '')}',
            style: TextStyle(
                color: market.quoteModel!.usdModel.percentChange_1h > 0
                    ? green
                    : red,
                fontSize: size.width / 22),
          ),
        ],
      ),
    ),
  );
}
