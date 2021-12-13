import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_invest/model/balance.dart';
import 'package:crypto_invest/model/chart_data.dart';
import 'package:crypto_invest/model/market.dart';
import 'package:crypto_invest/service/firebase_service.dart';
import 'package:crypto_invest/utilities/components.dart';
import 'package:crypto_invest/utilities/constants.dart';
import 'package:crypto_invest/view/widgets/alert_dialog.dart';
import 'package:crypto_invest/view_model/market_view_model.dart';
import 'package:crypto_invest/view_model/wallet_view_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

Widget expandedCryptoCard(
    {required BuildContext context,
    required int listIndex,
    required Coin? market,
    Function()? onPressed,
    List<ChartData>? marketData,
    MarketViewModel? viewModel}) {
  final _firebaseRef = FirebaseDatabase.instance.reference();
  final _firebaseService = FirebaseService();
  Size size = MediaQuery.of(context).size;
  return Consumer<WalletViewModel>(
    builder: (context, walletVM, vmIndex) => Container(
      height: size.height / 1.8,
      color: listIndex % 2 == 0 ? Color(0xFF1F2632) : Color(0xFF12171A),
      child: Column(
        children: [
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: size.width / 10,
                height: size.width / 10,
                child: CachedNetworkImage(
                  imageUrl:
                      (iconUrl + '${market!.symbol!.toLowerCase()}' + '.png'),
                  placeholder: (context, url) => customIndicator,
                  errorWidget: (context, url, error) => defaultCoinAvatar,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '${market.symbol}',
                style: TextStyle(color: white, fontSize: 22),
              ),
              const SizedBox(width: 12),
              market.quoteModel!.usdModel.percentChange_1h > 0
                  ? Icon(Icons.arrow_upward, color: green)
                  : Icon(Icons.arrow_downward, color: red),
              const SizedBox(width: 6),
              Text(
                '${market.quoteModel!.usdModel.percentChange_1h.toDouble().toStringAsFixed(2).replaceAll('-', '')}',
                style: TextStyle(
                    color: market.quoteModel!.usdModel.percentChange_1h > 0
                        ? green
                        : red,
                    fontSize: 18),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: SfCartesianChart(
              plotAreaBorderWidth: 0,
              legend: Legend(
                  isVisible: true,
                  position: LegendPosition.bottom,
                  textStyle: TextStyle(color: white)),
              primaryXAxis:
                  CategoryAxis(edgeLabelPlacement: EdgeLabelPlacement.shift),
              primaryYAxis: NumericAxis(
                  numberFormat: NumberFormat.simpleCurrency(decimalDigits: 2)),
              tooltipBehavior: viewModel!.tooltipBehaviour,
              series: <ChartSeries<ChartData, String>>[
                LineSeries<ChartData, String>(
                  trendlines: [
                    Trendline(
                        name: 'Average',
                        color: red,
                        type: TrendlineType.polynomial,
                        markerSettings: MarkerSettings(isVisible: true))
                  ],
                  markerSettings: MarkerSettings(isVisible: true),
                  color: white,
                  name: '${market.name}',
                  dataSource: marketData!,
                  xValueMapper: (ChartData sales, _) {
                    switch (sales.year) {
                      case 24:
                        {
                          return '24H';
                        }
                      case 1:
                        {
                          return '1H';
                        }
                      case 0:
                        {
                          return 'Now';
                        }
                    }
                    return '${sales.year}D';
                  },
                  yValueMapper: (ChartData sales, _) => sales.value,
                  enableTooltip: true,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: size.width / 3.5,
                child: ElevatedButton(
                    onPressed: () {
                      alertDialog(
                        context: context,
                        coinTitle: market.name,
                        viewModel: walletVM,
                        dialogLabel: 'Buy',
                        controller: walletVM.buyController,
                        buttonStyle: kBuyButtonStyle,
                        onPressed: () async {
                          var controller = walletVM.buyController;
                          if (controller.text.isNotEmpty) {
                            var enteredValue = double.parse(controller.text);
                            var enteredCoin = enteredValue /
                                market.quoteModel!.usdModel.price;
                            if (!walletVM.zeroBalance &&
                                enteredValue <= walletVM.usdBalance) {
                              _firebaseRef.once().then(
                                (snapshot) {
                                  Iterable existedCoins =
                                      (snapshot.value['balances']
                                              as Map<dynamic, dynamic>)
                                          .keys;
                                  Balance balance = Balance.fromJson(
                                      snapshot.value,
                                      market.name!.toLowerCase());
                                  if (balance.usd != null) {
                                    print(balance.usd);
                                    var updatedUsdValue =
                                        balance.usd! - enteredValue;
                                    walletVM.updateUsdBalance(updatedUsdValue);
                                  }
                                  if (existedCoins
                                      .contains(market.name!.toLowerCase())) {
                                    _firebaseService.updateCoin(
                                      coinTitle: market.name,
                                      updatedCoinValue: enteredCoin +
                                          balance.coin!.coinValue!.toDouble(),
                                    );
                                  } else {
                                    _firebaseService.generateCoin(
                                      coinTitle: market.name,
                                      coinSymbol: market.symbol,
                                      coinValue: enteredCoin,
                                      coinIndex: listIndex,
                                    );
                                  }
                                },
                              );
                              viewModel.setSnackBarContent('Successful');
                            } else {
                              viewModel.setSnackBarContent(
                                  'The value cannot be higher than your balance!');
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
                    child: Text('BUY'),
                    style: kBuyButtonStyle),
              ),
              const SizedBox(width: 12),
              Container(
                width: size.width / 3.5,
                child: ElevatedButton(
                  onPressed: onPressed,
                  child: Text('CLOSE'),
                  style: kSellButtonStyle,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
    ),
  );
}
