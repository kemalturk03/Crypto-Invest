import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_invest/model/balance.dart';
import 'package:crypto_invest/utilities/constants.dart';
import 'package:crypto_invest/view_model/wallet_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget walletCard(
    {required int index,
    required Size size,
    required String url,
    required String coinSymbol,
    required Balance balance,
    required WalletViewModel viewModel,
    required Function()? onPressed}) {
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      margin: fourPxAll,
      color: index % 2 == 0 ? Color(0xFF1F2632) : Color(0xFF12171A),
      height: size.height / 9,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(width: size.width / 30),
                  Container(
                    width: size.width / 10,
                    height: size.width / 10,
                    child: CachedNetworkImage(
                      imageUrl: url,
                      placeholder: (context, url) => customIndicator,
                      errorWidget: (context, url, error) => defaultCoinAvatar,
                    ),
                  ),
                  SizedBox(width: size.width / 35),
                  Text('$coinSymbol',
                      style: kWhiteTS.copyWith(fontSize: size.width / 15)),
                ],
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  viewModel.pricesList!.isNotEmpty
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                '${balance.coin!.coinValue!.toStringAsFixed(6)}',
                                style: kWhiteTS.copyWith(
                                    fontSize: size.width / 18)),
                            Text(
                                viewModel.pricesList!.isNotEmpty
                                    ? '\$${((viewModel.pricesList![index]) * (balance.coin!.coinValue!.toDouble())).toStringAsFixed(6)}'
                                    : '\$ ??',
                                style: kWhiteTS.copyWith(
                                    fontSize: size.width / 30)),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        )
                      : customIndicator,
                  SizedBox(width: size.width / 30),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
