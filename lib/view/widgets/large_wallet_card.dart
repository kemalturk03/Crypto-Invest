import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_invest/model/balance.dart';
import 'package:crypto_invest/utilities/components.dart';
import 'package:crypto_invest/utilities/constants.dart';
import 'package:crypto_invest/view/widgets/alert_dialog.dart';
import 'package:crypto_invest/view_model/wallet_view_model.dart';
import 'package:flutter/material.dart';

Widget largeWalletCard(
    {required BuildContext context,
    required int index,
    required Size size,
    required String url,
    required String coinSymbol,
    required Balance balance,
    required WalletViewModel viewModel}) {
  var marketData = ((viewModel.pricesList![index]));
  var currentCoinPiece = (balance.coin!.coinValue!.toDouble());
  var calculatedDollar = marketData * currentCoinPiece;
  return Container(
    margin: fourPxAll,
    color: index % 2 == 0 ? Color(0xFF1F2632) : Color(0xFF12171A),
    height: size.height / 6.3,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
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
            const SizedBox(height: 12),
            Row(
              children: [
                const SizedBox(width: 16),
                Text('DATE PURCHASED: ${balance.coin!.time}',
                    style: kWhiteTS.copyWith(fontSize: 14)),
              ],
            ),
            const SizedBox(height: 12),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(height: 12),
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
                                  ? '\$${calculatedDollar.toStringAsFixed(2)}'
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
            const SizedBox(height: 12),
            Row(
              children: [
                Container(
                  width: size.width / 6,
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
                          if (controller.text.isNotEmpty &&
                              currentCoinPiece != 0) {
                            var withDrawValue = double.parse(controller.text);
                            var dollarToCoin = withDrawValue / marketData;
                            var updatedCoinPiece =
                                currentCoinPiece - dollarToCoin;
                            if (withDrawValue <=
                                calculatedDollar.floorToDouble()) {
                              viewModel.sellCoin(
                                  balance: balance,
                                  updatedCoinPiece: updatedCoinPiece,
                                  withdrawValue: withDrawValue);
                              viewModel.setSnackBarContent('Successfully Sold');
                            } else {
                              viewModel.setSnackBarContent(
                                  'The value cannot be higher than total balance!');
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
                    child: Text('SELL', style: kBlackTS),
                    style: kYellowButtonStyle,
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),
            const SizedBox(height: 4),
          ],
        ),
      ],
    ),
  );
}
