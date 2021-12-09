import 'package:crypto_invest/utilities/constants.dart';
import 'package:crypto_invest/view_model/wallet_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

Widget customAppBar(BuildContext context, WalletViewModel? viewModel) {
  Size size = MediaQuery.of(context).size;
  return Container(
    height: size.height / 9.5,
    child: Stack(
      children: [
        Container(
          padding: EdgeInsets.only(
              left: size.width / 18.75,
              bottom: size.width / 24,
              top: size.width / 30),
          height: size.height / 5 - 20,
          decoration: BoxDecoration(
              color: red,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(36),
                  bottomRight: Radius.circular(36))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    child:
                        Icon(Ionicons.wallet_outline, color: black, size: 34),
                    radius: 28,
                    backgroundColor: white,
                  ),
                  const SizedBox(width: 8),
                  Text('Wallet', style: kProductHeaderTS),
                  const SizedBox(width: 8),
                ],
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Text('Coin',
                          style:
                              kBalanceTS.copyWith(fontSize: size.width / 20)),
                      Text(
                          viewModel!.coinBalance.toString().isNotEmpty
                              ? '${viewModel.coinBalance.toStringAsFixed(4)} BTC'
                              : '0',
                          style:
                              kBalanceTS.copyWith(fontSize: size.width / 20)),
                    ],
                  ),
                  const SizedBox(width: 16),
                ],
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Text('USD',
                          style:
                              kBalanceTS.copyWith(fontSize: size.width / 20)),
                      Row(
                        children: [
                          Icon(CupertinoIcons.money_dollar,
                              size: size.width / 20, color: white),
                          Text(
                              viewModel.usdBalance.toString().isNotEmpty
                                  ? '${viewModel.usdBalance}'
                                  : '0',
                              style: kBalanceTS.copyWith(
                                  fontSize: size.width / 20)),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(width: 16),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
