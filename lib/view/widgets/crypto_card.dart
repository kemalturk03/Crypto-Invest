import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_invest/model/market.dart';
import 'package:crypto_invest/utilities/constants.dart';
import 'package:flutter/material.dart';

Widget cryptoCard(
    {required BuildContext context,
    Coin? market,
    Function()? onPressed,
    Color? colour}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      color: colour,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width / 10,
            height: MediaQuery.of(context).size.width / 10,
            child: CachedNetworkImage(
              imageUrl: (iconUrl + '${market!.symbol!.toLowerCase()}' + '.png'),
              placeholder: (context, url) => CircularProgressIndicator(),
              errorWidget: (context, url, error) => CircleAvatar(
                  child: Icon(Icons.attach_money, color: Colors.white)),
            ),
          ),
          const SizedBox(width: 12),
          Row(
            children: [
              Text(
                '${market.symbol}',
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
              const SizedBox(width: 12),
              market.quoteModel!.usdModel.percentChange_1h > 0
                  ? Icon(Icons.arrow_upward, color: Colors.green)
                  : Icon(Icons.arrow_downward, color: Colors.red),
              const SizedBox(width: 6),
              Text(
                '${market.quoteModel!.usdModel.percentChange_1h.toDouble().toStringAsFixed(2).replaceAll('-', '')}',
                style: TextStyle(
                    color: market.quoteModel!.usdModel.percentChange_1h > 0
                        ? Colors.green
                        : Colors.red,
                    fontSize: 18),
              )
            ],
          ),
        ],
      ),
      height: MediaQuery.of(context).size.height / 8,
    ),
  );
}
