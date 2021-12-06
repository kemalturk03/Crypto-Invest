import 'package:crypto_invest/model/market.dart';
import 'package:crypto_invest/view_model/market_view_model.dart';
import 'package:flutter/material.dart';

import 'crypto_card.dart';
import 'expanded_crypto_card.dart';

Widget coinListWidget(
    {required List<Coin> coins, MarketViewModel? marketViewModel}) {
  return Expanded(
    child: ListView.builder(
      shrinkWrap: true,
      itemCount: coins.length,
      itemBuilder: (context, index) {
        var coin = coins[index];

        UsdModel coinPrice = coin.quoteModel!.usdModel;
        if (marketViewModel!.isClicked && marketViewModel.listIndex == index) {
          return expandedCryptoCard(
            context: context,
            index: index,
            market: coin,
            onPressed: () {
              marketViewModel.setClicked(false);
            },
            marketData: marketViewModel.chartData,
            viewModel: marketViewModel,
          );
        }
        return cryptoCard(
          context: context,
          market: coin,
          colour: index % 2 == 0 ? Color(0xFF1F2632) : Color(0xFF12171A),
          onPressed: () {
            marketViewModel.setClicked(true);
            marketViewModel.setListIndex(index);
            marketViewModel.setChartData(coinPrice);
          },
        );
      },
    ),
  );
}
