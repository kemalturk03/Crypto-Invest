import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_invest/model/balance.dart';
import 'package:crypto_invest/utilities/components.dart';
import 'package:crypto_invest/utilities/constants.dart';
import 'package:crypto_invest/view_model/wallet_view_model.dart';
import 'package:flutter/material.dart';

import 'alert_dialog.dart';

Widget largeWalletCard(
    {required BuildContext context,
    required int index,
    required Size size,
    required String url,
    required String coinSymbol,
    required Balance balance,
    required WalletViewModel viewModel,
    required Function()? onPressed}) {
  Size size = MediaQuery.of(context).size;
  var marketData = ((viewModel.pricesList![index]));
  var currentCoinPiece = (balance.coin!.coinValue!.toDouble());
  var calculatedDollar = marketData * currentCoinPiece;
  return GestureDetector(
    onTap: onPressed,
    child: Container(
      margin: fourPxAll,
      color: index % 2 == 0 ? Color(0xFF1F2632) : Color(0xFF12171A),
      height: size.height / 7,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.width / 35),
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
              SizedBox(height: size.width / 28),
              Row(
                children: [
                  SizedBox(width: size.width / 30),
                  Text('DATE PURCHASED: ${balance.coin!.time}',
                      style: kWhiteTS.copyWith(fontSize: size.width / 40)),
                ],
              ),
              SizedBox(height: size.width / 35),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: size.width / 35),
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
                                    ? '\$${calculatedDollar.toStringAsFixed(6)}'
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
              SizedBox(height: size.width / 35),
              Row(
                children: [
                  Container(
                    width: size.width / 5,
                    height: size.height / 23,
                    child: ElevatedButton(
                      onPressed: () {
                        var dollarToCoin = calculatedDollar / marketData;
                        var updatedCoinPiece = currentCoinPiece - dollarToCoin;
                        viewModel.sellCoin(
                            balance: balance,
                            updatedCoinPiece: updatedCoinPiece,
                            withdrawValue: calculatedDollar);
                        viewModel.setSnackBarContent('Successfully Sold');
                        showSnackBar(
                            context: context,
                            description: viewModel.snackBarContent);
                      },
                      child: Text('SELL ALL',
                          style: kBlackTS.copyWith(fontSize: size.width / 40)),
                      style: kYellowButtonStyle,
                    ),
                  ),
                  SizedBox(width: size.width / 40),
                  Container(
                    width: size.width / 5,
                    height: size.height / 23,
                    child: ElevatedButton(
                      onPressed: () {
                        alertDialog(
                          context: context,
                          coinTitle: balance.coin!.coinTitle,
                          viewModel: viewModel,
                          dialogLabel: 'Sell',
                          controller: viewModel.sellController,
                          buttonStyle: kYellowButtonStyle,
                          onPressed: () async {
                            var controller = viewModel.sellController;
                            if (controller.text.isNotEmpty) {
                              var withDrawValue = double.parse(controller.text);
                              var dollarToCoin = withDrawValue / marketData;
                              var updatedCoinPiece =
                                  currentCoinPiece - dollarToCoin;
                              if (withDrawValue < 0) {
                                viewModel.setSnackBarContent(
                                    'The value must be higher than 0');
                              } else if (withDrawValue > calculatedDollar) {
                                viewModel.setSnackBarContent(
                                    'The value cannot be higher than total balance!');
                              } else {
                                print("total: $calculatedDollar");
                                viewModel.sellCoin(
                                    balance: balance,
                                    updatedCoinPiece: updatedCoinPiece,
                                    withdrawValue: withDrawValue);
                                viewModel
                                    .setSnackBarContent('Successfully Sold');
                              }
                            } else {
                              viewModel.setSnackBarContent(
                                  'The value cannot be empty!');
                            }
                            controller.clear();
                            Navigator.pop(context);
                            await Future.delayed(Duration(milliseconds: 300));
                            showSnackBar(
                                context: context,
                                description: viewModel.snackBarContent);
                          },
                        );
                      },
                      child: Text('SELL SOME',
                          style: kBlackTS.copyWith(fontSize: size.width / 40)),
                      style: kYellowButtonStyle,
                    ),
                  ),
                  SizedBox(width: size.width / 35),
                ],
              ),
              SizedBox(height: size.width / 50),
            ],
          ),
        ],
      ),
    ),
  );
}
