import 'package:cached_network_image/cached_network_image.dart';
import 'package:crypto_invest/model/chart_data.dart';
import 'package:crypto_invest/model/market.dart';
import 'package:crypto_invest/utilities/constants.dart';
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
                    backgroundColor: Colors.lightBlue,
                    child: Icon(Icons.attach_money, color: Colors.white)),
              ),
            ),
            const SizedBox(width: 12),
            Text(
              '${market.symbol}',
              style: TextStyle(color: Colors.white, fontSize: 22),
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
                textStyle: TextStyle(color: Colors.white)),
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
                      color: Colors.red,
                      type: TrendlineType.polynomial,
                      markerSettings: MarkerSettings(isVisible: true))
                ],
                markerSettings: MarkerSettings(isVisible: true),
                color: Colors.white,
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
      ],
    ),
  );
}
