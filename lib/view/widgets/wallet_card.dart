import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_invest/model/balance.dart';
import 'package:crypto_invest/utilities/constants.dart';
import 'package:crypto_invest/view_model/wallet_view_model.dart';
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
      height: size.height / 10,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const SizedBox(width: 16),
              Container(
                width: size.width / 10,
                height: size.width / 10,
                child: CachedNetworkImage(
                  imageUrl: url,
                  placeholder: (context, url) => customIndicator,
                  errorWidget: (context, url, error) => defaultCoinAvatar,
                ),
              ),
              const SizedBox(width: 12),
              Text('$coinSymbol',
                  style: kWhiteTS.copyWith(fontSize: size.width / 15)),
            ],
          ),
          Row(
            children: [
              viewModel.pricesList!.isNotEmpty
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('${balance.coin!.coinValue!.toStringAsFixed(3)}',
                            style:
                                kWhiteTS.copyWith(fontSize: size.width / 18)),
                        Text(
                            viewModel.pricesList!.isNotEmpty
                                ? '\$${((viewModel.pricesList![index]) * (balance.coin!.coinValue!.toDouble())).toStringAsFixed(2)}'
                                : '\$ ??',
                            style:
                                kWhiteTS.copyWith(fontSize: size.width / 30)),
                      ],
                      crossAxisAlignment: CrossAxisAlignment.start,
                    )
                  : customIndicator,
              const SizedBox(width: 16),
            ],
          ),
        ],
      ),
    ),
  );
}
