import 'package:flutter/material.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // SfCartesianChart(
        //   backgroundColor: Colors.white,
        //   series: <ChartSeries>[
        //     LineSeries(
        //         dataSource: mylist,
        //         xValueMapper: (dynamic data, _) => data.day,
        //         yValueMapper: (dynamic data, _) => data.rate,
        //         dataLabelSettings: DataLabelSettings(isVisible: true),
        //         enableTooltip: true)
        //   ],
        //   primaryXAxis:
        //       NumericAxis(edgeLabelPlacement: EdgeLabelPlacement.shift),
        //   primaryYAxis:
        //       NumericAxis(edgeLabelPlacement: EdgeLabelPlacement.shift),
        // ),
      ],
    );
  }
}
