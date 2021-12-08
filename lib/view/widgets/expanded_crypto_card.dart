import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_invest/model/chart_data.dart';
import 'package:crypto_invest/model/market.dart';
import 'package:crypto_invest/utilities/constants.dart';
import 'package:crypto_invest/view/widgets/alert_dialog.dart';
import 'package:crypto_invest/view_model/market_view_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

Widget expandedCryptoCard(
    {required BuildContext context,
    required int index,
    required Coin? market,
    Function()? onPressed,
    List<ChartData>? marketData,
    MarketViewModel? viewModel}) {
  return Container(
    height: MediaQuery.of(context).size.height / 1.8,
    color: index % 2 == 0 ? Color(0xFF1F2632) : Color(0xFF12171A),
    child: Column(
      children: [
        const SizedBox(height: 14),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 10,
              height: MediaQuery.of(context).size.width / 10,
              child: CachedNetworkImage(
                imageUrl:
                    (iconUrl + '${market!.symbol!.toLowerCase()}' + '.png'),
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => CircleAvatar(
                    backgroundColor: lightBlue,
                    child: Icon(Icons.attach_money, color: white)),
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
                width: MediaQuery.of(context).size.width / 3.5,
                child: ElevatedButton(
                    onPressed: () async {
                      var current = market.quoteModel!.usdModel;
                      await alertDialog(
                          context: context,
                          title: market.name,
                          viewModel: viewModel);
                      // print(
                      //     'Current Price: $current\nBalance: ${viewModel.usdBalance}\n');
                      // viewModel.setBalance(-100);
                      // viewModel.setCoinBalance(100 / current);
                      // print('USD Balance: ${viewModel.usdBalance}');
                      // print('Coin Balance: ${viewModel.coinBalance}');
                    },
                    child: Text('BUY'),
                    style: kBuyButtonStyle)),
            const SizedBox(width: 12),
            Container(
              width: MediaQuery.of(context).size.width / 3.5,
              child: ElevatedButton(
                onPressed: () {},
                child: Text('SELL'),
                style: kSellButtonStyle,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
      ],
    ),
  );
}

final kSellButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Colors.red.shade700),
    shape: MaterialStateProperty.all(StadiumBorder()));

final kBuyButtonStyle = ButtonStyle(
    backgroundColor: MaterialStateProperty.all(Colors.green.shade500),
    shape: MaterialStateProperty.all(StadiumBorder()));
