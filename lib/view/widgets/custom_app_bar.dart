import 'package:crypto_invest/utilities/constants.dart';
import 'package:crypto_invest/view_model/wallet_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
              color: Color(0xFF12171A),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(36),
                  bottomRight: Radius.circular(36))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('The Dollar Balance:',
                  style: kBalanceTS.copyWith(
                      fontSize: size.width / 20,
                      color: Colors.yellow.shade800)),
              const SizedBox(width: 12),
              Text(
                  viewModel!.usdBalance.toString().isNotEmpty
                      ? '\$${viewModel.usdBalance} '
                      : '\$0',
                  style: kBalanceTS.copyWith(fontSize: size.width / 20)),
              const SizedBox(width: 12),
              CircleAvatar(
                backgroundColor: white,
                child: IconButton(
                    onPressed: viewModel.setBalances,
                    icon: Icon(Icons.refresh, color: Colors.yellow.shade800)),
              )
            ],
          ),
        ),
      ],
    ),
  );
}
